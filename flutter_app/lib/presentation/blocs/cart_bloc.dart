import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddMeal>((event, emit) {
      final items = [...state.items];
      final index = items.indexWhere((item) => item.meal.id == event.meal.id);
      if (index < 0) {
        items.add(CartItem(event.meal, 1));
      } else {
        items[index] = CartItem(items[index].meal, items[index].quantity + 1);
      }
      emit(CartState(items));
    });
    on<RemoveMeal>(
      (event, emit) => emit(
        CartState(state.items.where((item) => item.meal.id != event.id)),
      ),
    );
    on<DecreaseMeal>((event, emit) {
      emit(
        CartState([
          for (final item in state.items)
            if (item.meal.id != event.id)
              item
            else if (item.quantity > 1)
              CartItem(item.meal, item.quantity - 1),
        ]),
      );
    });
    on<ClearCart>((event, emit) => emit(CartState([])));
  }
}
