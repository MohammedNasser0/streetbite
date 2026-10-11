import '../../domain/entities/meal.dart';

class MenuState {
  const MenuState({
    this.loading = false,
    this.meals = const [],
    this.categories = const [],
    this.error,
  });
  final bool loading;
  final List<Meal> meals;
  final List<String> categories;
  final String? error;
}
