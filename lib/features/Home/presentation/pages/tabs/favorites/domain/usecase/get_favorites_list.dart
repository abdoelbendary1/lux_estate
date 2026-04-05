import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/domain/repo/favorites_repo.dart';

@injectable
class GetFavoritesList {
  FavoritesRepo repository;
  GetFavoritesList(this.repository);

  Future<Either<Failures, List<PropertyUnitEntity>>> call() async {
    return repository.getMyFavorites();
  }
}
