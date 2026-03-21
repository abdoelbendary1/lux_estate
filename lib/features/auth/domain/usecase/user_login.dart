import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart';

@injectable
class UserLogin {
  AuthRepository authRepository;

  UserLogin({required this.authRepository});

  Future<Either<Failures, UserEntity?>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.signIn(email: email, password: password);
  }
}
