import '../../core/errors/app_failure.dart';
import '../../domain/entities/meal.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/cached_meal_data_source.dart';
import 'meal_source_factory.dart';

class MealRepositoryImpl implements MealRepository {
  const MealRepositoryImpl(this.factory, this.cache);
  final MealSourceFactory factory;
  final CachedMealDataSource cache;
  @override
  Future<List<Meal>> search(String query) async {
    try {
      final meals = await factory.create(offline: false).search(query);
      try {
        await cache.save(query, meals);
      } catch (_) {
        /* Cache is best effort. */
      }
      return meals;
    } on AppFailure catch (failure) {
      if (failure.code != 'networkError') rethrow;
      try {
        return await factory.create(offline: true).search(query);
      } on AppFailure {
        throw failure;
      }
    }
  }
}
