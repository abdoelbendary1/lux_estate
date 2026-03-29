part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final String accommodationType;
  final String propertyStyle;
  final String genderPolicy;
  final List<String> selectedAmenities;

  const FilterState({
    this.accommodationType = 'All',
    this.propertyStyle = 'Villa',
    this.genderPolicy = 'Any',
    this.selectedAmenities = const ['WiFi', 'Gym'],
  });

  FilterState copyWith({
    String? accommodationType,
    String? propertyStyle,
    String? genderPolicy,
    List<String>? selectedAmenities,
  }) {
    return FilterState(
      accommodationType: accommodationType ?? this.accommodationType,
      propertyStyle: propertyStyle ?? this.propertyStyle,
      genderPolicy: genderPolicy ?? this.genderPolicy,
      selectedAmenities: selectedAmenities ?? this.selectedAmenities,
    );
  }

  @override
  List<Object> get props => [];
}

final class FilterInitial extends FilterState {}
