// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/data/datasource/home_page_mockup_data_source.dart';
import 'package:lux_estate/features/Home/data/datasource/home_page_remote_data_source.dart';
import 'package:lux_estate/features/Home/domain/repo/Home_page_repo.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

@LazySingleton(as: HomePageRepository)
class HomePageRepoImpl implements HomePageRepository {
  HomePageMockupDataSource mockupDataSource;
  HomePageRemoteDataSource remoteDataSource;
  HomePageRepoImpl({required this.mockupDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failures, List<PropertyUnitEntity>>> getPropertiesByCategory({
    required PropertyCategories category,
  }) async {
    try {
      final result = await remoteDataSource.getPropertiesByCategory(
        categoryId: category.id,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<PropertyUnitEntity>>> getPropertiesByLocation({
    required String lat,
    required String lang,
        required PropertyCategories category,

  }) async {
    try {
      final result = await remoteDataSource.getPropertiesByLocation(
        lat: lat,
        lang: lang,
        categoryId: category.id,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<PropertyUnitEntity>>>
  getRecentlyAddedUnits({    required PropertyCategories category,
}) async {
    try {
      final result = await remoteDataSource.getRecentlyAddedUnits(  
        categoryId: category.id,);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
}
