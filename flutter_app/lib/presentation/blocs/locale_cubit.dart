import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this.preferences)
    : super(Locale(preferences.getString('locale') ?? 'en'));
  final SharedPreferences preferences;
  Future<void> toggle() async {
    final language = state.languageCode == 'en' ? 'ar' : 'en';
    emit(Locale(language));
    await preferences.setString('locale', language);
  }
}
