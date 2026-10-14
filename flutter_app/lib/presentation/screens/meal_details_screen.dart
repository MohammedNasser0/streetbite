import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/entities/meal.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../widgets/quantity_control.dart';
import '../widgets/meal_image.dart';
import '../widgets/favourite_button.dart';
import '../widgets/cart_action.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.details),
        actions: [FavouriteButton(meal), const CartAction(feedback: true)],
      ),
      body: ListView(
        children: [
          SizedBox(height: 280, child: MealImage(meal.image)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text('${meal.category} • ${meal.area}'),
                const SizedBox(height: 16),
                Text(
                  l.instructions,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(meal.instructions),
                const SizedBox(height: 20),
                Text(l.demoPrices),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final quantity = state.items
                      .where((item) => item.meal.id == meal.id)
                      .fold(0, (count, item) => count + item.quantity);
                  if (quantity == 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: QuantityControl(
                      quantity: quantity,
                      onDecrease: () =>
                          context.read<CartBloc>().add(DecreaseMeal(meal.id)),
                      onIncrease: () =>
                          context.read<CartBloc>().add(AddMeal(meal)),
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.read<CartBloc>().add(AddMeal(meal));
                  },
                  child: Text(
                    '${l.add} • ${price(context, meal.demoPriceInPiastres)}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
