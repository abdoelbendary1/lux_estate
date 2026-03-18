import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart';

class CurrentUser {
  AuthRepository authRepository;
  CurrentUser(this.authRepository);

  Future<Either<Failures, UserEntity?>> call() async {
    return await authRepository.getCurrentUser();
  }
}
