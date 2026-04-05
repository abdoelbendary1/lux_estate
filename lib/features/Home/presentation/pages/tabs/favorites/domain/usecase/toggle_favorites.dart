import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/domain/repo/favorites_repo.dart';

@injectable
class ToggleFavorites {
  final FavoritesRepo repository;

  ToggleFavorites(this.repository);

  Future<Either<Failures, bool>> call({
    required String propertyId,
    required String userId,
  }) async {
    return repository.toggleFavorite(propertyId: propertyId, userId: userId);
  }
}
