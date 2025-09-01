import 'role.dart';

class User {
  final String id;
  final String name;
  final UserRole role; // user’s real role (not impersonated)

  User({required this.id, required this.name, required this.role});

  factory User.fromJson(Map<String, dynamic> j) => User(
    id: (j['user_id'] ?? j['id'] ?? '').toString(),
    name: (j['name'] ?? '').toString(),
    role: RoleMap.fromId(j['role_id'] as int),
  );
}
