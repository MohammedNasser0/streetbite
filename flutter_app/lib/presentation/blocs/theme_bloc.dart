import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeMode, ThemeMode> {
  ThemeBloc(SharedPreferences preferences)
    : super(
        preferences.getBool('dark') == true ? ThemeMode.dark : ThemeMode.light,
      ) {
    on<ThemeMode>((event, emit) async {
      emit(event);
      await preferences.setBool('dark', event == ThemeMode.dark);
    });
  }
}
