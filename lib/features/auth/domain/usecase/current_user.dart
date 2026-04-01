import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/entity/Auth_entity.dart';
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart';

@injectable
class CurrentUser {
  AuthRepository authRepository;
  CurrentUser(this.authRepository);

  Future<Either<Failures, AuthEntity?>> call() async {
    return await authRepository.getCurrentUser();
  }
}
