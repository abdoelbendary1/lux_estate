import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/domain/usecase/get_favorites_list.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/domain/usecase/toggle_favorites.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesList _getFavoritesList;
  final ToggleFavorites _favorite;

  FavoritesBloc({
    required GetFavoritesList getFavoritesList,
    required ToggleFavorites toggleFavorites,
  }) : _getFavoritesList = getFavoritesList,
       _favorite = toggleFavorites,
       super(FavoritesState.initial()) {
    on<LoadFavoritesEvent>(_loadFavorites);
    on<ToggleFavorite>(_toggleFavorite);
  }

  FutureOr<void> _loadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(favoritesListStatus: DataLoading()));
    await _getFavoritesList().then((result) {
      result.fold(
        (failure) => emit(
          state.copyWith(
            favoritesListStatus: DataFailed(
              failure.message ?? "Failed to load favorites",
            ),
          ),
        ),
        (favorites) => emit(
          state.copyWith(
            favoritesListStatus: DataSuccess<List<PropertyUnitEntity>>(
              favorites,
            ),
          ),
        ),
      );
    });
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    // Optionally, you can show a loading state for the toggle action
    // emit(state.copyWith(toggleStatus: DataLoading()));

    final result = await _favorite.call(
      propertyId: event.unitId,
      userId: event.userId,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          toggleStatus: DataFailed(
            failure.message ?? "Failed to toggle favorite",
          ),
        ),
      ),
      (isFavorite) =>
          emit(state.copyWith(toggleStatus: DataSuccess(isFavorite))),
    );
  }
}
