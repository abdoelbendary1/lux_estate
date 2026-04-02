import 'package:lux_estate/features/Home/data/model/property_DM.dart';
import 'package:lux_estate/features/Home/domain/entities/owener_entity.dart';

class OwnerDM extends OwnerEntity {
  const OwnerDM({super.id, super.name, super.imageUrl, super.properties});

  factory OwnerDM.fromJson(Map<String, dynamic> json) {
    return OwnerDM(
      id: json['id']?.toString(),
      name: json['full_name'] ?? json['name'],
      imageUrl: json['avatar_url'] ?? json['imageUrl'],
      // هنا بنحول قائمة الوحدات لو كانت موجودة في الـ JSON
      properties: json['properties'] != null
          ? (json['properties'] as List)
                .map((i) => PropertyDM.fromJson(i))
                .toList()
          : null,
    );
  }
}
