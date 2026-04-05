import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';

extension PropertyUnitEntityExtension on PropertyUnitEntity {
  String name(BuildContext context) =>
      context.locale.languageCode == 'ar' ? arName ?? "" : enName ?? "";
  String locationName(BuildContext context) {
    if (location == null) return "";
    return context.locale.languageCode == 'ar'
        ? location!.arName ?? ""
        : location!.enName ?? "";
  }
}

class PropertyUnitEntity extends Equatable {
  final String? id;
  final String? enName;
  final String? arName;

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
  final String? categoryId;
  final String? developerId;
  final String? ownerId;
  final String? createdAt;

  const PropertyUnitEntity({
    this.id,
    this.enName,
    this.arName,
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
    this.developerId,
    this.ownerId,
    this.location,
    this.unitType,
    this.unitList,
    this.unitTag,
    this.categoryId,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id];
}
