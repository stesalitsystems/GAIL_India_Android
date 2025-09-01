// Demo-only credential table. Replace with your API later.
import 'package:gail_india/core/model/role.dart';

class DemoCredentialsEntry {
  final String password;
  final UserRole role;
  DemoCredentialsEntry({required this.password, required this.role});
}

final Map<String, DemoCredentialsEntry> kDemoCredentials = {
  // Super Admin
  'super': DemoCredentialsEntry(password: '1', role: UserRole.superAdmin),

  // GA In-Charge
  'ga': DemoCredentialsEntry(password: '1', role: UserRole.gaIncharge),

  // MS Admin
  'ms': DemoCredentialsEntry(password: '1', role: UserRole.msAdmin),

  // DBS Admin
  'dbs': DemoCredentialsEntry(password: '1', role: UserRole.dbsAdmin),

  // Driver
  // 'driver@gmail.com': DemoCredentialsEntry(
  //   password: 'pass123',
  //   role: UserRole.driver,
  // ),
};
