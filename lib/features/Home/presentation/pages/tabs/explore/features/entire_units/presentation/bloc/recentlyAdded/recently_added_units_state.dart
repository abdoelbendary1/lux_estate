part of 'recently_added_units_bloc.dart';

class RecentlyAddedUnitsState extends Equatable {
  final AsyncState<List<PropertyUnitEntity>> unitsStatus;
  final PropertyCategories? selectedCategory;
  // Imagine adding this later:
  // final int lastFetchedCount;

  const RecentlyAddedUnitsState({required this.unitsStatus , this.selectedCategory});

  factory RecentlyAddedUnitsState.initial() =>
      RecentlyAddedUnitsState(unitsStatus: DataInitial(), selectedCategory: PropertyCategories.values.first);

  RecentlyAddedUnitsState copyWith({
    AsyncState<List<PropertyUnitEntity>>? unitsStatus,
    PropertyCategories? selectedCategory,
  }) {
    return RecentlyAddedUnitsState(
      unitsStatus: unitsStatus ?? this.unitsStatus,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [unitsStatus];
}
