import 'package:equatable/equatable.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';

class OwnerEntity extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final List<PropertyUnitEntity>? properties; // الحقل الجديد

  const OwnerEntity({this.id, this.name, this.imageUrl, this.properties});

  @override
  List<Object?> get props => [id, name, imageUrl, properties];
}
