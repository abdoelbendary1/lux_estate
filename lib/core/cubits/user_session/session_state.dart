part of 'session_cubit.dart';

@immutable
sealed class SessionState {}

final class SessionInitial extends SessionState {}
final class SessionAuthenticated extends SessionState {
  final UserEntity user;

  SessionAuthenticated(this.user);
}
final class SessionUnauthenticated extends SessionState {}

