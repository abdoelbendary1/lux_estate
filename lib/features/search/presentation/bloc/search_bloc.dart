import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/search/domain/usecase/search_property.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  // final GetUnitsByCategory _getUnitsByCategory;
  final SearchProperty _searchProperty;

  SearchBloc({required SearchProperty searchProperty})
    : _searchProperty = searchProperty,
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
    final result = await _searchProperty.call(
      query: event.query!,
      category: event.category!,);
    result.fold(
      (l) => emit(state.copyWith(unitsStatus: DataFailed(l.message!))),
      (units) {
      

        emit(state.copyWith(unitsStatus: DataSuccess(units)));
      },
    );
  }
}
