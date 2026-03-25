part of 'search_bloc.dart';

@immutable
class SearchState {
  final AsyncState<List<PropertyUnitEntity>> unitsStatus;
  const SearchState({required this.unitsStatus});

  factory SearchState.initial() =>
      const SearchState(unitsStatus: DataInitial());
  SearchState copyWith({AsyncState<List<PropertyUnitEntity>>? unitsStatus}) =>
      SearchState(unitsStatus: unitsStatus ?? this.unitsStatus);
}
