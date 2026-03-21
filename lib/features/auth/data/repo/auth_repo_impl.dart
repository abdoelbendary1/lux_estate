import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/app_exceptions.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

@LazySingleton(as: AuthRepository)
class AuthRepoImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failures, UserEntity?>> getCurrentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUser();
      return user != null
          ? Right(user)
          : Left(ServerFailure('No user logged in'));
    } on sb.AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failures, UserEntity?>> signIn({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      authRemoteDataSource.signIn(email: email, password: password),
    );
  }

  @override
  Future<Either<Failures, void>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return const Right(null);
    } on sb.AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failures, UserEntity?>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await _getUser(
      authRemoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      ),
    );
  }
}

Future<Either<Failures, UserEntity?>> _getUser(Future<UserEntity> fn) async {
  try {
    final user = await fn;
    return Right(user);
  } on sb.AuthException catch (e) {
    return Left(ServerFailure(e.message));
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  }
}
