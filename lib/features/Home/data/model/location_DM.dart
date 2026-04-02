import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';

class LocationDM extends LocationEntity {
  const LocationDM({super.name, super.latitude, super.longitude});

  factory LocationDM.fromJson(Map<String, dynamic> json) {
    String? lat;
    String? lng;

    // ركز هنا: بنقرأ من الحقل اللي في جدول الـ properties مباشرة
    if (json['location_coords'] != null) {
      final coords = json['location_coords']
          .toString()
          .replaceAll('POINT(', '')
          .replaceAll(')', '')
          .split(' ');

      lng = coords[0];
      lat = coords[1];
    }
    return LocationDM(
      name: json['location_name'], // تأكد إن الاسم في السوبابيز location_name
      latitude: lat,
      longitude: lng,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'location_coords': 'POINT($longitude $latitude)',
    'location_name': name,
  };

  LocationDM copyWith({String? name, String? latitude, String? longitude}) =>
      LocationDM(
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
}
