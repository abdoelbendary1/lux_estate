import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:lux_estate/features/auth/domain/usecase/current_user.dart';
import 'package:lux_estate/features/auth/domain/usecase/logout_user.dart';
import 'package:lux_estate/features/auth/domain/usecase/user_login.dart';
import 'package:lux_estate/features/auth/domain/usecase/user_sign_up.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  final CurrentUser _currentUser;
  final LogoutUser _logoutUser;

  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required CurrentUser currentUser,
    required LogoutUser logoutUser,
  }) : _userLogin = userLogin,
       _userSignUp = userSignUp,
       _currentUser = currentUser,
       _logoutUser = logoutUser,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<UserLoginEvent>(
      _onUserLogin,
      transformer:
          droppable(), // This is the magic line that makes the event handling droppable
    );

    on<UserSignUpEvent>(_onUserSignUp, transformer: droppable());
    on<UserLogoutEvent>(_onUserLogout);
  }

  FutureOr<void> _onUserLogin(
    UserLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _userLogin
        .call(email: event.email, password: event.password)
        .then(
          (value) => value.fold((l) => emit(AuthFailure(l.message!)), (user) {
            getIt<SessionCubit>().updateSession(user);
            emit(AuthSuccess(user!));
          }),
        );
  }

  FutureOr<void> _onUserSignUp(
    UserSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _userSignUp
        .call(
          email: event.email,
          password: event.password,
          fullName: event.fullName,
        )
        .then(
          (value) => value.fold((l) => emit(AuthFailure(l.message!)), (user) {
            getIt<SessionCubit>().updateSession(user);
            emit(AuthSuccess(user!));
          }),
        );
  }

  FutureOr<void> _onUserLogout(
    UserLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUser.call().then(
      (value) => value.fold(
        (l) => emit(AuthFailure(l.message!)),
        (r) {
          getIt<SessionCubit>().clearSession();
          emit(AuthInitial());
        },
      ),
    );
  }
}
