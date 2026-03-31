
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';

class LocationDM extends LocationEntity {
  const LocationDM({super.name, super.latitude, super.longitude});

  factory LocationDM.fromJson(Map<String, dynamic> json) {
    return LocationDM(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  };

  LocationDM copyWith({String? name, String? latitude, String? longitude}) =>
      LocationDM(
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
}
