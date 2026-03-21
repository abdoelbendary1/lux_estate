import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'obsecure_password_state.dart';
@injectable
class ObsecurePasswordCubit extends Cubit<ObsecurePasswordState> {
  ObsecurePasswordCubit() : super(ObsecurePasswordInitial());

  void toggleObsecure() {
    if (state is ObsecurePasswordInitial) {
      emit(ObsecurePasswordVisible());
    } else {
      emit(ObsecurePasswordInitial());
    }
  }
}
