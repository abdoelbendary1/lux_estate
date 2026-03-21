import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart';

@injectable
class UserSignUp {
  AuthRepository authRepository;
  UserSignUp(this.authRepository);

  Future<Either<Failures, UserEntity?>> call({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await authRepository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
