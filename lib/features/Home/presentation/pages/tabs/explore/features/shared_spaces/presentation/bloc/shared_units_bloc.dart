import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shared_units_event.dart';
part 'shared_units_state.dart';

class SharedUnitsBloc extends Bloc<SharedUnitsEvent, SharedUnitsState> {
  SharedUnitsBloc() : super(SharedUnitsInitial()) {
    on<SharedUnitsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
