part of 'nearby_units_bloc.dart';

@immutable
sealed class NearbyUnitsEvent {}

final class LoadNearbyUnitsEvent extends NearbyUnitsEvent {
  final String lat;
  final String lang;
      final PropertyCategories category;

  LoadNearbyUnitsEvent({required this.lat, required this.lang, required this.category});
}
