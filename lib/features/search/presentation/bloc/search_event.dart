part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class PerformSearch extends SearchEvent {
  final String? query;
  final PropertyCategories? category;

  PerformSearch({required this.query ,required this.category});
}

final class SelectFilterCategories extends SearchEvent {

  final List<PropertyCategories> categories;

  SelectFilterCategories({required this.categories});
}
