import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_builder.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/services/firestore_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.auth, this.store);
  final FirebaseAuth auth;
  final FirestoreService store;
  @override
  Stream<AppUser?> get changes => auth.userChanges().map(
    (user) => user == null
        ? null
        : AppUser(
            id: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
          ),
  );
  @override
  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  @override
  Future<void> signup(String name, String email, String password) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = result.user!;
    await user.updateDisplayName(name.trim());
    final builder = UserBuilder()
      ..id = user.uid
      ..name = name
      ..email = email;
    await store.saveProfile(builder.build());
  }

  @override
  Future<void> logout() => auth.signOut();
}
