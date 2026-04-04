import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';

part 'filter_state.dart';

@injectable
class FilterBloc extends Cubit<FilterState> {
  FilterBloc() : super(FilterState());

  void updateAccommodation(String val) =>
      emit(state.copyWith(accommodationType: val));
  void updateProperty(String val) => emit(state.copyWith(propertyStyle: val));
  void updateGender(String val) => emit(state.copyWith(genderPolicy: val));

  void toggleAmenity(String val) {
    final list = List<String>.from(state.selectedAmenities);
    list.contains(val) ? list.remove(val) : list.add(val);
    emit(state.copyWith(selectedAmenities: list));
  }

  void reset() => emit(FilterState());
}
