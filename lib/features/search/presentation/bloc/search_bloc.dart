import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/usecase/getPropertiesByCategory.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetUnitsByCategory _getUnitsByCategory;

  SearchBloc({required GetUnitsByCategory getUnitsByCategory})
    : _getUnitsByCategory = getUnitsByCategory,
      super(SearchState.initial()) {
    on<PerformSearch>(_search);
    on<SelectFilterCategories>(_selectFilterCategories);
  }
  FutureOr<void> _selectFilterCategories(
    SelectFilterCategories event,
    Emitter<SearchState> emit,
  ) async => emit(state.copyWith(filteredCategories: event.categories));
  FutureOr<void> _search(PerformSearch event, Emitter<SearchState> emit) async {
    emit(state.copyWith(unitsStatus: DataLoading()));
    await Future.delayed(const Duration(seconds: 2));
    final result = await _getUnitsByCategory.execute(
      category: PropertyCategories.all,
    );
    result.fold(
      (l) => emit(state.copyWith(unitsStatus: DataFailed(l.message!))),
      (units) {
        final List<PropertyUnitEntity> filteredUnits = [];
        final List<PropertyUnitEntity> searchResult = [];
        if (state.filteredCategories == null ||
            state.filteredCategories!.isEmpty) {
          searchResult.addAll(
            units
                .where(
                  (unit) => unit.name!.toLowerCase().contains(
                    event.query!.toLowerCase(),
                  ),
                )
                .toList(),
          );
        } else if (state.filteredCategories!.isNotEmpty) {
          for (var catgory in state.filteredCategories!) {
            filteredUnits.addAll(
              units
                  .where((unit) => unit.unitCategory?.id == catgory.id)
                  .toList(),
            );
          }

          searchResult.addAll(
            filteredUnits
                .where(
                  (unit) => unit.name!.toLowerCase().contains(
                    event.query!.toLowerCase(),
                  ),
                )
                .toList(),
          );
        }

        emit(state.copyWith(unitsStatus: DataSuccess(searchResult)));
      },
    );
  }
}
