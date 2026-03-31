
import 'package:lux_estate/features/Home/domain/entities/developer_entity.dart';

class DeveloperDM extends DeveloperEntity {
  const DeveloperDM({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory DeveloperDM.fromJson(Map<String, dynamic> json) => DeveloperDM(
    id: json['id'],
    name: json['name'],
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
  };

  DeveloperDM copyWith({String? id, String? name, String? imageUrl}) =>
      DeveloperDM(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
