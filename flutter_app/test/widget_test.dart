import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/data/models/meal_model.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/blocs/cart_event.dart';

void main() {
  const meal = MealModel(
    id: '52772',
    name: 'Meal',
    category: 'Chicken',
    area: 'Egyptian',
    image: '',
    instructions: 'Cook',
  );
  test(
    'Meal JSON round trip preserves details and tolerates null optional fields',
    () {
      expect(MealModel.fromJson(meal.toJson()).instructions, 'Cook');
      expect(
        MealModel.fromJson({'idMeal': '1', 'strMeal': 'A', 'strCategory': null})
            .category,
        '',
      );
    },
  );
  test(
    'Adding duplicate meals increments quantity and removing empties the cart',
    () async {
      final bloc = CartBloc();
      bloc.add(AddMeal(meal));
      await bloc.stream.firstWhere((state) => state.count == 1);
      bloc.add(AddMeal(meal));
      await bloc.stream.firstWhere((state) => state.count == 2);
      expect(bloc.state.items.length, 1);
      expect(bloc.state.totalInPiastres, meal.demoPriceInPiastres * 2);
      bloc.add(RemoveMeal(meal.id));
      await bloc.stream.firstWhere((state) => state.count == 0);
      expect(bloc.state.totalInPiastres, 0);
      await bloc.close();
    },
  );
}
