import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

abstract class SearchRepo {
   Future<Either<Failures, List<PropertyUnitEntity>>> searchProperties({
    required String query,required PropertyCategories category
  });
}