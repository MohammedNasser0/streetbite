import '../../domain/entities/app_user.dart';

class UserModel extends AppUser {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.photo,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    photo: json['photo'] as String? ?? '',
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'photo': photo,
  };
}
