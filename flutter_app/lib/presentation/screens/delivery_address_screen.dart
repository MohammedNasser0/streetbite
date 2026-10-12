import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../l10n/app_localizations.dart';
import '../widgets/delivery_pin_map.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key, this.initial});
  final Map<String, String>? initial;
  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _form = GlobalKey<FormState>();
  late LatLng? _pin = DeliveryPinMap.fromAddress(widget.initial);
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
            DeliveryPinMap(
              pin: _pin,
              onSelected: (pin) => setState(() => _pin = pin),
            ),
            const SizedBox(height: 12),
            Text(l.pinInstructions),
            if (_pin != null)
              Text(
                '${l.selectedPin}: ${_pin!.latitude.toStringAsFixed(5)}, ${_pin!.longitude.toStringAsFixed(5)}',
                textDirection: TextDirection.ltr,
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
                  if (_pin != null) 'latitude': _pin!.latitude.toString(),
                  if (_pin != null) 'longitude': _pin!.longitude.toString(),
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
