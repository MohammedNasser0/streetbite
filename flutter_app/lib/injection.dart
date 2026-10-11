import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/cached_meal_data_source.dart';
import 'data/datasources/remote_meal_data_source.dart';
import 'data/repositories/meal_repository_impl.dart';
import 'data/repositories/meal_source_factory.dart';
import 'domain/repositories/meal_repository.dart';
import 'domain/usecases/search_meals.dart';

final services = GetIt.instance;
Future<void> configureDependencies() async {
  final preferences = await SharedPreferences.getInstance();
  services.registerSingleton<SharedPreferences>(preferences);
  final dio = Dio(
    BaseOptions(
      baseUrl:
          'https://www.themealdb.com/api/json/v1/${const String.fromEnvironment('MEALDB_KEY', defaultValue: '1')}/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  final cache = CachedMealDataSource(preferences);
  services.registerSingleton<MealRepository>(
    MealRepositoryImpl(
      MealSourceFactory(remote: RemoteMealDataSource(dio), cached: cache),
      cache,
    ),
  );
  services.registerFactory(() => SearchMeals(services<MealRepository>()));
}
