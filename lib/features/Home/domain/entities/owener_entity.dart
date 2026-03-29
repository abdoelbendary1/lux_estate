import 'package:equatable/equatable.dart';

 class OwnerEntity extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? jobTitles;
  final String? description;

  const OwnerEntity({
    this.id,
    this.name,
    this.imageUrl,
    this.jobTitles,
    this.description,
  });

  @override
  List<Object?> get props => [id];
}
