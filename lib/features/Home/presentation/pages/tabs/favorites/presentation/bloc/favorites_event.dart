part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {
  const LoadFavoritesEvent();
}

class ToggleFavorite extends FavoritesEvent {
  final String unitId;
  final String userId;
  const ToggleFavorite({required this.unitId, required this.userId});
}
