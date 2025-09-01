import 'package:flutter/foundation.dart';
import 'package:gail_india/auth/state/demo_credentials.dart';
import 'package:gail_india/core/model/role.dart';
import 'package:gail_india/core/model/user.dart';

/// Scope model: which GA/MS/DBS are we looking at?
class RoleScope {
  final String? gaId;
  final String? msId;
  final String? dbsId;
  const RoleScope({this.gaId, this.msId, this.dbsId});

  bool get hasGA => gaId != null && gaId!.isNotEmpty;
  bool get hasMS => msId != null && msId!.isNotEmpty;
  bool get hasDBS => dbsId != null && dbsId!.isNotEmpty;

  RoleScope copyWith({String? gaId, String? msId, String? dbsId}) => RoleScope(
    gaId: gaId ?? this.gaId,
    msId: msId ?? this.msId,
    dbsId: dbsId ?? this.dbsId,
  );

  static const global = RoleScope();
}

/// Active context = the role we are *viewing as* (impersonated or not) + scope
class ActiveContext {
  final UserRole role;
  final RoleScope scope;
  final bool impersonating;

  const ActiveContext({
    required this.role,
    required this.scope,
    this.impersonating = false,
  });

  ActiveContext copyWith({
    UserRole? role,
    RoleScope? scope,
    bool? impersonating,
  }) => ActiveContext(
    role: role ?? this.role,
    scope: scope ?? this.scope,
    impersonating: impersonating ?? this.impersonating,
  );
}

class AuthController extends ChangeNotifier {
  bool _loading = false;
  bool _isLoggedIn = false;
  User? _user;

  // When logged in, this is the *current* view role+scope
  ActiveContext? _active;

  bool get loading => _loading;
  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;
  ActiveContext? get active => _active;

  String? _impersonationNote;
  String? get impersonationNote => _impersonationNote;

  Future<void> bootstrap() async {
    _loading = true;
    notifyListeners();
    // TODO: hydrate from storage if needed
    _loading = false;
    notifyListeners();
  }

  /// Demo login using local credential table (replace with API in production)
  Future<void> loginWithCredentials(String email, String password) async {
    final key = email.trim().toLowerCase();

    // Validate presence
    if (!kDemoCredentials.containsKey(key)) {
      throw Exception('User not found');
    }

    final entry = kDemoCredentials[key]!;
    if (entry.password != password) {
      throw Exception('Invalid password');
    }

    final signedInUser = User(
      id: 'u_${entry.role.id}_001',
      name: email,
      role: entry.role,
    );

    _user = signedInUser;
    _isLoggedIn = true;

    // Reset/initialize active context to real role, global scope
    _active = ActiveContext(
      role: signedInUser.role,
      scope: RoleScope.global,
      impersonating: false,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _active = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  /// Impersonate GA from Super Admin
  void impersonateGA(String gaId, String gaName) {
    if (_user?.role != UserRole.superAdmin) return;
    _active = ActiveContext(
      role: UserRole.gaIncharge,
      scope: RoleScope(gaId: gaId),
      impersonating: true,
    );
    _impersonationNote = gaName;
    notifyListeners();
  }

  /// Stop impersonation → return to real role and global scope
  void stopImpersonation() {
    if (_user == null) return;
    _active = ActiveContext(
      role: _user!.role,
      scope: RoleScope.global,
      impersonating: false,
    );
    _impersonationNote = null;
    notifyListeners();
  }

  // Helpers for your sidebar/guards
  UserRole? get activeRole => _active?.role;
  RoleScope get activeScope => _active?.scope ?? RoleScope.global;
  bool get isImpersonating => _active?.impersonating == true;
}
