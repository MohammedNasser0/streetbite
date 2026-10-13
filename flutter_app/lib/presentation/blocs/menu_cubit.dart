import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/app_failure.dart';
import '../../domain/usecases/search_meals.dart';
import 'menu_state.dart';
import '../../domain/entities/meal.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.searchMeals) : super(const MenuState());
  final SearchMeals searchMeals;
  int _request = 0;
  List<Meal> _all = const [];
  String _lastQuery = '';

  Future<void> retry() => search(_lastQuery);
  void filterCategory(String? category) {
    emit(
      MenuState(
        meals: category == null
            ? _all
            : _all.where((meal) => meal.category == category).toList(),
        categories: _all
            .map((meal) => meal.category)
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList(),
      ),
    );
  }

  Future<void> search(String query) async {
    _lastQuery = query;
    final request = ++_request;
    emit(const MenuState(loading: true));
    try {
      final meals = await searchMeals(query);
      if (!isClosed && request == _request) {
        _all = List.unmodifiable(meals);
        filterCategory(null);
      }
    } catch (error) {
      if (!isClosed && request == _request) {
        emit(
          MenuState(error: error is AppFailure ? error.code : 'networkError'),
        );
      }
    }
  }
}
