part of 'recommended_units_bloc.dart';

@immutable
sealed class RecommendedUnitsEvent {}

final class LoadPropertiesByCategoryEvent extends RecommendedUnitsEvent {
  final PropertyCategories category;
  LoadPropertiesByCategoryEvent({required this.category});
}
