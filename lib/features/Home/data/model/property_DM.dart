import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';

class PropertyDM extends PropertyUnitEntity {
  PropertyDM({
    super.id,
    super.name,
    super.bedCount,
    super.bathCount,
    super.isAvailable,
    super.isSaved,
    super.size,
    super.price,
    super.imageUrl,
    super.description,
    super.developerId,
    super.ownerId,
    super.location,
    super.unitType,
    super.unitList,
    super.unitCategory,
  });

  factory PropertyDM.fromJson(Map<String, dynamic> json) {
    return PropertyDM(
      id: json['id'],
      name: json['name'],
      bedCount: json['bedCount'],
      bathCount: json['bathCount'],
      isAvailable: json['isAvailable'],
      isSaved: json['isSaved'],
      size: json['size'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      developerId: json['developerId'],
      ownerId: json['ownerId'],
      location: json['location'],
      unitType: json['unitType'],
      unitList: json['unitList'],
      unitCategory: json['unitCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bedCount': bedCount,
      'bathCount': bathCount,
      'isAvailable': isAvailable,
      'isSaved': isSaved,
      'size': size,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'developerId': developerId,
      'ownerId': ownerId,
      'location': location,
      'unitType': unitType,
      'unitList': unitList,
      'unitCategory': unitCategory,
    };
  }

  PropertyDM copyWith({
    String? id,
    String? name,
    num? bedCount,
    num? bathCount,
    bool? isAvailable,
    bool? isSaved,
    num? size,
    num? price,
    String? imageUrl,
    String? description,
    String? developerId,
    String? ownerId,
    LocationEntity? location,
    String? unitType,
    String? unitList,
    UnitCategoryEntity? unitCategory,
  }) {
    return PropertyDM(
      id: id ?? this.id,
      name: name ?? this.name,
      bedCount: bedCount ?? this.bedCount,
      bathCount: bathCount ?? this.bathCount,
      isAvailable: isAvailable ?? this.isAvailable,
      isSaved: isSaved ?? this.isSaved,
      size: size ?? this.size,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      developerId: developerId ?? this.developerId,
      ownerId: ownerId ?? this.ownerId,
      location: location ?? this.location,
      unitType: unitType ?? this.unitType,
      unitList: unitList ?? this.unitList,
      unitCategory: unitCategory ?? this.unitCategory,
    );
  }
}
