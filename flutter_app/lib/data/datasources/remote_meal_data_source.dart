import 'package:dio/dio.dart';

import '../../core/errors/app_failure.dart';
import '../models/meal_model.dart';
import 'meal_data_source.dart';

class RemoteMealDataSource implements MealDataSource {
  RemoteMealDataSource(this.client);
  final Dio client;
  @override
  Future<List<MealModel>> search(String query) async {
    try {
      final response = await client.get<Map<String, dynamic>>(
        'search.php',
        queryParameters: {'s': query},
      );
      final raw = response.data?['meals'];
      if (raw == null) return [];
      if (raw is! List) throw const AppFailure('invalidData');
      return raw
          .map(
            (item) =>
                MealModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .where((meal) => meal.id.isNotEmpty && meal.name.isNotEmpty)
          .toList();
    } on DioException {
      throw const AppFailure('networkError');
    } on FormatException {
      throw const AppFailure('invalidData');
    } on TypeError {
      throw const AppFailure('invalidData');
    }
  }
}
