part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  AsyncState<List<PropertyUnitEntity>> favoritesListStatus;
  final AsyncState<bool> toggleStatus;

  FavoritesState({
    required this.favoritesListStatus,
    required this.toggleStatus,
  });
  factory FavoritesState.initial() => FavoritesState(
    favoritesListStatus: const DataInitial(),
    toggleStatus: const DataInitial(),
  );
  FavoritesState copyWith({
    AsyncState<List<PropertyUnitEntity>>? favoritesListStatus,
    AsyncState<bool>? toggleStatus,
  }) {
    return FavoritesState(
      favoritesListStatus: favoritesListStatus ?? this.favoritesListStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
    );
  }

  @override
  List<Object> get props => [favoritesListStatus, toggleStatus];
}
