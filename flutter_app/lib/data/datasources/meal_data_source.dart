import '../models/meal_model.dart';

abstract interface class MealDataSource {
  Future<List<MealModel>> search(String query);
}
