import '../../core/services/firestore_service.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/meal.dart';
import '../../domain/entities/placed_order.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/order_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this.store);
  final FirestoreService store;
  @override
  Stream<AppUser> watchProfile(String uid) => store.profile(uid);
  @override
  Stream<List<Meal>> watchFavourites(String uid) => store.favourites(uid);
  @override
  Stream<List<PlacedOrder>> watchOrders(String uid) => store
      .orders(uid)
      .map(
        (snap) => snap.docs
            .map((doc) => OrderModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList(),
      );
  @override
  Future<void> savePhoto(String uid, String photo) =>
      store.setPhoto(uid, photo);
  @override
  Future<void> saveFavourite(String uid, Meal meal, bool saved) =>
      store.favourite(uid, meal, saved);
}
