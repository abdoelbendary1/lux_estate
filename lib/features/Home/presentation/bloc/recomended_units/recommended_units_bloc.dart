import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart'; // Add this package
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/usecase/getPropertiesByCategory.dart';
import 'package:meta/meta.dart';

part 'recommended_units_event.dart';
part 'recommended_units_state.dart';

@injectable
class RecommendedUnitsBloc
    extends Bloc<RecommendedUnitsEvent, RecommendedUnitsState> {
  final GetUnitsByCategory _getUnitsByCategory;

  RecommendedUnitsBloc(this._getUnitsByCategory)
    : super(RecommendedUnitsState.initial()) {
    // Using restartable() prevents multiple rapid clicks from causing data glitches
    on<LoadPropertiesByCategoryEvent>(
      _loadPropertiesByCategory,
      transformer: restartable(),
    );
  }

  Future<void> _loadPropertiesByCategory(
    LoadPropertiesByCategoryEvent event,
    Emitter<RecommendedUnitsState> emit,
  ) async {
    // 1. Emit loading state while keeping the current category selected
    emit(
      state.copyWith(
        featuredUnitsStatus: DataLoading(),
        selectedCategory: event.category,
      ),
    );

    // 2. Execute the use case
    final result = await _getUnitsByCategory.execute(category: event.category);

    // 3. Handle the result
    result.fold(
      (failure) => emit(
        state.copyWith(
          featuredUnitsStatus: DataFailed(
            failure.message ?? "Unexpected Error",
          ),
        ),
      ),
      (units) => emit(state.copyWith(featuredUnitsStatus: DataSuccess(units))),
    );
  }
}
