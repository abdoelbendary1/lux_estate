import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserEntity?>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failures, UserEntity?>> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<Either<Failures, void>> signOut();
  Future<Either<Failures, UserEntity?>> getCurrentUser();
}
