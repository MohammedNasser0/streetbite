import 'payment_method.dart';

class CashPayment implements PaymentMethod {
  @override
  String get code => 'cash';
  @override
  Future<void> authorize(int totalInPiastres) async {
    if (totalInPiastres <= 0) throw ArgumentError.value(totalInPiastres);
  }
}
