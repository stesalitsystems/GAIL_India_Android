// core/constants/menu_config.dart
import 'package:gail_india/core/model/role.dart';

class MenuItemConfig {
  final String label;
  final String path;
  const MenuItemConfig(this.label, this.path);
}

final menuByRole = {
  UserRole.superAdmin: const [
    MenuItemConfig('Dashboard', '/dash/global'),
    MenuItemConfig('Users', '/users'),
    MenuItemConfig('GA', '/ga'),
    MenuItemConfig('MS', '/ms'),
    MenuItemConfig('DBS', '/dbs'),
    MenuItemConfig('LCVs', '/lcvs'),
    MenuItemConfig('Schedules', '/schedules'),
    MenuItemConfig('Trips', '/trips'),
    MenuItemConfig('Sales', '/sales'),
    MenuItemConfig('Forecast', '/forecast'),
    MenuItemConfig('Dry-Outs', '/dryouts'),
    MenuItemConfig('Reports', '/reports'),
  ],
  UserRole.gaIncharge: const [
    MenuItemConfig('Dashboard', '/dash/ga'),
    MenuItemConfig('MS', '/ms'),
    MenuItemConfig('DBS', '/dbs'),
    MenuItemConfig('Trips', '/trips'),
    MenuItemConfig('Schedules', '/schedules'),
    MenuItemConfig('Sales', '/sales'),
    MenuItemConfig('Reports', '/reports'),
  ],
  UserRole.msAdmin: const [
    MenuItemConfig('Dashboard', '/dash/ms'),
    MenuItemConfig('DBS', '/dbs'),
    MenuItemConfig('Schedules', '/schedules'),
    MenuItemConfig('Trips', '/trips'),
    MenuItemConfig('Sales', '/sales'),
  ],
  UserRole.dbsAdmin: const [
    MenuItemConfig('Dashboard', '/dash/dbs'),
    MenuItemConfig('Today\'s Schedules', '/schedules'),
    MenuItemConfig('Trips', '/trips'),
    MenuItemConfig('Sales', '/sales'),
    MenuItemConfig('Reports', '/reports'),
  ],
  // UserRole.driver: const [
  //   MenuItemConfig('Dashboard', '/dash/driver'),
  //   MenuItemConfig('My Trips', '/trips'),
  // ],
};
