import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user_model.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/cart_item.dart';
import '../../data/models/meal_model.dart';
import '../../domain/entities/meal.dart';

// Singleton: one shared Firestore gateway; dependencies are still injectable.
class FirestoreService {
  FirestoreService._(this.db);
  static FirestoreService? _instance;
  static FirestoreService instance(FirebaseFirestore db) =>
      _instance ??= FirestoreService._(db);
  final FirebaseFirestore db;
  DocumentReference<Map<String, dynamic>> _user(String uid) =>
      db.collection('users').doc(uid);
  Future<void> saveProfile(AppUser user) => _user(user.id).set(
    UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      photo: user.photo,
    ).toJson(),
    SetOptions(merge: true),
  );
  Stream<UserModel> profile(String uid) =>
      _user(uid)
          .snapshots()
          .map((snap) => UserModel.fromJson({...?snap.data(), 'id': uid}));
  Future<void> setPhoto(String uid, String photo) =>
      _user(uid).set({'photo': photo}, SetOptions(merge: true));
  Stream<List<Meal>> favourites(String uid) => _user(uid)
      .collection('favourites')
      .snapshots()
      .map(
        (snap) =>
            snap.docs.map((doc) => MealModel.fromJson(doc.data())).toList(),
      );
  Future<void> favourite(String uid, Meal meal, bool saved) {
    final ref = _user(uid).collection('favourites').doc(meal.id);
    return saved
        ? ref.set({
            'idMeal': meal.id,
            'strMeal': meal.name,
            'strCategory': meal.category,
            'strArea': meal.area,
            'strMealThumb': meal.image,
            'strInstructions': meal.instructions,
          })
        : ref.delete();
  }

  Future<void> order(
    String uid,
    List<CartItem> items,
    String payment,
    String requestId,
    Map<String, String> address,
  ) async {
    final ref = _user(uid).collection('orders').doc(requestId);
    await db.runTransaction((transaction) async {
      final existing = await transaction.get(ref);
      if (existing.exists) return;
      transaction.set(ref, {
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
        'payment': payment,
        'currency': 'EGP',
        'totalInPiastres': items.fold<int>(
          0,
          (total, item) => total + item.totalInPiastres,
        ),
        'items': items
            .map(
              (item) => {
                'id': item.meal.id,
                'name': item.meal.name,
                'image': item.meal.image,
                'quantity': item.quantity,
                'priceInPiastres': item.meal.demoPriceInPiastres,
              },
            )
            .toList(),
      });
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> orders(String uid) =>
      _user(uid)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .snapshots();
}
