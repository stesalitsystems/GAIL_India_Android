// widgets/role_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:gail_india/core/model/role.dart';

class RoleGate extends ConsumerWidget {
  final List<UserRole> allowedRoles;
  final Widget child;

  const RoleGate({super.key, required this.allowedRoles, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authControllerProvider).userRole;
    if (allowedRoles.contains(role)) {
      return child;
    }
    return const SizedBox.shrink(); // Hide if role not allowed
  }
}

// Example usage:
// RoleGate(
//   allowedRoles: [UserRole.superAdmin, UserRole.gaIncharge],
//   child: ElevatedButton(
//     onPressed: () {
//       // action only allowed for superAdmin & GA Incharge
//     },
//     child: const Text('Approve Sales Forecast'),
//   ),
// )
