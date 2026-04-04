// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

import 'package:lux_estate/features/search/domain/repo/search_repo.dart';

@injectable
class SearchProperty {
  SearchRepo searchRepo;
  SearchProperty({
    required this.searchRepo
  });

  Future<Either<Failures, List<PropertyUnitEntity>>> call({required String query ,required PropertyCategories category}) => searchRepo.searchProperties(query: query , category: category);
}
