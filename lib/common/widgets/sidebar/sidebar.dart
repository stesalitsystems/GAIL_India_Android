// lib/common/sidebar/g_sidebar.dart
import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'sidebar_item.dart';

class GSidebar extends StatelessWidget {
  const GSidebar({super.key});

  // colors
  static const _bg = GColors.white; // dark navy
  static const _fg = GColors.black; // icon/text
  static const _muted = Color.fromARGB(255, 0, 0, 0); // muted text/icons
  static const _selectedBg = Color(0xFF173455); // selected row bg
  static const _logoutRed = Color(0xFFE11900);

  // route map for go_router
  String _routeFor(SidebarItem item) {
    switch (item) {
      case SidebarItem.dashboard:
        return '/superadmin';
      case SidebarItem.userManagement:
        return '/users';
      case SidebarItem.geographicalAreas:
        return '/areas';
      case SidebarItem.motherStations:
        return '/mother-stations';
      case SidebarItem.daughterBoosterStations:
        return '/daughter-booster-stations';
      case SidebarItem.routeManagement:
        return '/routes';
      case SidebarItem.lcvManagement:
        return '/lcv';
      case SidebarItem.dbsStockStatus:
        return '/dbs-stock-status';
      case SidebarItem.lcvSchedules:
        return '/lcv-schedules';
      case SidebarItem.lcvTripStatus:
        return '/lcv-trip-status';
      case SidebarItem.dryOutHistory:
        return '/dry-out-history';
      case SidebarItem.msWiseLcvQueue:
        return '/ms-wise-lcv-queue';
      case SidebarItem.salesHistory:
        return '/sales-history';
    }
  }

  // icon & label map (match your screenshot)
  (IconData, String) _meta(SidebarItem item) {
    switch (item) {
      case SidebarItem.dashboard:
        return (Icons.home_outlined, 'Dashboard');
      case SidebarItem.userManagement:
        return (Icons.group_outlined, 'User Management');
      case SidebarItem.geographicalAreas:
        return (Icons.place_outlined, 'Geographical Areas');
      case SidebarItem.motherStations:
        return (Icons.apartment_outlined, 'Mother Stations');
      case SidebarItem.daughterBoosterStations:
        return (Icons.podcasts_outlined, 'Daughter Booster Stations');
      case SidebarItem.routeManagement:
        return (Icons.send_outlined, 'Route Management');
      case SidebarItem.lcvManagement:
        return (Icons.local_shipping_outlined, 'LCV Management');
      case SidebarItem.dbsStockStatus:
        return (Icons.inventory_2_outlined, 'DBS Stock Status');
      case SidebarItem.lcvSchedules:
        return (Icons.event_note_outlined, 'LCV Schedules');
      case SidebarItem.lcvTripStatus:
        return (Icons.show_chart_outlined, 'LCV Trip Status');
      case SidebarItem.dryOutHistory:
        return (Icons.history_toggle_off, 'Dry-Out History');
      case SidebarItem.msWiseLcvQueue:
        return (Icons.queue_outlined, 'MS Wise LCV Queue');
      case SidebarItem.salesHistory:
        return (Icons.attach_money_outlined, 'Sales History');
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    // the order to render
    const items = <SidebarItem>[
      SidebarItem.dashboard,
      SidebarItem.userManagement,
      SidebarItem.geographicalAreas,
      SidebarItem.motherStations,
      SidebarItem.daughterBoosterStations,
      SidebarItem.routeManagement,
      SidebarItem.lcvManagement,
      SidebarItem.dbsStockStatus,
      SidebarItem.lcvSchedules,
      SidebarItem.lcvTripStatus,
      SidebarItem.dryOutHistory,
      SidebarItem.msWiseLcvQueue,
      SidebarItem.salesHistory,
    ];

    return Drawer(
      width: 300,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
              child: Row(
                children: [
                  Text(
                    'FMS Super Admin',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _fg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: _fg),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFF29415E)),

            // Menu
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[i];
                  final (iconData, label) = _meta(item);
                  final route = _routeFor(item);
                  final selected =
                      location ==
                      route; // simple match; tweak if you need startsWith

                  return _SidebarTile(
                    icon: iconData,
                    label: label,
                    selected: selected,
                    onTap: () {
                      // close drawer before navigation
                      Navigator.of(context).pop();
                      if (location != route) {
                        context.go(route);
                      }
                    },
                  );
                },
              ),
            ),
            Divider(height: 1, color: Color(0xFF29415E)),
            // Logout button (sticky bottom)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () async {
                    // TODO: call your logout logic here
                    // await ref.read(authControllerProvider.notifier).logout();
                    context.go('/login');
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: _logoutRed,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _fg = Colors.white;
  static const _muted = Color(0xFF173455);
  static const _selectedBg = Color(0xFF173455);
  static const _selectedFg = Colors.white;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? _selectedFg : _muted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? _selectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: fg, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: fg,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
