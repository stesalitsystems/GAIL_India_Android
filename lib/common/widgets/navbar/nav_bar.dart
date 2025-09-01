import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppTab { dashboard, map, analytics, settings }

class GNavBar extends StatelessWidget {
  final AppTab current;
  const GNavBar({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              selected: current == AppTab.dashboard,
              onTap: () => context.go('/dash'),
            ),
            _NavItem(
              icon: Icons.map_outlined,
              selected: current == AppTab.map,
              onTap: () => context.push('/map'),
            ),
            _NavItem(
              icon: Icons.bar_chart_rounded,
              selected: current == AppTab.analytics,
              onTap: () => context.push('/analytics'),
            ),
            _NavItem(
              icon: Icons.settings_outlined,
              selected: current == AppTab.settings,
              onTap: () => context.push('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const selectedFg = Color(0xFF0B8A83);
    const unselectedFg = Color(0xFF444444);
    final fg = selected ? selectedFg : unselectedFg;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, size: 24, color: fg),
      ),
    );
  }
}

// // lib/common/nav/g_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gail_india/common/widgets/appbar/app_tab.dart';
// import 'package:go_router/go_router.dart';
// class GNavBar extends StatelessWidget {
//   final AppTab current;
//   const GNavBar({super.key, required this.current});
//   static const _selectedBg = Color(0xFFE6F3F2); // light teal pill
//   static const _selectedFg = Color(0xFF0B8A83); // teal
//   static const _unselectedFg = Color(0xFF444444); // grey
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: const Border(
//             top: BorderSide(
//               color: Color(0xFFE0E0E0), // light grey
//               width: 1,
//             ),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _NavItem(
//               icon: Icons.home_outlined,
//               label: 'Dashboard',
//               selected: current == AppTab.dashboard,
//               onTap: () => context.go('/superadmin'),
//             ),
//             _NavItem(
//               icon: Icons.map_outlined,
//               label: 'Map',
//               selected: current == AppTab.map,
//               onTap: () => context.go('/map'),
//             ),
//             _NavItem(
//               icon: Icons.bar_chart_rounded,
//               label: 'Analytics',
//               selected: current == AppTab.analytics,
//               onTap: () => context.go('/analytics'),
//             ),
//             _NavItem(
//               icon: Icons.settings_outlined,
//               label: 'Settings',
//               selected: current == AppTab.settings,
//               onTap: () => context.go('/settings'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//   const _NavItem({
//     required this.icon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//   @override
//   Widget build(BuildContext context) {
//     const selectedBg = Color(0xFFE6F3F2);
//     const selectedFg = Color(0xFF0B8A83);
//     const unselectedFg = Color(0xFF444444);
//     final fg = selected ? selectedFg : unselectedFg;
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 24, color: fg),
//           // const SizedBox(height: 4),
//           // Text(
//           //   label,
//           //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//           //     color: fg,
//           //     fontWeight: FontWeight.w600,
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
