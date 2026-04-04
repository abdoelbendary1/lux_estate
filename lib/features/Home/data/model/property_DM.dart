import 'package:easy_localization/easy_localization.dart';
import 'package:lux_estate/features/Home/data/model/location_DM.dart';
import 'package:lux_estate/features/Home/domain/entities/location_entity.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
// استورد باقي الموديلات (LocationModel, OwnerModel, etc.)

class PropertyDM extends PropertyUnitEntity {
  const PropertyDM({
    super.id,
    super.enName,
    super.arName,
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
    super.categoryId,
    super.createdAt,
    super.developerId,
    super.ownerId,
    super.isMatched,
    super.unitList,
    super.unitTag,
  });

  factory PropertyDM.fromJson(Map<String, dynamic> json) {
  DateTime date = DateTime.parse(json['created_at']);

// 2. لو عايز ترجعها لـ String بالتنسيق بتاعك (اختياري)
String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
    return PropertyDM(
      id: json['id'],
      enName: json['en_name'],
      arName: json['ar_name'],
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
     categoryId: json['category_id'],
     developerId: json['developer_id'],
     ownerId: json['owner_id'],
     createdAt: formattedDate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'en_name': enName,
      'ar_name': arName,
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
      'category_id': categoryId,
      'developer_id': developerId,
      'owner_id': ownerId,
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
    String? enName,
    String? arName,
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
    String? categoryId,
    String? developerId,
    String? ownerId,
  }) {
    return PropertyDM(
      id: id ?? this.id,
     enName: enName ?? this.enName,
      arName: arName ?? this.arName,
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
      categoryId: categoryId ?? this.categoryId,
      developerId: developerId ?? this.developerId,
      ownerId: ownerId ?? this.ownerId,
    );
  }
}
