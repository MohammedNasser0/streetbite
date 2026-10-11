import 'package:flutter/material.dart';

class MealImage extends StatelessWidget {
  const MealImage(this.url, {super.key});
  final String url;
  @override
  Widget build(BuildContext context) => Image.network(
    url,
    fit: BoxFit.cover,
    width: double.infinity,
    cacheWidth: 640,
    errorBuilder: (_, error, stack) =>
        const Center(child: Icon(Icons.restaurant, size: 48)),
    loadingBuilder: (_, child, progress) => progress == null
        ? child
        : const Center(child: CircularProgressIndicator()),
  );
}
