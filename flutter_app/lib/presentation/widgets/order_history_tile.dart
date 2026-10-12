import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/price.dart';
import '../../domain/entities/placed_order.dart';
import 'meal_image.dart';

class OrderHistoryTile extends StatelessWidget {
  const OrderHistoryTile({super.key, required this.order, required this.onTap});
  final PlacedOrder order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      minVerticalPadding: 12,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 64,
          height: 64,
          child: order.image.isEmpty
              ? ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.receipt_long),
                )
              : MealImage(order.image),
        ),
      ),
      title: Text(
        order.mealNames.join(', '),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          [
            price(context, order.totalInPiastres),
            if (date != null) DateFormat.yMMMd(locale).format(date.toLocal()),
          ].join('\n'),
        ),
      ),
      isThreeLine: date != null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
