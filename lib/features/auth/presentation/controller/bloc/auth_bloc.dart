import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:lux_estate/features/auth/domain/usecase/current_user.dart';
import 'package:lux_estate/features/auth/domain/usecase/user_login.dart';
import 'package:lux_estate/features/auth/domain/usecase/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required CurrentUser currentUser,
  }) : _userLogin = userLogin,
       _userSignUp = userSignUp,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<UserLoginEvent>(_onUserLogin);
    on<UserSignUpEvent>(_onUserSignUp);
    on<UserLogoutEvent>(_onUserLogout);
  }

  FutureOr<void> _onUserLogin(
    UserLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _userLogin
        .call(email: event.email, password: event.password)
        .then(
          (value) => value.fold(
            (l) => emit(AuthFailure(l.message!)),
            (user) => emit(AuthSuccess(user!)),
          ),
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
          (value) => value.fold(
            (l) => emit(AuthFailure(l.message!)),
            (user) => emit(AuthSuccess(user!)),
          ),
        );
  }

  FutureOr<void> _onUserLogout(
    UserLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _currentUser.call().then(
      (value) => value.fold(
        (l) => emit(AuthFailure(l.message!)),
        (r) => emit(AuthInitial()),
      ),
    );
  }
}
