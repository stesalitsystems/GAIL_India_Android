// lib/auth/state/auth_state.dart

import '../../core/model/user.dart';

class AuthState {
  final bool loading;
  final User? user;
  const AuthState._(this.loading, this.user);
  const AuthState.loading() : this._(true, null);
  const AuthState.loggedOut() : this._(false, null);
  const AuthState.loggedIn(User u) : this._(false, u);

  bool get isLoggedIn => user != null;

  get userRole => null;
}
