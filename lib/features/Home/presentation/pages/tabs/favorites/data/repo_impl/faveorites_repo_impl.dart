import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/data/data_source/favorites_remote_data_source.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/domain/repo/favorites_repo.dart';

@LazySingleton(as: FavoritesRepo)
class FavoritesRemoteDataSourceRepoImpl implements FavoritesRepo {
  final FavoritesRemoteDataSource remoteDataSource;
  FavoritesRemoteDataSourceRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, List<PropertyUnitEntity>>> getMyFavorites() async {
    try {
      final result = await remoteDataSource.getMyFavorites();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> toggleFavorite({
    required String propertyId,
    required String userId,
  }) async {
    // TODO: implement toggleFavorite
    try {
      final result = await remoteDataSource.toggleFavorite(
        propertyId: propertyId,
        userId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
