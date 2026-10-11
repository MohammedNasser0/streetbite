import '../datasources/meal_data_source.dart';

// Factory selects interchangeable sources without coupling callers to concrete types.
class MealSourceFactory {
  const MealSourceFactory({required this.remote, required this.cached});
  final MealDataSource remote, cached;
  MealDataSource create({required bool offline}) => offline ? cached : remote;
}
