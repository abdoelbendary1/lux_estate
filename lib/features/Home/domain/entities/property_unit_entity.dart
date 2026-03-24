import 'package:lux_estate/features/Home/domain/entities/developer_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/owener_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';

class PropertyUnitEntity {
  String? id;
  String? name;
  num? bedCount;
  num? bathCount;
  bool? isAvailable;
  bool? isSaved;
  bool? isFeatured;
  bool? isNew;
  bool? isMatched;
  num? size;
  num? price;
  String? imageUrl;
  String? description;
  LocationEntity? location;
  String? unitType;
  String? unitList;
  String? unitTag;
  UnitCategoryEntity? unitCategory;
  DeveloperEntity? developer;
  OwnerEntity? owner;

  PropertyUnitEntity({
    this.id,
    this.name,
    this.bedCount,
    this.bathCount,
    this.isAvailable,
    this.isSaved,
    this.isFeatured,
    this.isNew,
    this.isMatched,
    this.size,
    this.price,
    this.imageUrl,
    this.description,
    this.developer,
    this.owner,
    this.location,
    this.unitType,
    this.unitList,
    this.unitTag,
    this.unitCategory,
  });
}
