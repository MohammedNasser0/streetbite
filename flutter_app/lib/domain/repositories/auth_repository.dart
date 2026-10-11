import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get changes;
  Future<void> login(String email, String password);
  Future<void> signup(String name, String email, String password);
  Future<void> logout();
}
