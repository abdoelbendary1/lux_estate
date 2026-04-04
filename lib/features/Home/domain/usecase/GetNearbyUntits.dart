import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/repo/Home_page_repo.dart';
import 'package:lux_estate/features/Home/domain/repo/Home_page_repo.dart';

@injectable
class GetNearbyUntits {
  final HomePageRepository _repo;

  GetNearbyUntits(this._repo);

  Future<Either<Failures, List<PropertyUnitEntity>>> execute({
    required String lat,
    required String lang,    required PropertyCategories category,

  }) async => await _repo.getPropertiesByLocation(lang: lat, lat: lang , category: category);
}
