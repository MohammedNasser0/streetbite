import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class SearchMeals {
  const SearchMeals(this.repository);
  final MealRepository repository;
  Future<List<Meal>> call(String query) => repository.search(query.trim());
}
