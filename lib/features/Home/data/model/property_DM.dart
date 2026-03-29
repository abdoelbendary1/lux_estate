import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/features/Home/data/model/developer_DM.dart';
import 'package:lux_estate/features/Home/data/model/location_DM.dart';
import 'package:lux_estate/features/Home/data/model/owner_DM.dart';
import 'package:lux_estate/features/Home/data/model/unit_category_DM.dart';
import 'package:lux_estate/features/Home/domain/entities/developer_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/owener_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';

class PropertyDM extends PropertyUnitEntity {
  const PropertyDM({
    super.id,
    super.name,
    super.bedCount,
    super.bathCount,
    super.isAvailable,
    super.isSaved,
    super.isFeatured,
    super.isNew,
    super.isMatched,
    super.size,
    super.price,
    super.imageUrl,
    super.description,
    super.developer,
    super.owner,
    super.location,
    super.unitType,
    super.unitList,
    super.unitTag,
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
      isFeatured: json['isFeatured'],
      isNew: json['isNew'],
      isMatched: json['isMatched'],
      size: json['size'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      developer: DeveloperDM.fromJson(json['developer']),
      owner: OwnerDM.fromJson(json['owner']),
      location: LocationDM.fromJson(json['location']),
      unitType: json['unitType'],
      unitList: json['unitList'],
      unitTag: json['unitTag'],
      unitCategory: UnitCategoryDM.fromJson(json['unitCategory']),
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
      'isFeatured': isFeatured,
      'isNew': isNew,
      'isMatched': isMatched,
      'size': size,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'developerId': developer,
      'owner': owner,
      'location': location,
      'unitType': unitType,
      'unitList': unitList,
      'unitTag': unitTag,
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
    bool? isFeatured,
    bool? isNew,
    bool? isMatched,
    num? size,
    num? price,
    String? imageUrl,
    String? description,
    DeveloperEntity? developer,
    OwnerEntity? owner,
    LocationEntity? location,
    String? unitType,
    String? unitList,
    String? unitTag,
    UnitCategoryEntity? unitCategory,
  }) {
    return PropertyDM(
      id: id ?? this.id,
      name: name ?? this.name,
      bedCount: bedCount ?? this.bedCount,
      bathCount: bathCount ?? this.bathCount,
      isAvailable: isAvailable ?? this.isAvailable,
      isSaved: isSaved ?? this.isSaved,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
      isMatched: isMatched ?? this.isMatched,
      size: size ?? this.size,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      developer: developer ?? this.developer,
      owner: owner ?? this.owner,
      location: location ?? this.location,
      unitType: unitType ?? this.unitType,
      unitList: unitList ?? this.unitList,
      unitTag: unitTag ?? this.unitTag,
      unitCategory: unitCategory ?? this.unitCategory,
    );
  }
}
