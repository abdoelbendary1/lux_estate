import 'package:lux_estate/features/Home/data/model/developer_DM.dart';
import 'package:lux_estate/features/Home/data/model/location_DM.dart';
import 'package:lux_estate/features/Home/data/model/owner_DM.dart';
import 'package:lux_estate/features/Home/data/model/unit_category_DM.dart';
import 'package:lux_estate/features/Home/domain/entities/developer_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/owener_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';
// استورد باقي الموديلات (LocationModel, OwnerModel, etc.)

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
    super.size,
    super.price,
    super.imageUrl,
    super.description,
    super.location,
    super.unitType,
    super.unitCategory,
    super.developer,
    super.owner,
  });

  factory PropertyDM.fromJson(Map<String, dynamic> json) {
    return PropertyDM(
      id: json['id'],
      name: json['name'],
      bedCount: json['bed_count'],
      bathCount: json['bath_count'],
      isAvailable: json['is_available'],
      isFeatured: json['is_featured'],
      isNew: json['is_new'],
      size: json['size'],
      price: json['price'],
      imageUrl: json['image_url'],
      description: json['description'],
      unitType: json['unit_type'],

      // التعديل هنا: بنبعت الـ json الكامل للـ LocationDM
      location: LocationDM.fromJson(json),

      // الجداول المربوطة (Foreign Keys) بتفضل زي ما هي لأنها بترجع كـ Nested Map فعلاً
      unitCategory: json['unit_categories'] != null
          ? UnitCategoryDM.fromJson(json['unit_categories'])
          : null,
      developer: json['developers'] != null
          ? DeveloperDM.fromJson(json['developers'])
          : null,
      owner: json['profiles'] != null
          ? OwnerDM.fromJson(json['profiles'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'bed_count': bedCount,
      'bath_count': bathCount,
      'is_available': isAvailable,
      'is_featured': isFeatured,
      'is_new': isNew,
      'size': size,
      'price': price,
      'image_url': imageUrl,
      'description': description,
      'unit_type': unitType,
      'category_id': unitCategory?.id,
      'developer_id': developer?.id,
      'owner_id': owner?.id,
    };

    // دمج الـ JSON بتاع اللوكيشن مع الداتا الأساسية
    if (location != null) {
      data.addAll((location as LocationDM).toJson());
    }

    return data;
  }

  // --- Copy With ---
  // لتوليد نسخة جديدة مع تغيير حقول معينة (مهم جداً للـ Bloc)
  PropertyDM copyWith({
    String? id,
    String? name,
    num? bedCount,
    num? bathCount,
    bool? isAvailable,
    bool? isSaved,
    bool? isFeatured,
    bool? isNew,
    num? size,
    num? price,
    String? imageUrl,
    String? description,
    LocationEntity? location,
    String? unitType,
    UnitCategoryEntity? unitCategory,
    DeveloperEntity? developer,
    OwnerEntity? owner,
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
      size: size ?? this.size,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      location: location ?? this.location,
      unitType: unitType ?? this.unitType,
      unitCategory: unitCategory ?? this.unitCategory,
      developer: developer ?? this.developer,
      owner: owner ?? this.owner,
    );
  }
}
