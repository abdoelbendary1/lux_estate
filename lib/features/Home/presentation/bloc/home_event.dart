part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeStarted extends HomeEvent {}

final class LoadPropertiesByCategoryEvent extends HomeEvent {
  final PropertyCategories category;
  LoadPropertiesByCategoryEvent({required this.category});
}


