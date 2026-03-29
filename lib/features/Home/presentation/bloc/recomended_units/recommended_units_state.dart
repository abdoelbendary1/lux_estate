part of 'recommended_units_bloc.dart';

@immutable
class RecommendedUnitsState {
  // Independent statuses for different UI sections
  final AsyncState<List<PropertyUnitEntity>> featuredUnitsStatus;
  final AsyncState<List<PropertyUnitEntity>> recentUnitsStatus;
  final PropertyCategories selectedCategory;

  // UI state (non-async)
  final String searchQuery;
  // final PropertyFilter filters;

  const RecommendedUnitsState({
    required this.featuredUnitsStatus,
    required this.recentUnitsStatus,
    required this.selectedCategory,
    this.searchQuery = '',
    // this.filters = const PropertyFilter(),
  });
  // 1. This defines RecommendedUnitsState.initial()
  factory RecommendedUnitsState.initial() => RecommendedUnitsState(
    // We start with an empty, non-loading state
    featuredUnitsStatus: DataLoading(),
    recentUnitsStatus: DataLoading(),
    selectedCategory:
        PropertyCategories.values.first, // Default to the first category
  );

  // 2. This allows the Bloc to update only the unitsStatus
  // Always use copyWith to update only what changed
  RecommendedUnitsState copyWith({
    AsyncState<List<PropertyUnitEntity>>? featuredUnitsStatus,
    AsyncState<List<PropertyUnitEntity>>? recentUnitsStatus,
    PropertyCategories? selectedCategory,
  }) {
    return RecommendedUnitsState(
      featuredUnitsStatus: featuredUnitsStatus ?? this.featuredUnitsStatus,
      recentUnitsStatus: recentUnitsStatus ?? this.recentUnitsStatus,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      // ... keep others
    );
  }
}

// final class HomeInitial extends RecommendedUnitsState {}

// final class HomeLoading extends RecommendedUnitsState {}

// final class HomeSuccess extends RecommendedUnitsState {
//   final List<PropertyUnitEntity> units;
//   HomeSuccess(this.units);
// }

// final class HomeFailure extends RecommendedUnitsState {
//   final String message;
//   HomeFailure(this.message);
// }
