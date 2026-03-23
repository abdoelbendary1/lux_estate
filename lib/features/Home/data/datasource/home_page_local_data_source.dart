import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/data/model/property_DM.dart';

abstract class HomePageLocalDataSource {
  Future<Either<Failures, List<PropertyDM>>> getPropertiesByCategory({
    required int categoryId,
  });
}

class HomePageLocalDataSourceImpl implements HomePageLocalDataSource {
  @override
  Future<Either<Failures, List<PropertyDM>>> getPropertiesByCategory({
    required int categoryId,
  }) {
    // TODO: implement getPropertiesByCategory
    throw UnimplementedError();
  }
}
