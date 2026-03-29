import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
 class LocationEntity extends Equatable {
  final String? name;
  final String? latitude;
  final String? longitude;

  const LocationEntity({this.name, this.latitude, this.longitude});

  @override
  List<Object?> get props => [name, latitude, longitude];
}
