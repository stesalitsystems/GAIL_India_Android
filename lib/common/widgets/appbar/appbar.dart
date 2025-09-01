import 'package:flutter/material.dart';
import 'package:gail_india/core/model/role.dart';
import 'package:provider/provider.dart';
import 'package:gail_india/auth/state/auth_controller.dart';

class GAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  // final String subtitle;
  const GAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  void _openDrawerIfAny(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold?.hasDrawer ?? false) {
      scaffold!.openDrawer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No drawer attached to this page.')),
      );
    }
  }

  void _pickGAImpersonation(BuildContext context) async {
    // DEMO list; replace with your GA list from API
    final gaList = [
      {'id': 'ga_001', 'name': 'North GA'},
      {'id': 'ga_002', 'name': 'South GA'},
      {'id': 'ga_003', 'name': 'West GA'},
    ];
    final auth = context.read<AuthController>();

    final chosen = await showModalBottomSheet<Map<String, String>>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: gaList.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (itemContext, i) {
            final item = gaList[i];
            return ListTile(
              title: Text(item['name']!),
              onTap: () => Navigator.pop(sheetContext, {
                'id': item['id']!,
                'name': item['name']!,
              }),
            );
          },
        );
      },
    );

    if (chosen != null) {
      // pass both ID and NAME
      auth.impersonateGA(chosen['id']!, chosen['name']!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Viewing as GA: ${chosen['name']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final isImpersonating = auth.isImpersonating;
    final roleLabel = auth.activeRole?.label ?? '-';
    final gaNote = auth.impersonationNote; // GA name if set

    // Build the subtitle line
    final subtitleLine =
        isImpersonating && auth.activeRole == UserRole.gaIncharge
        ? 'Viewing as GA In-Charge: ${gaNote ?? '-'}'
        : roleLabel;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => _openDrawerIfAny(context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              // Text(
              //   subtitle,
              //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //     color: Colors.black54,
              //     fontSize: 12,
              //   ),
              // ),
              Text(
                subtitleLine,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          // // Role badge + impersonation controls
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          //   decoration: BoxDecoration(
          //     color: isImpersonating
          //         ? Colors.orange.shade100
          //         : const Color(0xFFE6F3F2),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(
          //         isImpersonating ? Icons.visibility : Icons.verified_user,
          //         size: 16,
          //         color: Colors.black87,
          //       ),
          //       const SizedBox(width: 6),
          //       Text(
          //         isImpersonating ? 'Viewing as $roleLabel' : roleLabel,
          //         style: const TextStyle(
          //           fontSize: 12,
          //           color: Colors.black87,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(width: 8),
          if (auth.user?.role == UserRole.superAdmin && !isImpersonating)
            IconButton(
              tooltip: 'Switch to GA',
              icon: const Icon(
                Icons.switch_account,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () => _pickGAImpersonation(context),
            ),
          if (isImpersonating)
            IconButton(
              tooltip: 'Back to Super Admin',
              icon: const Icon(
                Icons.restart_alt,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () => auth.stopImpersonation(),
            ),
          // const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications clicked')),
            ),
          ),
        ],
      ),
    );
  }
}

// // lib/common/widgets/g_appbar.dart
// import 'package:flutter/material.dart';
// class GAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final String subtitle;
//   const GAppBar({super.key, required this.title, required this.subtitle});
//   @override
//   Size get preferredSize => const Size.fromHeight(70);
//   void _openDrawerIfAny(BuildContext context) {
//     // Opens drawer if the Scaffold has one
//     final scaffold = Scaffold.maybeOf(context);
//     if (scaffold?.hasDrawer ?? false) {
//       scaffold!.openDrawer();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No drawer attached to this page.')),
//       );
//     }
//   }
//   void _showAreasSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         final items = const ['All Areas', 'East', 'West', 'North', 'South'];
//         return ListView.separated(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           itemBuilder: (c, i) => ListTile(
//             title: Text(items[i]),
//             onTap: () {
//               Navigator.pop(c);
//               // TODO: persist selected area (provider/bloc)
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text('Selected: ${items[i]}')));
//             },
//           ),
//           separatorBuilder: (_, __) => const Divider(height: 0),
//           itemCount: items.length,
//         );
//       },
//     );
//   }
//   void _onNotificationsTap(BuildContext context) {
//     // Fixed notification action used everywhere
//     // TODO: navigate to /notifications or open a panel
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Notifications clicked')));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 2, // add soft drop shadow
//       shadowColor: Colors.black.withOpacity(0.2),
//       automaticallyImplyLeading: false,
//       titleSpacing: 0,
//       title: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.menu, color: Colors.black),
//             onPressed: () => _openDrawerIfAny(context),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: Colors.black54,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () => _showAreasSheet(context),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF6B4F1D), // pill color like screenshot
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Text(
//                 'All Areas',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           IconButton(
//             icon: const Icon(Icons.notifications_none, color: Colors.black),
//             onPressed: () => _onNotificationsTap(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
