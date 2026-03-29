part of 'search_bloc.dart';

@immutable
class SearchState {
  final AsyncState<List<PropertyUnitEntity>> unitsStatus;
  final List<PropertyCategories>? filteredCategories;
  const SearchState({required this.unitsStatus, this.filteredCategories});

  factory SearchState.initial() =>
      const SearchState(unitsStatus: DataInitial(), filteredCategories: []);
  SearchState copyWith({
    AsyncState<List<PropertyUnitEntity>>? unitsStatus,
    List<PropertyCategories>? filteredCategories,
  }) => SearchState(
    unitsStatus: unitsStatus ?? this.unitsStatus,
    filteredCategories: filteredCategories ?? this.filteredCategories,
  );
}
