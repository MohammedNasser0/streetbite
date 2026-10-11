import '../entities/app_user.dart';
import '../entities/meal.dart';
import '../entities/placed_order.dart';

abstract interface class ProfileRepository {
  Stream<AppUser> watchProfile(String uid);
  Stream<List<Meal>> watchFavourites(String uid);
  Stream<List<PlacedOrder>> watchOrders(String uid);
  Future<void> savePhoto(String uid, String photo);
  Future<void> saveFavourite(String uid, Meal meal, bool saved);
}
