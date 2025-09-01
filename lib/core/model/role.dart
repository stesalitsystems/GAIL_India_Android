enum UserRole { superAdmin, gaIncharge, msAdmin, dbsAdmin }

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
      // case 5:
      //   return UserRole.driver;
      default:
        throw ArgumentError('Unknown role_id: $id');
    }
  }

  int get id {
    switch (this) {
      case UserRole.superAdmin:
        return 1;
      case UserRole.gaIncharge:
        return 2;
      case UserRole.msAdmin:
        return 3;
      case UserRole.dbsAdmin:
        return 4;
      // case UserRole.driver:
      //   return 5;
    }
  }

  String get label {
    switch (this) {
      case UserRole.superAdmin:
        return 'Super Admin';
      case UserRole.gaIncharge:
        return 'GA In-Charge';
      case UserRole.msAdmin:
        return 'MS Admin';
      case UserRole.dbsAdmin:
        return 'DBS Admin';
      // case UserRole.driver:
      //   return 'Driver';
    }
  }
}
