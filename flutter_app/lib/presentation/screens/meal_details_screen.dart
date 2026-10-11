import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/entities/meal.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../widgets/meal_image.dart';
import '../widgets/favourite_button.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.details), actions: [FavouriteButton(meal)]),
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
          child: FilledButton(
            onPressed: () {
              context.read<CartBloc>().add(AddMeal(meal));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(l.added)));
            },
            child: Text(
              '${l.add} • ${price(context, meal.demoPriceInPiastres)}',
            ),
          ),
        ),
      ),
    );
  }
}
