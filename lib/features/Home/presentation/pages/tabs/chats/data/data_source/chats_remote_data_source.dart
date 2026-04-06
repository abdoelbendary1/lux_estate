import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChatsRemoteDataSource {
  Future<void> sendMessage(String text);
  Future<List<Map<String, dynamic>>> getMyChats();
  Future<String> getOrCreateRoom(String otherUserId);
  Future<String> startChatWithUser(String otherUserId);
}

@LazySingleton(as: ChatsRemoteDataSource)
class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final supabase = Supabase.instance.client;
  @override
  Future<void> sendMessage(String text) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('messages').insert({
      'content': text,
      'user_id': user.id,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getMyChats() async {
    final myUserId = supabase.auth.currentUser!.id;

    // Fetch rooms I'm part of, including the metadata of OTHER participants
    final response = await supabase
        .from('participants')
        .select('''
        room_id,
        rooms (
          last_message,
          participants (
            user_id,
            profiles (username, avatar_url)
          )
        )
      ''')
        .eq('user_id', myUserId);

    return response;
  }

  @override
  Future<String> startChatWithUser(String otherUserId) async {
    try {
      // .rpc() calls the SQL function you just created
      // The key 'other_user_id' must match the parameter name in your SQL
      final String roomId = await Supabase.instance.client.rpc(
        'get_or_create_room',
        params: {'other_user_id': otherUserId},
      );

      return roomId;
    } on PostgrestException catch (error) {
      // Handle database-specific errors
      print('DB Error: ${error.message}');
      rethrow;
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      rethrow;
    }
  }

  @override
  Future<String> getOrCreateRoom(String otherUserId) async {
    final myUserId = supabase.auth.currentUser!.id;

    // 1. Check if a room already exists between these two users
    // We fetch participants for the current user and join the room's other participants
    final existingRooms = await supabase
        .from('participants')
        .select('room_id')
        .eq('user_id', myUserId);

    if (existingRooms.isNotEmpty) {
      for (var room in existingRooms) {
        final roomId = room['room_id'];

        // Check if the other person is also in this specific room
        final otherParticipant = await supabase
            .from('participants')
            .select()
            .eq('room_id', roomId)
            .eq('user_id', otherUserId)
            .maybeSingle();

        if (otherParticipant != null) {
          return roomId; // Room found! Return it.
        }
      }
    }

    // 2. If no room was found, create a new one
    final newRoom = await supabase.from('rooms').insert({}).select().single();
    final newRoomId = newRoom['id'];

    // 3. Add both users to the participants table
    await supabase.from('participants').insert([
      {'room_id': newRoomId, 'user_id': myUserId},
      {'room_id': newRoomId, 'user_id': otherUserId},
    ]);

    return newRoomId;
  }
}
