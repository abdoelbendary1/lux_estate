import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/repo/Home_page_repo.dart';

@injectable
class GetUnitsByCategory {
  final HomePageRepository _repo;

  GetUnitsByCategory(this._repo);

  Future<Either<Failures, List<PropertyUnitEntity>>> execute({
    required PropertyCategories category,
  }) async => await _repo.getPropertiesByCategory(category: category);
}
