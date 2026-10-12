import '../../domain/entities/meal.dart';

sealed class CartEvent {}

class AddMeal extends CartEvent {
  AddMeal(this.meal);
  final Meal meal;
}

class RemoveMeal extends CartEvent {
  RemoveMeal(this.id);
  final String id;
}

class DecreaseMeal extends CartEvent {
  DecreaseMeal(this.id);
  final String id;
}

class ClearCart extends CartEvent {}
