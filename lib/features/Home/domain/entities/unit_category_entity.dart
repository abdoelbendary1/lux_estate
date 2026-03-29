import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UnitCategoryEntity extends Equatable {
  final String? id;
  final String? name;

  const UnitCategoryEntity({this.id, this.name});

  @override
  List<Object?> get props => [id];
}
