import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/search_meals.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/menu_cubit.dart';
import '../blocs/menu_state.dart';
import '../widgets/meal_card.dart';
import '../widgets/app_navigation_bar.dart';
import '../widgets/category_tiles.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MenuCubit(services<SearchMeals>())..search(''),
    child: const _BrowseContent(),
  );
}

class _BrowseContent extends StatefulWidget {
  const _BrowseContent();
  @override
  State<_BrowseContent> createState() => _BrowseContentState();
}

class _BrowseContentState extends State<_BrowseContent> {
  bool _showCategories = true;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.browse)),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onSubmitted: (query) {
                setState(() => _showCategories = false);
                context.read<MenuCubit>().search(query);
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l.search,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          if (!_showCategories)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                icon: const Icon(Icons.grid_view),
                label: Text(l.categories),
                onPressed: () {
                  context.read<MenuCubit>().filterCategory(null);
                  setState(() => _showCategories = true);
                },
              ),
            ),
          Expanded(
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l.networkError),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: context.read<MenuCubit>().retry,
                            child: Text(l.retry),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state.meals.isEmpty) {
                  return Center(child: Text(l.noMeals));
                }
                if (_showCategories && state.categories.isNotEmpty) {
                  return CategoryTiles(
                    categories: state.categories,
                    onSelected: (category) {
                      context.read<MenuCubit>().filterCategory(category);
                      setState(() => _showCategories = false);
                    },
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 260,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: state.meals.length,
                  itemBuilder: (_, index) => MealCard(state.meals[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
