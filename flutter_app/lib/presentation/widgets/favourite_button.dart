import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/meal.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/auth_cubit.dart';
import '../screens/auth_screen.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (!services.isRegistered<AuthCubit>()) {
      return IconButton(
        tooltip: l.save,
        onPressed: () =>
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(l.firebaseSetup))),
        icon: const Icon(Icons.favorite_border),
      );
    }
    final user = context.watch<AuthCubit>().state.user;
    if (user == null) {
      return IconButton(
        tooltip: l.save,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        ),
        icon: const Icon(Icons.favorite_border),
      );
    }
    final store = services<ProfileRepository>();
    return StreamBuilder<List<Meal>>(
      stream: store.watchFavourites(user.id),
      builder: (context, snapshot) {
        final saved = snapshot.data?.any((item) => item.id == meal.id) ?? false;
        return IconButton(
          tooltip: saved ? l.unsave : l.save,
          icon: Icon(saved ? Icons.favorite : Icons.favorite_border),
          onPressed: () async {
            try {
              await store.saveFavourite(user.id, meal, !saved);
            } catch (_) {
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(l.networkError)));
              }
            }
          },
        );
      },
    );
  }
}
