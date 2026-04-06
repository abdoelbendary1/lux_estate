import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // .stream() listens for changes automatically
        stream: supabase
            .from('messages')
            .stream(primaryKey: ['id'])
            .order('created_at', ascending: false),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final messages = snapshot.data!;
          return ListView.builder(
            reverse: true, // Newest messages at the bottom
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index]['content']),
                subtitle: Text(messages[index]['user_id']),
              );
            },
          );
        },
      ),
    );
  }
}
