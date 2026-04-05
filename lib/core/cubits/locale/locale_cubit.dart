import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void toggleLanguage(BuildContext context) async {
    if (context.locale.languageCode == 'en') {
      await context.setLocale(const Locale('ar'));
      emit(const Locale('ar'));
    } else {
      await context.setLocale(const Locale('en'));
      emit(const Locale('en'));
    }
  }

  void updateLocale(Locale newLocale) => emit(newLocale);
  void setArabic(BuildContext context) async {
    await context.setLocale(const Locale('ar'));
    emit(const Locale('ar'));
  }

  void setEnglish(BuildContext context) async {
    await context.setLocale(const Locale('en'));
    emit(const Locale('en'));
  }
}
