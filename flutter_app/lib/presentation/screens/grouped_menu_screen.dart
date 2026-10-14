import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/entities/meal.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../widgets/cart_action.dart';
import '../widgets/meal_image.dart';
import 'cart_screen.dart';
import 'meal_details_screen.dart';

class GroupedMenuScreen extends StatefulWidget {
  const GroupedMenuScreen({super.key, required this.meals});
  final List<Meal> meals;
  @override
  State<GroupedMenuScreen> createState() => _GroupedMenuScreenState();
}

class _GroupedMenuScreenState extends State<GroupedMenuScreen> {
  String? _category;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final categories = widget.meals
        .map((m) => m.category)
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();
    final groups = <String, List<Meal>>{};
    for (final meal in widget.meals) {
      if (_category == null || meal.category == _category) {
        (groups[meal.category] ??= []).add(meal);
      }
    }
    final chips = Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          for (final category in <String?>[null, ...categories])
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: ChoiceChip(
                label: Text(category ?? l.all),
                selected: _category == category,
                onSelected: (_) => setState(() => _category = category),
              ),
            ),
        ],
      ),
    );
    return BlocListener<CartBloc, CartState>(
      listenWhen: (old, next) => next.count > old.count,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.added)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l.menuTitle), actions: const [CartAction()]),
        body: CustomScrollView(
          slivers: [
            if (widget.meals.isNotEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 220,
                  child: MealImage(widget.meals.first.image),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.menuTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(l.demoPrices),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _CategoryHeader(chips),
            ),
            if (groups.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text(l.noMeals)),
              ),
            SliverList.list(
              children: [
                for (final group in groups.entries) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                    child: Text(
                      group.key.isEmpty ? l.all : group.key,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  for (final meal in group.value)
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: MealImage(meal.image),
                        ),
                      ),
                      title: Text(
                        meal.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(price(context, meal.demoPriceInPiastres)),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MealDetailsScreen(meal),
                        ),
                      ),
                      trailing: IconButton(
                        tooltip: l.add,
                        onPressed: () =>
                            context.read<CartBloc>().add(AddMeal(meal)),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                ],
              ],
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) => state.count == 0
              ? const SizedBox.shrink()
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      ),
                      child: Text(
                        '${l.cart} • ${state.count} • ${price(context, state.totalInPiastres)}',
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _CategoryHeader extends SliverPersistentHeaderDelegate {
  _CategoryHeader(this.child);
  final Widget child;
  @override
  double get minExtent => 64;
  @override
  double get maxExtent => 64;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;
  @override
  bool shouldRebuild(_CategoryHeader oldDelegate) => true;
}
