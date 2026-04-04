part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final String accommodationType;
  final String propertyStyle;
  final String genderPolicy;
  final List<String> selectedAmenities;
  final PropertyCategories selectedCategory;

  const FilterState({
    this.accommodationType = 'All',
    this.propertyStyle = 'Villa',
    this.genderPolicy = 'Any',
    this.selectedAmenities = const ['WiFi', 'Gym'],
    this.selectedCategory = PropertyCategories.all,
  });

  FilterState copyWith({
    String? accommodationType,
    String? propertyStyle,
    String? genderPolicy,
    List<String>? selectedAmenities,
    PropertyCategories? selectedCategory
  }) {
    return FilterState(
      accommodationType: accommodationType ?? this.accommodationType,
      propertyStyle: propertyStyle ?? this.propertyStyle,
      genderPolicy: genderPolicy ?? this.genderPolicy,
      selectedAmenities: selectedAmenities ?? this.selectedAmenities,
      selectedCategory: selectedCategory ?? this.selectedCategory
    );
  }

  @override
  List<Object> get props => [];
}

final class FilterInitial extends FilterState {}
