import 'package:lux_estate/features/Home/domain/entities/unit_category_entity.dart';

class UnitCategoryDM extends UnitCategoryEntity {
  UnitCategoryDM({super.id, super.name});

  UnitCategoryDM fromJson(Map<String, dynamic> json) =>
      UnitCategoryDM(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  UnitCategoryDM copyWith({String? id, String? name}) =>
      UnitCategoryDM(id: id ?? this.id, name: name ?? this.name);
}
