import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/entity/Auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, AuthEntity?>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failures, AuthEntity?>> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<Either<Failures, void>> signOut();
  Future<Either<Failures, AuthEntity?>> getCurrentUser();
}
