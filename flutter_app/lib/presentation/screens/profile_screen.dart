import 'dart:convert';

import '../../core/services/device_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/app_user.dart';
import '../../core/price.dart';
import '../../domain/entities/placed_order.dart';
import '../../domain/entities/meal.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import 'auth_screen.dart';
import 'more_screen.dart';
import '../widgets/app_navigation_bar.dart';
import '../widgets/support_links.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _unlocked = false, _busy = false;
  String _device = '';
  ImageProvider? _profilePhoto(String? encoded) {
    if (encoded == null || encoded.isEmpty) return null;
    try {
      return MemoryImage(base64Decode(encoded));
    } on FormatException {
      return null;
    }
  }

  Future<void> _unlock() async {
    final l = AppLocalizations.of(context)!;
    try {
      final auth = LocalAuthentication();
      final allowed = await auth.authenticate(
        localizedReason: l.unlockProfile,
        biometricOnly: true,
      );
      if (!mounted || !allowed) return;
      setState(() => _unlocked = true);
      final info = await DeviceService().describe();
      if (mounted) {
        setState(() => _device = info);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.biometricUnavailable)));
      }
    }
  }

  Future<void> _photo(String uid) async {
    final l = AppLocalizations.of(context)!;
    setState(() => _busy = true);
    try {
      final photo = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 256,
        maxHeight: 256,
        imageQuality: 65,
      );
      if (photo == null) return;
      final bytes = await photo.readAsBytes();
      // A tiny thumbnail is stored in Firestore per the assignment; never a full photo.
      if (bytes.length > 200000) throw const FormatException();
      await services<ProfileRepository>().savePhoto(uid, base64Encode(bytes));
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.photoError)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (!services.isRegistered<AuthCubit>()) {
      return Scaffold(
        appBar: AppBar(title: Text(l.profile)),
        bottomNavigationBar: const AppNavigationBar(selectedIndex: 3),
        body: Center(child: Text(l.firebaseSetup)),
      );
    }
    final auth = context.watch<AuthCubit>();
    final user = auth.state.user;
    if (user == null) return const AuthScreen();
    if (!_unlocked) {
      return Scaffold(
        appBar: AppBar(title: Text(l.profile)),
        bottomNavigationBar: const AppNavigationBar(selectedIndex: 3),
        body: Center(
          child: FilledButton(onPressed: _unlock, child: Text(l.unlockProfile)),
        ),
      );
    }
    final store = services<ProfileRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l.profile),
        actions: [
          IconButton(
            tooltip: l.logout,
            onPressed: () async {
              await auth.logout();
              if (mounted) setState(() => _unlocked = false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 3),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder<AppUser>(
            stream: store.watchProfile(user.id),
            builder: (context, snap) {
              final profile = snap.data;
              if (snap.hasError) return Text(l.networkError);
              final photo = _profilePhoto(profile?.photo);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: photo,
                    onBackgroundImageError: photo == null ? null : (_, _) {},
                    child: photo != null
                        ? null
                        : const Icon(Icons.person, size: 48),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile?.name ?? user.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(user.email),
                  TextButton(
                    onPressed: _busy ? null : () => _photo(user.id),
                    child: Text(l.changePhoto),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.tune),
            title: Text(l.settingsTitle),
            trailing: Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Icons.chevron_left
                  : Icons.chevron_right,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MoreScreen()),
            ),
          ),
          const SupportLinks(),
          const Divider(),
          Text(_device),
          const SizedBox(height: 24),
          Text(l.favourites, style: Theme.of(context).textTheme.titleLarge),
          StreamBuilder<List<Meal>>(
            stream: store.watchFavourites(user.id),
            builder: (context, snap) => snap.hasError
                ? Text(l.networkError)
                : Column(
                    children: (snap.data ?? [])
                        .map(
                          (meal) => ListTile(
                            title: Text(meal.name),
                            trailing: IconButton(
                              tooltip: l.add,
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  context.read<CartBloc>().add(AddMeal(meal)),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 24),
          Text(l.orders, style: Theme.of(context).textTheme.titleLarge),
          StreamBuilder<List<PlacedOrder>>(
            stream: store.watchOrders(user.id),
            builder: (context, snap) => snap.hasError
                ? Text(l.networkError)
                : Column(
                    children: (snap.data ?? [])
                        .map(
                          (doc) => ListTile(
                            title: Text(doc.id),
                            subtitle: Text(
                              '${doc.payment == 'cash' ? l.cash : l.card} • ${price(context, doc.totalInPiastres)}',
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
