// user type based on role_id

import 'package:flutter/material.dart';

enum UserType {
  driver,
  dbsAdmin,
  msAdmin,
  gaAdmin,
  superAdmin,
  unknown;

  static UserType fromRoleId(int roleId) {
    switch (roleId) {
      case 1:
        return UserType.driver;
      case 2:
        return UserType.dbsAdmin;
      case 3:
        return UserType.msAdmin;
      case 4:
        return UserType.gaAdmin;
      case 5:
        return UserType.superAdmin;
      default:
        return UserType.unknown;
    }
  }
}
