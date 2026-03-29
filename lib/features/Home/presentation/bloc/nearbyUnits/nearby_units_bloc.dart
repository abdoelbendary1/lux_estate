import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart'
    show PropertyUnitEntity;
import 'package:lux_estate/features/Home/domain/usecase/GetNearbyUntits.dart';
import 'package:meta/meta.dart';

part 'nearby_units_event.dart';
part 'nearby_units_state.dart';

@injectable
class NearbyUnitsBloc extends Bloc<NearbyUnitsEvent, NearbyUnitsState> {
  final GetNearbyUntits _getNearbyUntits;
  NearbyUnitsBloc({required GetNearbyUntits getNearbyUntits})
    : _getNearbyUntits = getNearbyUntits,
      super(NearbyUnitsState(nearbyUnitsStatus: DataInitial())) {
    on<LoadNearbyUnitsEvent>(_loadNearbyUnits);
  }

  FutureOr<void> _loadNearbyUnits(
    LoadNearbyUnitsEvent event,
    Emitter<NearbyUnitsState> emit,
  ) async {
    emit(NearbyUnitsState(nearbyUnitsStatus: DataLoading()));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _getNearbyUntits.execute(
      lat: event.lat,
      lang: event.lang,
    );
    result.fold(
      (l) => emit(NearbyUnitsState(nearbyUnitsStatus: DataFailed(l.message!))),
      (units) => emit(NearbyUnitsState(nearbyUnitsStatus: DataSuccess(units))),
    );
  }
}
