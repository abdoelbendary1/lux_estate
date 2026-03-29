import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'property_details_event.dart';
part 'property_details_state.dart';

class PropertyDetailsBloc extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  PropertyDetailsBloc() : super(PropertyDetailsInitial()) {
    on<PropertyDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
