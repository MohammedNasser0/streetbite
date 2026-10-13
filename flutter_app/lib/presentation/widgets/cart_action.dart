import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_state.dart';
import '../screens/cart_screen.dart';

class CartAction extends StatelessWidget {
  const CartAction({super.key, this.feedback = false});
  final bool feedback;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (old, next) => feedback && next.count > old.count,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.added)));
        }
      },
      builder: (context, state) => IconButton(
        tooltip: l.cart,
        icon: Badge(
          label: Text('${state.count}'),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        ),
      ),
    );
  }
}
