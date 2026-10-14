import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../screens/contact_screen.dart';
import '../screens/help_center_screen.dart';

class SupportLinks extends StatelessWidget {
  const SupportLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final forward = Icon(
      Directionality.of(context) == TextDirection.rtl
          ? Icons.chevron_left
          : Icons.chevron_right,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.chat_bubble_outline),
          title: Text(l.contactUs),
          trailing: forward,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactScreen()),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.info_outline),
          title: Text(l.helpCenter),
          trailing: forward,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
          ),
        ),
      ],
    );
  }
}
