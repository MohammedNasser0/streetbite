class PlacedOrder {
  const PlacedOrder({
    required this.id,
    required this.payment,
    required this.totalInPiastres,
    required this.mealNames,
    this.createdAt,
    this.image = '',
  });
  final String id, payment;
  final int totalInPiastres;
  final List<String> mealNames;
  final DateTime? createdAt;
  final String image;
}
