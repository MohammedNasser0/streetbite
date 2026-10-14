import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_state.dart';
import 'checkout_screen.dart';
import '../widgets/cart_item_row.dart';

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
                      padding: const EdgeInsets.only(top: 12),
                      children: [
                        ...state.items.map(CartItemRow.new),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(l.seeMenu),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Divider(),
                              _SummaryRow(
                                l.subtotal,
                                price(context, state.totalInPiastres),
                              ),
                              _SummaryRow(
                                l.additionalCharges,
                                price(context, 0),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l.noDemoCharges,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CheckoutScreen(),
                                ),
                              ),
                              child: Text(l.placeOrder),
                            ),
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Text(value),
      ],
    ),
  );
}
