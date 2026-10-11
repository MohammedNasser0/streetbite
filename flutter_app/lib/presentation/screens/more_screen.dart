import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../blocs/locale_cubit.dart';
import '../blocs/theme_bloc.dart';
import 'vendor_map_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(l.language),
            onTap: () => context.read<LocaleCubit>().toggle(),
          ),
          ListTile(
            leading: const Icon(Icons.contrast),
            title: Text(l.theme),
            onTap: () => context.read<ThemeBloc>().add(
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: Text(l.vendors),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VendorMapScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
