// Strategies follow OCP/DIP: checkout depends on this contract, not payment types.
abstract interface class PaymentMethod {
  String get code;
  Future<void> authorize(int totalInPiastres);
}
