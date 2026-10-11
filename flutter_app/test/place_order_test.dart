import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/cart_item.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/domain/payments/cash_payment.dart';
import 'package:streetbite_app/domain/repositories/order_repository.dart';
import 'package:streetbite_app/domain/usecases/place_order.dart';

class RecordingOrders implements OrderRepository {
  int calls = 0;
  @override
  Future<void> place(
    String uid,
    List<CartItem> items,
    String payment,
    String requestId,
    Map<String, String> address,
  ) async {
    calls++;
  }
}

void main() {
  const meal = Meal(
    id: '1',
    name: 'Meal',
    category: '',
    area: '',
    image: '',
    instructions: '',
  );
  test('Invalid order never reaches data layer', () async {
    final repo = RecordingOrders();
    final usecase = PlaceOrder(repo);
    await expectLater(
      usecase(
        uid: 'u',
        items: [],
        payment: CashPayment(),
        requestId: 'r',
        address: {'address': 'A'},
      ),
      throwsArgumentError,
    );
    await expectLater(
      usecase(
        uid: 'u',
        items: [const CartItem(meal, 1)],
        payment: CashPayment(),
        requestId: 'r',
        address: {},
      ),
      throwsArgumentError,
    );
    expect(repo.calls, 0);
  });
  test('Valid order delegates once after payment validation', () async {
    final repo = RecordingOrders();
    await PlaceOrder(repo)(
      uid: 'u',
      items: [const CartItem(meal, 2)],
      payment: CashPayment(),
      requestId: 'r',
      address: {'address': 'Cairo street 1'},
    );
    expect(repo.calls, 1);
  });
}
