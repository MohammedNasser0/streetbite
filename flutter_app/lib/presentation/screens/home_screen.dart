import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_state.dart';
import '../blocs/menu_cubit.dart';
import '../blocs/menu_state.dart';
import '../blocs/locale_cubit.dart';
import '../blocs/theme_bloc.dart';
import '../widgets/meal_card.dart';
import '../widgets/meal_image.dart';
import '../widgets/cart_action.dart';
import '../widgets/app_navigation_bar.dart';
import 'more_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocListener<CartBloc, CartState>(
      listenWhen: (old, next) => next.count > old.count,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.added)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.appName),
          actions: [
            IconButton(
              tooltip: l.settings,
              icon: const Icon(Icons.more_horiz),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MoreScreen()),
              ),
            ),
            TextButton(
              onPressed: () => context.read<LocaleCubit>().toggle(),
              child: Text(l.language),
            ),
            IconButton(
              tooltip: l.theme,
              onPressed: () => context.read<ThemeBloc>().add(
                Theme.of(context).brightness == Brightness.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              ),
              icon: const Icon(Icons.contrast),
            ),
            const CartAction(),
          ],
        ),
        bottomNavigationBar: const AppNavigationBar(selectedIndex: 0),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) => CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.featured,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: context.read<MenuCubit>().search,
                            decoration: InputDecoration(
                              hintText: l.search,
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (state.categories.isNotEmpty)
                            SizedBox(
                              height: 88,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (final category in <String?>[
                                    null,
                                    ...state.categories,
                                  ])
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        end: 16,
                                      ),
                                      child: InkWell(
                                        onTap: () => context
                                            .read<MenuCubit>()
                                            .filterCategory(category),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 26,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              child: const Icon(
                                                Icons.restaurant_menu,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              category ?? l.all,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (state.meals.isNotEmpty)
                            SizedBox(
                              height: 180,
                              child: PageView(
                                children: state.meals
                                    .take(3)
                                    .map(
                                      (meal) => ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: MealImage(meal.image),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            l.offers,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          if (state.meals.isNotEmpty)
                            SizedBox(
                              height: 120,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: state.meals
                                    .take(5)
                                    .map(
                                      (meal) => Container(
                                        width: 130,
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                              end: 12,
                                            ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: MealImage(meal.image),
                                              ),
                                            ),
                                            Text(
                                              meal.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            l.recommended,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(l.demoPrices),
                        ],
                      ),
                    ),
                  ),
                  if (state.loading)
                    const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.error != null)
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Text(l.networkError),
                          TextButton(
                            onPressed: () =>
                                context.read<MenuCubit>().search(''),
                            child: Text(l.retry),
                          ),
                        ],
                      ),
                    )
                  else if (state.meals.isEmpty)
                    SliverToBoxAdapter(child: Center(child: Text(l.noMeals)))
                  else
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.sizeOf(context).width > 700
                              ? 4
                              : 2,
                          mainAxisExtent: 260,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: state.meals.length,
                        itemBuilder: (_, index) => MealCard(state.meals[index]),
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
