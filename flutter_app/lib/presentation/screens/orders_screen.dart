import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/placed_order.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/auth_cubit.dart';
import '../widgets/order_history_tile.dart';
import 'auth_screen.dart';
import 'order_progress_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (!services.isRegistered<AuthCubit>()) {
      return Scaffold(
        appBar: AppBar(title: Text(l.orders)),
        body: Center(child: Text(l.firebaseSetup)),
      );
    }
    final user = context.watch<AuthCubit>().state.user;
    if (user == null) return const AuthScreen();
    return Scaffold(
      appBar: AppBar(title: Text(l.orders)),
      body: StreamBuilder<List<PlacedOrder>>(
        stream: services<ProfileRepository>().watchOrders(user.id),
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text(l.networkError));
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.data!.isEmpty) return Center(child: Text(l.noOrders));
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Text(
                  l.demoOrderNotice,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              ...snap.data!.map(
                (order) => OrderHistoryTile(
                  order: order,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderProgressScreen(orderId: order.id),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
