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

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.placeOrder)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(l.demoPrices),
            const SizedBox(height: 20),
            if (DeliveryPinMap.fromAddress(_address) != null) ...[
              DeliveryPinMap(
                key: ValueKey(
                  '${_address?['latitude']},${_address?['longitude']}',
                ),
                pin: DeliveryPinMap.fromAddress(_address),
              ),
              const SizedBox(height: 12),
            ],
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(_address?['address'] ?? l.deliveryAddress),
              subtitle: Text(_address?['comment'] ?? l.addDetails),
              trailing: const Icon(Icons.chevron_right),
              onTap: _busy
                  ? null
                  : () async {
                      final result = await Navigator.push<Map<String, String>>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DeliveryAddressScreen(initial: _address),
                        ),
                      );
                      if (mounted && result != null) {
                        setState(() => _address = result);
                      }
                    },
            ),
            const SizedBox(height: 24),
            DropdownButton<String>(
              value: _payment.code,
              isExpanded: true,
              items: [
                DropdownMenuItem(value: 'cash', child: Text(l.cash)),
                DropdownMenuItem(value: 'demo-card', child: Text(l.card)),
              ],
              onChanged: _busy ? null : _selectPayment,
            ),
            const SizedBox(height: 24),
            Text(
              '${l.total}: ${price(context, context.watch<CartBloc>().state.totalInPiastres)}',
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _busy ? null : _order,
              child: _busy
                  ? const CircularProgressIndicator()
                  : Text(l.placeOrder),
            ),
          ],
        ),
      ),
    );
  }
}
