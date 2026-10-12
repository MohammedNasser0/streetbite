import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/placed_order.dart';

class OrderModel extends PlacedOrder {
  const OrderModel({
    required super.id,
    required super.payment,
    required super.totalInPiastres,
    required super.mealNames,
    super.createdAt,
    super.image,
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
    image: (json['items'] as List? ?? []).isEmpty
        ? ''
        : ((json['items'] as List).first as Map)['image'] as String? ?? '',
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'payment': payment,
    'totalInPiastres': totalInPiastres,
    'createdAt': createdAt?.toIso8601String(),
    'items': mealNames.indexed
        .map(
          (entry) => {
            'name': entry.$2,
            if (entry.$1 == 0 && image.isNotEmpty) 'image': image,
          },
        )
        .toList(),
  };
}
