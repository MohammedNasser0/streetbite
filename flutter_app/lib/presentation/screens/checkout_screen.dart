import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/price.dart';
import '../../domain/usecases/place_order.dart';
import '../../domain/payments/cash_payment.dart';
import '../../domain/payments/card_payment.dart';
import '../../domain/payments/payment_method.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../widgets/delivery_pin_map.dart';
import 'auth_screen.dart';
import 'delivery_address_screen.dart';
import 'demo_card_screen.dart';
import 'order_progress_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _payment = CashPayment();
  bool _busy = false;
  String? _requestId;
  Map<String, String>? _address;
  Future<void> _selectPayment(String? value) async {
    if (value == null || _busy) return;
    if (value == 'demo-card') {
      final confirmed = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => const DemoCardScreen()),
      );
      if (!mounted || confirmed != true) return;
    }
    setState(() {
      _payment = value == 'cash' ? CashPayment() : CardPayment();
    });
  }

  Future<void> _order() async {
    final l = AppLocalizations.of(context)!;
    if (!services.isRegistered<AuthCubit>()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.firebaseSetup)));
      return;
    }
    final user = context.read<AuthCubit>().state.user;
    if (user == null) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
      return;
    }
    final cart = context.read<CartBloc>();
    final snapshot = cart.state;
    if (_busy || snapshot.items.isEmpty) return;
    if (_address == null) {
      final result = await Navigator.push<Map<String, String>>(
        context,
        MaterialPageRoute(builder: (_) => const DeliveryAddressScreen()),
      );
      if (!mounted || result == null) return;
      setState(() => _address = result);
    }
    setState(() => _busy = true);
    // The same request ID is reused on retries to avoid creating duplicate orders.
    _requestId ??= '${DateTime.now().microsecondsSinceEpoch}';
    try {
      await services<PlaceOrder>()(
        uid: user.id,
        items: snapshot.items,
        payment: _payment,
        requestId: _requestId!,
        address: _address!,
      );
      if (!mounted) return;
      cart.add(ClearCart());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.orderPlaced)));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderProgressScreen(orderId: _requestId!),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.networkError)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _editAddress() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => DeliveryAddressScreen(initial: _address),
      ),
    );
    if (mounted && result != null) setState(() => _address = result);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cart = context.watch<CartBloc>().state;
    final user = services.isRegistered<AuthCubit>()
        ? context.watch<AuthCubit>().state.user
        : null;
    final comment = _address?['comment']?.trim() ?? '';
    final apartment = _address?['apartment']?.trim() ?? '';
    final forward = Icon(
      Directionality.of(context) == TextDirection.rtl
          ? Icons.chevron_left
          : Icons.chevron_right,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l.checkout)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l.checkoutNotice, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          if (DeliveryPinMap.fromAddress(_address) != null) ...[
            DeliveryPinMap(
              key: ValueKey(
                '${_address?['latitude']},${_address?['longitude']}',
              ),
              pin: DeliveryPinMap.fromAddress(_address),
            ),
            const SizedBox(height: 16),
          ],
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on_outlined),
            title: Text(_address?['address'] ?? l.deliveryAddress),
            subtitle: Text(apartment.isEmpty ? l.enterAddress : apartment),
            trailing: forward,
            onTap: _busy ? null : _editAddress,
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.description_outlined),
            title: Text(l.deliveryInstructions),
            subtitle: Text(comment.isEmpty ? l.addDetails : comment),
            trailing: forward,
            onTap: _busy ? null : _editAddress,
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.mail_outline),
            title: Text(l.contactDetails),
            subtitle: Text(user?.email ?? l.login),
            onTap: user == null && !_busy
                ? () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                  )
                : null,
          ),
          const Divider(),
          const SizedBox(height: 16),
          InputDecorator(
            decoration: InputDecoration(
              labelText: l.paymentMethod,
              prefixIcon: const Icon(Icons.payments_outlined),
              border: const OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _payment.code,
                isExpanded: true,
                items: [
                  DropdownMenuItem(value: 'cash', child: Text(l.cash)),
                  DropdownMenuItem(value: 'demo-card', child: Text(l.card)),
                ],
                onChanged: _busy ? null : _selectPayment,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${l.total}: ${price(context, cart.totalInPiastres)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: _busy || cart.items.isEmpty ? null : _order,
                child: _busy
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l.placeOrder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
