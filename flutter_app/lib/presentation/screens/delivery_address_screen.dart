import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key, this.initial});
  final Map<String, String>? initial;
  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _address = TextEditingController(
    text: widget.initial?['address'],
  );
  late final TextEditingController _apartment = TextEditingController(
    text: widget.initial?['apartment'],
  );
  late final TextEditingController _comment = TextEditingController(
    text: widget.initial?['comment'],
  );
  @override
  void dispose() {
    _address.dispose();
    _apartment.dispose();
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.deliveryAddress)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, size: 56),
                    Text(l.enterAddress),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _address,
              decoration: InputDecoration(labelText: l.address),
              validator: (value) =>
                  (value?.trim().length ?? 0) < 5 ? l.addressError : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _apartment,
              decoration: InputDecoration(labelText: l.apartment),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _comment,
              decoration: InputDecoration(labelText: l.comment),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                if (!_form.currentState!.validate()) return;
                Navigator.pop(context, {
                  'address': _address.text.trim(),
                  'apartment': _apartment.text.trim(),
                  'comment': _comment.text.trim(),
                });
              },
              child: Text(l.saveAddress),
            ),
          ],
        ),
      ),
    );
  }
}
