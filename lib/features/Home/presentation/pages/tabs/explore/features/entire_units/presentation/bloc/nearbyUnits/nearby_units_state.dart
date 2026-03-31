part of 'nearby_units_bloc.dart';

@immutable
class NearbyUnitsState extends Equatable {
  final AsyncState<List<PropertyUnitEntity>> nearbyUnitsStatus;

  const NearbyUnitsState({required this.nearbyUnitsStatus});

  @override
  List<Object> get props => [nearbyUnitsStatus];
}
