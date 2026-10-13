import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/search_meals.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/menu_cubit.dart';
import '../blocs/menu_state.dart';
import '../widgets/meal_card.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MenuCubit(services<SearchMeals>())..search(''),
    child: Builder(
      builder: (context) {
        final l = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(title: Text(l.browse)),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onSubmitted: context.read<MenuCubit>().search,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: l.search,
                    prefixIcon: const Icon(Icons.search),
                  ),
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
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
      },
    ),
  );
}
