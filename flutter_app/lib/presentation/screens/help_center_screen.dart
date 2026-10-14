import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.helpCenter)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ExpansionTile(
            title: Text(l.helpDemoTitle),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            children: [Text(l.helpDemoBody)],
          ),
          ExpansionTile(
            title: Text(l.helpOfflineTitle),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            children: [Text(l.helpOfflineBody)],
          ),
          ExpansionTile(
            title: Text(l.helpAccountTitle),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            children: [Text(l.helpAccountBody)],
          ),
        ],
      ),
    );
  }
}
