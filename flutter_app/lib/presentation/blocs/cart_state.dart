import '../../domain/entities/cart_item.dart';

class CartState {
  CartState(Iterable<CartItem> items) : items = List.unmodifiable(items);
  final List<CartItem> items;
  int get count => items.fold(0, (total, item) => total + item.quantity);
  int get totalInPiastres =>
      items.fold(0, (total, item) => total + item.totalInPiastres);
}
