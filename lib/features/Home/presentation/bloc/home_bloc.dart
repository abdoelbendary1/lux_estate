import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/usecase/getPropertiesByCategory.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetUnitsByCategory _getUnitsByCategory;
  HomeBloc({required GetUnitsByCategory getUnitsByCategory})
    : _getUnitsByCategory = getUnitsByCategory,
      super(HomeState.initial()) {
    // on<HomeEvent>((event, emit) => emit(HomeLoading()));
    on<HomeStarted>(_homeStarted);
    on<LoadPropertiesByCategoryEvent>(_loadPropertiesByCategory);
  }

  FutureOr<void> _loadPropertiesByCategory(
    LoadPropertiesByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    // emit(
    //   state.copyWith(
    //     featuredUnitsStatus: DataLoading(),
    //     // selectedCategory: event.category,
    //   ),
    // );
    final result = await _getUnitsByCategory.execute(category: event.category);
    result.fold(
      (l) => emit(
        state.copyWith(
          featuredUnitsStatus: DataFailed(l.message!),
          selectedCategory: event.category,
        ),
      ),
      (units) => emit(
        state.copyWith(
          featuredUnitsStatus: DataSuccess(units),
          selectedCategory: event.category,
        ),
      ),
    );
  }

  FutureOr<void> _homeStarted(HomeStarted event, Emitter<HomeState> emit) {
    add(
      LoadPropertiesByCategoryEvent(category: PropertyCategories.values.first),
    );
  }

  
}
