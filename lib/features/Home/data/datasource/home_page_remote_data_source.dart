import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/data/model/property_DM.dart';

abstract class HomePageRemoteDataSource {
  Future<Either<Failures, List<PropertyDM>>> getPropertiesByCategory({
    required int categoryId,
  });

/*************  ✨ Windsurf Command ⭐  *************/
/*******  646384c4-83b2-41c4-abc8-6443158fe22b  *******/
  Future<Either<Failures, List<PropertyDM>>> getPropertiesByLocation({
    required String lat,
    required String lang,
  });
  Future<Either<Failures, List<PropertyDM>>> searchProperties({String? query});
}

class HomePageRemoteDataSourceImpl implements HomePageRemoteDataSource {
  @override
  Future<Either<Failures, List<PropertyDM>>> getPropertiesByCategory({
    required int categoryId,
  }) {
    // TODO: implement getPropertiesByCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<PropertyDM>>> getPropertiesByLocation({
    required String lat,
    required String lang,
  }) {
    // TODO: implement getPropertiesByLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<PropertyDM>>> searchProperties({String? query}) {
    // TODO: implement searchProperties
    throw UnimplementedError();
  }
}
