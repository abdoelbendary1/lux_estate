import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';

class PropertyUnitEntity {
  String? id;
  String? name;
  num? bedCount;
  num? bathCount;
  bool? isAvailable;
  bool? isSaved;
  num? size;
  num? price;
  String? imageUrl;
  String? description;
  String? developerId;
  String? ownerId;
  LocationEntity? location;
  String? unitType;
  String? unitList;
  UnitCategoryEntity? unitCategory;

  PropertyUnitEntity({
    this.id,
    this.name,
    this.bedCount,
    this.bathCount,
    this.isAvailable,
    this.isSaved,
    this.size,
    this.price,
    this.imageUrl,
    this.description,
    this.developerId,
    this.ownerId,
    this.location,
    this.unitType,
    this.unitList,
    this.unitCategory,
  });
}
