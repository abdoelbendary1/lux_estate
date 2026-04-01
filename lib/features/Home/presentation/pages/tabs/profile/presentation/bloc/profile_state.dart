part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.asyncState});
  final AsyncState<ProfileEntity> asyncState;
  ProfileState.initial() : asyncState = DataInitial();
  ProfileState copyWith({AsyncState<ProfileEntity>? asyncState}) {
    return ProfileState(asyncState: asyncState ?? this.asyncState);
  }

  @override
  List<Object> get props => [asyncState];
}
