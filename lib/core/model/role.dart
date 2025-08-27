// lib/core/models/role.dart
enum UserRole { superAdmin, gaIncharge, msAdmin, dbsAdmin, driver }

extension RoleMap on UserRole {
  static UserRole fromId(int id) {
    switch (id) {
      case 1:
        return UserRole.superAdmin;
      case 2:
        return UserRole.gaIncharge;
      case 3:
        return UserRole.msAdmin;
      case 4:
        return UserRole.dbsAdmin;
      case 5:
        return UserRole.driver;
      default:
        throw ArgumentError('Unknown role_id: $id');
    }
  }
}
