part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  final String userId;

  const FetchProfileEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class LogoutEvent extends ProfileEvent {}