// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';

import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/data/datasource/home_page_remote_data_source.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/search/domain/repo/search_repo.dart';
@LazySingleton(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  HomePageRemoteDataSource remoteDataSource ;
  SearchRepoImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failures, List<PropertyUnitEntity>>> searchProperties({required String query,required PropertyCategories category}) async{
    try {
        final result = await remoteDataSource.searchProperties(query: query ,categoryId: category.id);
        return Right(result);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }

  }
  
}
