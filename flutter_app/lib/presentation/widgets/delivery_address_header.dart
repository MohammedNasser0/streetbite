import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/delivery_address_cubit.dart';
import '../screens/delivery_address_screen.dart';

class DeliveryAddressHeader extends StatelessWidget {
  const DeliveryAddressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final draft = services<DeliveryAddressCubit>();
    final l = AppLocalizations.of(context)!;
    return BlocBuilder<DeliveryAddressCubit, Map<String, String>?>(
      bloc: draft,
      builder: (context, address) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          Icons.location_on_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          address?['address'] ?? l.deliveryAddress,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.expand_more),
        onTap: () async {
          final result = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(
              builder: (_) => DeliveryAddressScreen(initial: address),
            ),
          );
          if (context.mounted && result != null) draft.select(result);
        },
      ),
    );
  }
}
