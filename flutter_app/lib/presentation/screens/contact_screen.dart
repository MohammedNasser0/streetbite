import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/project_info.dart';
import '../../l10n/app_localizations.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.contactUs)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Icon(Icons.chat_bubble_outline, size: 40),
          ),
          const SizedBox(height: 20),
          Text(l.contactIntro, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),
          const SelectableText(
            projectRepositoryUrl,
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () async {
              await Clipboard.setData(
                const ClipboardData(text: projectRepositoryUrl),
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(l.linkCopied)));
              }
            },
            icon: const Icon(Icons.copy_outlined),
            label: Text(l.copyProjectLink),
          ),
          const SizedBox(height: 12),
          Text(l.contactHint),
        ],
      ),
    );
  }
}
