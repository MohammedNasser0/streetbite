import '../../core/services/firestore_service.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this.store);
  final FirestoreService store;
  @override
  Future<void> place(
    String uid,
    List<CartItem> items,
    String payment,
    String requestId,
    Map<String, String> address,
  ) => store.order(uid, items, payment, requestId, address);
}
