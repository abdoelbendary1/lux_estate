part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class PerformSearch extends SearchEvent {
  final String? query;

  PerformSearch({required this.query});
}

final class SelectFilterCategories extends SearchEvent {
  final List<PropertyCategories> categories;

  SelectFilterCategories({required this.categories});
}
