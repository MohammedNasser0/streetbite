import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class QuantityControl extends StatelessWidget {
  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: quantity == 1 ? l.remove : l.decreaseQuantity,
            onPressed: onDecrease,
            icon: Icon(quantity == 1 ? Icons.delete_outline : Icons.remove),
          ),
          Text('$quantity', style: Theme.of(context).textTheme.titleMedium),
          IconButton(
            tooltip: l.increaseQuantity,
            onPressed: onIncrease,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
