import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class OrderProgressScreen extends StatelessWidget {
  const OrderProgressScreen({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.orderPlaced)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.check_circle, size: 100, color: Color(0xFF00C874)),
          Text(
            l.orderReceived,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(orderId),
          const SizedBox(height: 24),
          Text(l.demoOrderNotice),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.check_circle, color: Color(0xFF00C874)),
            title: Text(l.orderReceived),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text(l.cooking),
            subtitle: Text(l.notStarted),
          ),
          ListTile(
            leading: const Icon(Icons.delivery_dining),
            title: Text(l.courier),
            subtitle: Text(l.notStarted),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(l.delivered),
            subtitle: Text(l.notStarted),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: Text(l.home),
          ),
        ],
      ),
    );
  }
}
