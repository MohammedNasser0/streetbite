class Meal {
  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.image,
    required this.instructions,
  });
  final String id, name, category, area, image, instructions;
  // TheMealDB has no prices. These are educational demo prices, not quotes.
  int get demoPriceInPiastres => 8500 + (int.tryParse(id) ?? 0) % 10 * 1000;
}
