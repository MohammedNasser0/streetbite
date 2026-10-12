import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/entities/cart_item.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import 'meal_image.dart';

class CartItemRow extends StatelessWidget {
  const CartItemRow(this.item, {super.key});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cart = context.read<CartBloc>();
    final controls = DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: item.quantity == 1 ? l.remove : l.decreaseQuantity,
            onPressed: () => cart.add(DecreaseMeal(item.meal.id)),
            icon: Icon(
              item.quantity == 1 ? Icons.delete_outline : Icons.remove,
            ),
          ),
          Text(
            '${item.quantity}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            tooltip: l.increaseQuantity,
            onPressed: () => cart.add(AddMeal(item.meal)),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: MealImage(item.meal.image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final description = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.meal.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(price(context, item.meal.demoPriceInPiastres)),
                  ],
                );
                if (constraints.maxWidth < 240) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      description,
                      const SizedBox(height: 8),
                      controls,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: description),
                    controls,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
