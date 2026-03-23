import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart';

@injectable
class LogoutUser {
  AuthRepository authRepository;
  LogoutUser(this.authRepository);

  Future<Either<Failures, void>> call() async {
    return await authRepository.signOut();
  }
}
