import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

abstract class HomePageRepository {
  Future<Either<Failures, List<PropertyUnitEntity>>> getPropertiesByCategory({
    required PropertyCategories category,
  });
}
