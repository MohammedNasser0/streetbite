import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.cart)),
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (old, next) => old.count > 0 && next.count == 0,
        listener: (context, state) =>
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(l.emptyCart))),
        builder: (context, state) => state.items.isEmpty
            ? Center(child: Text(l.emptyCart))
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: state.items
                          .map(
                            (item) => ListTile(
                              title: Text(item.meal.name),
                              subtitle: Text(
                                '${item.quantity} × ${price(context, item.meal.demoPriceInPiastres)}',
                              ),
                              trailing: IconButton(
                                tooltip: l.remove,
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => context.read<CartBloc>().add(
                                  RemoveMeal(item.meal.id),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            '${l.total}: ${price(context, state.totalInPiastres)}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(l.demoPrices),
                          FilledButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckoutScreen(),
                              ),
                            ),
                            child: Text(l.placeOrder),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
