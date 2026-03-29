import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/usecase/GetRecentUnits.dart';
import 'package:meta/meta.dart';

part 'recently_added_units_event.dart';
part 'recently_added_units_state.dart';

@injectable
class RecentlyAddedUnitsBloc
    extends Bloc<RecentlyAddedUnitsEvent, RecentlyAddedUnitsState> {
  final GetRecentUnits _getRecentUnits;

  RecentlyAddedUnitsBloc({required GetRecentUnits getRecentUnits})
    : _getRecentUnits = getRecentUnits,
      super(RecentlyAddedUnitsState(unitsStatus: DataInitial())) {
    on<LoadRecentlyAddedUnitsEvent>(_loadRecentlyAddedUnits);
  }
  FutureOr<void> _loadRecentlyAddedUnits(
    LoadRecentlyAddedUnitsEvent event,
    Emitter<RecentlyAddedUnitsState> emit,
  ) async {
    try {
      // 1. Preserve state while loading
      emit(state.copyWith(unitsStatus: DataLoading()));

      final result = await _getRecentUnits.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(unitsStatus: DataFailed(failure.message ?? "Error")),
        ),
        (units) => emit(state.copyWith(unitsStatus: DataSuccess(units))),
      );
    } catch (e) {
      emit(state.copyWith(unitsStatus: DataFailed(e.toString())));
    }
  }
}
