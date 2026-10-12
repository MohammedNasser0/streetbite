import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Figma's Add card layout, using fixed demo values without card-data input.
class DemoCardScreen extends StatelessWidget {
  const DemoCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    Widget field(String label, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        child: Text(value, textDirection: TextDirection.ltr),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l.addDemoCard,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(l.demoCardNotice),
            const SizedBox(height: 24),
            field(l.cardNumber, '•••• •••• •••• 4242'),
            field(l.cardholder, l.demoCardholder),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: field(l.expiry, '12/30')),
                const SizedBox(width: 8),
                Expanded(child: field(l.securityCode, '•••')),
                const SizedBox(width: 8),
                Expanded(child: field(l.postalCode, '00000')),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l.useDemoCard),
        ),
      ),
    );
  }
}
