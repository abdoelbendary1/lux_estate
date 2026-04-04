import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
 class LocationEntity extends Equatable {
  final String? enName;
  final String? arName;
  final String? latitude;
  final String? longitude;

  const LocationEntity({this.enName   , this.arName, this.latitude, this.longitude});

  @override
  List<Object?> get props => [enName, arName, latitude, longitude];
}
