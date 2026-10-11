import '../entities/meal.dart';

abstract interface class MealRepository {
  Future<List<Meal>> search(String query);
}
