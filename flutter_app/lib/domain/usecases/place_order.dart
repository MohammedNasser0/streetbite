import '../entities/cart_item.dart';
import '../payments/payment_method.dart';
import '../repositories/order_repository.dart';

class PlaceOrder {
  const PlaceOrder(this.repository);
  final OrderRepository repository;
  Future<void> call({
    required String uid,
    required List<CartItem> items,
    required PaymentMethod payment,
    required String requestId,
    required Map<String, String> address,
  }) async {
    if (uid.isEmpty ||
        items.isEmpty ||
        items.any((item) => item.quantity <= 0) ||
        (address['address'] ?? '').trim().isEmpty) {
      throw ArgumentError('Invalid order');
    }
    await payment.authorize(
      items.fold(0, (sum, item) => sum + item.totalInPiastres),
    );
    await repository.place(
      uid,
      List.unmodifiable(items),
      payment.code,
      requestId,
      address,
    );
  }
}
