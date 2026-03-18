import 'package:lux_estate/core/error/app_exceptions.dart';
import 'package:lux_estate/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  SupabaseClient get _client => Supabase.instance.client;
  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'fullName': fullName},
    );
    if (response.user == null) {
      return throw ServerException('Sign-up failed: No user returned');
    }
    final user = UserModel.fromJson(response.user!.toJson());
    return user;
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      return throw ServerException('Sign-in failed: No user returned');
    }
    final user = UserModel.fromJson(response.user!.toJson());
    return user;
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final session = _client.auth.currentSession;
    if (session == null) {
      return throw ServerException('No current user');
    }

    final user = UserModel.fromJson(session.user.toJson());
    return user;
  }
}
