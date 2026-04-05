import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/features/auth/domain/entity/Auth_entity.dart';
import 'package:lux_estate/features/auth/domain/usecase/current_user.dart';
import 'package:meta/meta.dart';

part 'session_state.dart';

@singleton
class SessionCubit extends Cubit<SessionState> {
  final CurrentUser _currentUser;

  SessionCubit(this._currentUser) : super(SessionInitial());

  // Called at app startup
  Future<void> initializeSession() async {
    final result = await _currentUser.call();
    result.fold((l) => emit(SessionUnauthenticated()), (user) {
      if (user != null) {
        emit(SessionAuthenticated(user));
      } else {
        emit(SessionUnauthenticated());
      }
    });
  }

  // Getter بيجيب الـ ID لو المستخدم مسجل دخول
  String? get currentUserId {
    final currentState = state;
    if (currentState is SessionAuthenticated) {
      return currentState.user.id;
    }
    return null;
  }

  void updateSession(AuthEntity? user) {
    if (user != null) {
      emit(SessionAuthenticated(user));
    } else {
      emit(SessionUnauthenticated());
    }
  }

  Future<void> clearSession() async {
    emit(SessionUnauthenticated());
  }
}
