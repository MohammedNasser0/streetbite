import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/errors/app_failure.dart';
import '../models/meal_model.dart';
import 'meal_data_source.dart';

class CachedMealDataSource implements MealDataSource {
  CachedMealDataSource(this.preferences);
  final SharedPreferences preferences;
  String _key(String query) => 'meals.v1.${query.trim().toLowerCase()}';
  Future<void> save(String query, List<MealModel> meals) async {
    await preferences.setString(
      _key(query),
      jsonEncode({
        'version': 1,
        'meals': meals.map((meal) => meal.toJson()).toList(),
      }),
    );
  }

  @override
  Future<List<MealModel>> search(String query) async {
    final value = preferences.getString(_key(query));
    if (value == null) throw const AppFailure('noCache');
    try {
      final json = jsonDecode(value) as Map<String, dynamic>;
      if (json['version'] != 1) throw const FormatException();
      return (json['meals'] as List)
          .map(
            (item) =>
                MealModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList();
    } catch (_) {
      await preferences.remove(_key(query));
      throw const AppFailure('noCache');
    }
  }
}
