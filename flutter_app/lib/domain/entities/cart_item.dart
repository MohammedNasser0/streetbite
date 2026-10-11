import 'meal.dart';

class CartItem {
  const CartItem(this.meal, this.quantity);
  final Meal meal;
  final int quantity;
  int get totalInPiastres => meal.demoPriceInPiastres * quantity;
}
