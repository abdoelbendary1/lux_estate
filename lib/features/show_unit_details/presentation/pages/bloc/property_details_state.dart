part of 'property_details_bloc.dart';

sealed class PropertyDetailsState extends Equatable {
  const PropertyDetailsState();
  
  @override
  List<Object> get props => [];
}

final class PropertyDetailsInitial extends PropertyDetailsState {}
