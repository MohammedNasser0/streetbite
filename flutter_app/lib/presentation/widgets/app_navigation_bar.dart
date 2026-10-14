import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../screens/browse_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/profile_screen.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key, required this.selectedIndex});
  final int selectedIndex;

  void _navigate(BuildContext context, int index) {
    if (index == selectedIndex) return;
    if (index == 0) {
      // Home remains the root; switching sections does not accumulate routes.
      Navigator.popUntil(context, (route) => route.isFirst);
      return;
    }
    final destination = switch (index) {
      1 => const BrowseScreen(),
      2 => const OrdersScreen(),
      _ => const ProfileScreen(),
    };
    final route = MaterialPageRoute(builder: (_) => destination);
    if (selectedIndex == 0) {
      Navigator.push(context, route);
    } else {
      Navigator.pushReplacement(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    Color color(Set<WidgetState> states) =>
        states.contains(WidgetState.selected)
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color(states),
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(size: 22, color: color(states)),
          ),
        ),
        child: NavigationBar(
          height: 64,
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => _navigate(context, index),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              label: l.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.search),
              label: l.browse,
            ),
            NavigationDestination(
              icon: const Icon(Icons.receipt_long_outlined),
              label: l.orders,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              label: l.profile,
            ),
          ],
        ),
      ),
    );
  }
}
