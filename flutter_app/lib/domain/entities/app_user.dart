class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photo = '',
  });
  final String id, name, email, photo;
}
