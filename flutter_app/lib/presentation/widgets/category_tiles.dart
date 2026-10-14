import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class CategoryTiles extends StatelessWidget {
  const CategoryTiles({
    super.key,
    required this.categories,
    required this.onSelected,
  });
  final List<String> categories;
  final ValueChanged<String?> onSelected;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            l.categories,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: MediaQuery.sizeOf(context).width > 700 ? 4 : 2,
            childAspectRatio: 1.65,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              for (final category in <String?>[null, ...categories])
                Material(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onSelected(category),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          Text(
                            category ?? l.all,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
