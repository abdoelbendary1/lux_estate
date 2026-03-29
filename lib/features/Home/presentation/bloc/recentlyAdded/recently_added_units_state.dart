part of 'recently_added_units_bloc.dart';

class RecentlyAddedUnitsState extends Equatable {
  final AsyncState<List<PropertyUnitEntity>> unitsStatus;
  // Imagine adding this later:
  // final int lastFetchedCount;

  const RecentlyAddedUnitsState({required this.unitsStatus});

  factory RecentlyAddedUnitsState.initial() =>
      RecentlyAddedUnitsState(unitsStatus: DataInitial());

  RecentlyAddedUnitsState copyWith({
    AsyncState<List<PropertyUnitEntity>>? unitsStatus,
  }) {
    return RecentlyAddedUnitsState(
      unitsStatus: unitsStatus ?? this.unitsStatus,
    );
  }

  @override
  List<Object?> get props => [unitsStatus];
}
