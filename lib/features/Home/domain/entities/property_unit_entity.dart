import 'package:equatable/equatable.dart';
import 'package:lux_estate/features/Home/domain/entities/developer_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/owener_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';

class PropertyUnitEntity extends Equatable {
  final String? id;
  final String? name;
  final num? bedCount;
  final num? bathCount;
  final bool? isAvailable;
  final bool? isSaved;
  final bool? isFeatured;
  final bool? isNew;
  final bool? isMatched;
  final num? size;
  final num? price;
  final String? imageUrl;
  final String? description;
  final LocationEntity? location;
  final String? unitType;
  final String? unitList;
  final String? unitTag;
  final UnitCategoryEntity? unitCategory;
  final DeveloperEntity? developer;
  final OwnerEntity? owner;

  const PropertyUnitEntity({
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

  @override
  List<Object?> get props => [id];
}
