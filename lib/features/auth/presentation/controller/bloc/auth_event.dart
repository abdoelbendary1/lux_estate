part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthCheckRequested extends AuthEvent {} // New event for auto-login

final class UserLoginEvent extends AuthEvent {
  final String email;
  final String password;

  UserLoginEvent({required this.email, required this.password});
}

final class UserLogoutEvent extends AuthEvent {}

final class UserSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  UserSignUpEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });
}
