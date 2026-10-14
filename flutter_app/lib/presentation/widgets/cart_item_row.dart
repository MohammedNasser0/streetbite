import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/entities/cart_item.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import 'meal_image.dart';
import 'quantity_control.dart';

class CartItemRow extends StatelessWidget {
  const CartItemRow(this.item, {super.key});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartBloc>();
    final controls = QuantityControl(
      quantity: item.quantity,
      onDecrease: () => cart.add(DecreaseMeal(item.meal.id)),
      onIncrease: () => cart.add(AddMeal(item.meal)),
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
