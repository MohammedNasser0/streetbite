import 'app_user.dart';

// Builder keeps construction and validation of user profiles in one place.
class UserBuilder {
  String id = '', name = '', email = '', photo = '';
  AppUser build() {
    if (id.isEmpty || name.trim().isEmpty || email.isEmpty) {
      throw ArgumentError('Invalid user');
    }
    return AppUser(
      id: id,
      name: name.trim(),
      email: email.trim(),
      photo: photo,
    );
  }
}
