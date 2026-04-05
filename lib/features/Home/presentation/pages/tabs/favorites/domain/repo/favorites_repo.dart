import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

abstract class FavoritesRepo {
  Future<Either<Failures, List<PropertyUnitEntity>>> getMyFavorites();
  Future<Either<Failures, bool>> toggleFavorite({
    required String propertyId,
    required String userId,
  });
}
