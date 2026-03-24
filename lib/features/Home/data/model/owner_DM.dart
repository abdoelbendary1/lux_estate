import 'package:lux_estate/features/Home/domain/entities/owener_entity.dart';

class OwnerDM extends OwnerEntity {
  OwnerDM({required super.id, required super.name, required super.imageUrl});

  factory OwnerDM.fromJson(Map<String, dynamic> json) =>
      OwnerDM(id: json['id'], name: json['name'], imageUrl: json['imageUrl']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
  };

  OwnerDM copyWith({String? id, String? name, String? imageUrl}) => OwnerDM(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
  );
}
