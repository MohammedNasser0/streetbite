import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite_app/core/errors/app_failure.dart';
import 'package:streetbite_app/data/datasources/cached_meal_data_source.dart';
import 'package:streetbite_app/data/datasources/meal_data_source.dart';
import 'package:streetbite_app/data/models/meal_model.dart';
import 'package:streetbite_app/data/repositories/meal_repository_impl.dart';
import 'package:streetbite_app/data/repositories/meal_source_factory.dart';

class OfflineSource implements MealDataSource {
  @override
  Future<List<MealModel>> search(String query) async =>
      throw const AppFailure('networkError');
}

void main() {
  const meal = MealModel(
    id: '1',
    name: 'A',
    category: 'C',
    area: 'Egypt',
    image: '',
    instructions: 'Cook',
  );
  test(
    'Offline repository restores cached query including empty result',
    () async {
      SharedPreferences.setMockInitialValues({});
      final cache = CachedMealDataSource(await SharedPreferences.getInstance());
      await cache.save('a', [meal]);
      await cache.save('none', []);
      final repo = MealRepositoryImpl(
        MealSourceFactory(remote: OfflineSource(), cached: cache),
        cache,
      );
      expect((await repo.search('a')).single.name, 'A');
      expect(await repo.search('none'), isEmpty);
      await expectLater(repo.search('missing'), throwsA(isA<AppFailure>()));
    },
  );
  test('Corrupt cache is invalidated instead of crashing startup', () async {
    SharedPreferences.setMockInitialValues({'meals.v1.a': 'broken json'});
    final prefs = await SharedPreferences.getInstance();
    await expectLater(
      CachedMealDataSource(prefs).search('a'),
      throwsA(isA<AppFailure>()),
    );
    expect(prefs.containsKey('meals.v1.a'), isFalse);
  });
}
