import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/placed_order.dart';

class OrderModel extends PlacedOrder {
  const OrderModel({
    required super.id,
    required super.payment,
    required super.totalInPiastres,
    required super.mealNames,
    super.createdAt,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as String? ?? '',
    payment: json['payment'] as String? ?? 'cash',
    totalInPiastres: (json['totalInPiastres'] as num?)?.toInt() ?? 0,
    createdAt: switch (json['createdAt']) {
      Timestamp stamp => stamp.toDate(),
      String date => DateTime.tryParse(date),
      _ => null,
    },
    mealNames: (json['items'] as List? ?? [])
        .map((item) => (item as Map)['name'] as String? ?? '')
        .toList(),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'payment': payment,
    'totalInPiastres': totalInPiastres,
    'createdAt': createdAt?.toIso8601String(),
    'items': mealNames.map((name) => {'name': name}).toList(),
  };
}
