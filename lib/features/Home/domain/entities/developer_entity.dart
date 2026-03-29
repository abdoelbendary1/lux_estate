import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class DeveloperEntity extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? jobTitles;
  final String? description;

  const DeveloperEntity({
    this.id,
    this.name,
    this.imageUrl,
    this.jobTitles,
    this.description,
  });

  @override
  List<Object?> get props => [id];
}
