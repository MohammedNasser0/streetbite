import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF00C874),
      body: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 700),
          builder: (context, opacity, child) =>
              Opacity(opacity: opacity, child: child),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Icon(
                  Icons.ramen_dining_rounded,
                  size: 140,
                  color: Colors.white,
                ),
                const SizedBox(height: 32),
                Text(
                  l.appName,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  l.welcome,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  ),
                  child: Text(l.start),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
