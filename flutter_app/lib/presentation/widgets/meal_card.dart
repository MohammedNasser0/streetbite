import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/entities/meal.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../screens/meal_details_screen.dart';
import 'meal_image.dart';

class MealCard extends StatelessWidget {
  const MealCard(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(arguments: meal),
            builder: (_) => MealDetailsScreen(meal),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: MealImage(meal.image)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(meal.category, maxLines: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Text(price(context, meal.demoPriceInPiastres)),
                      ),
                      IconButton(
                        tooltip: l.add,
                        icon: const Icon(Icons.add_circle),
                        onPressed: () =>
                            context.read<CartBloc>().add(AddMeal(meal)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
