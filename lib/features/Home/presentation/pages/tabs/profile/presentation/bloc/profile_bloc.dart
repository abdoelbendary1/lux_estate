import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/entity/profile_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/usecase/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfileUseCase;
  ProfileBloc({required GetProfile getProfileUseCase})
    : _getProfileUseCase = getProfileUseCase,
      super(ProfileState.initial()) {
    on<FetchProfileEvent>(_onFetchProfileEvent);
    on<LogoutEvent>((event, emit) {
      emit(ProfileState.initial());
    });
  }

  FutureOr<void> _onFetchProfileEvent(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(asyncState: DataLoading()));
    final result = await _getProfileUseCase.call(event.userId);
    result.fold(
      (l) => emit(state.copyWith(asyncState: DataFailed(l.message!))),
      (profile) => emit(state.copyWith(asyncState: DataSuccess(profile))),
    );
  }
}
