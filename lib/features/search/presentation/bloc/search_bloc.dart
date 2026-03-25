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
  GetUnitsByCategory _getUnitsByCategory;

  SearchBloc({required GetUnitsByCategory getUnitsByCategory})
    : _getUnitsByCategory = getUnitsByCategory,
      super(SearchState.initial()) {
    on<PerformSearch>(_search);
  }

  FutureOr<void> _search(PerformSearch event, Emitter<SearchState> emit) async {
    final result = await _getUnitsByCategory.execute(
      category: PropertyCategories.all,
    );
    result.fold(
      (l) => emit(state.copyWith(unitsStatus: DataFailed(l.message!))),
      (units) {
        final filteredUnits = units
            .where(
              (unit) =>
                  unit.name!.toLowerCase().contains(event.query!.toLowerCase()),
            )
            .toList();
        emit(state.copyWith(unitsStatus: DataSuccess(filteredUnits)));
      },
    );
  }
}
