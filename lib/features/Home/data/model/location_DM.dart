import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';

class LocationDM extends LocationEntity {
  const LocationDM({super.enName, super.arName, super.latitude, super.longitude});
factory LocationDM.fromJson(Map<String, dynamic> json) {
  String? lat;
  String? lng;

  // بنقرأ من العمود الذكي اللي عملناه (location_text)
  final String? raw = json['location_text']; 

  if (raw != null && raw.contains('POINT')) {
    final clean = raw.replaceAll('POINT(', '').replaceAll(')', '').trim();
    final coords = clean.split(' ');

    if (coords.length >= 2) {
      lng = coords[0];
      lat = coords[1];
    }
  }

  return LocationDM(
    enName: json['en_location_name'],
    arName: json['ar_location_name'],
    latitude: lat,
    longitude: lng,
  );
}

  @override
  Map<String, dynamic> toJson() => {
    'location_coords': 'POINT($longitude $latitude)',
    'en_location_name': enName,
    'ar_location_name': arName,
  };

  LocationDM copyWith({String? enName, String? arName, String? latitude, String? longitude}) =>
      LocationDM(
        enName: enName ?? this.enName,
        arName: arName ?? this.arName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
}
