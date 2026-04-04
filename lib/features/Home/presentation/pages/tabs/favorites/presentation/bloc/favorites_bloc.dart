import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
