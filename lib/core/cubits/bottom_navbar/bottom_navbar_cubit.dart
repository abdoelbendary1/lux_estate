import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavbarVisibilityCubit extends Cubit<bool> {
  NavbarVisibilityCubit() : super(true); // visible initially

  void show() => emit(true);
  void hide() => emit(false);
}
