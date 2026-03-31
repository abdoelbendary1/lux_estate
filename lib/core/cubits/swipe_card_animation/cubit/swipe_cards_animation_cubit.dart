import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'swipe_cards_animation_state.dart';

@injectable
class SwipeCardsAnimationCubit extends Cubit<int> {
  SwipeCardsAnimationCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
