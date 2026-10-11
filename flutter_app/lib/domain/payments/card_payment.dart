import 'payment_method.dart';

// Educational simulation only. Never collects or stores real card information.
class CardPayment implements PaymentMethod {
  @override
  String get code => 'demo-card';
  @override
  Future<void> authorize(int totalInPiastres) async {
    if (totalInPiastres <= 0) throw ArgumentError.value(totalInPiastres);
  }
}
