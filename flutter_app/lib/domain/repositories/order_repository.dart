import '../entities/cart_item.dart';

abstract interface class OrderRepository {
  Future<void> place(
    String uid,
    List<CartItem> items,
    String payment,
    String requestId,
    Map<String, String> address,
  );
}
