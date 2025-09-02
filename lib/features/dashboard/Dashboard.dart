import 'package:flutter/material.dart';
import 'package:gail_india/common/widgets/appbar/appbar.dart';
import 'package:gail_india/core/model/role.dart';
import 'package:gail_india/features/dashboard/widgets/dashboard_cards.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:gail_india/common/widgets/sidebar/sidebar.dart';
import 'package:gail_india/common/widgets/navbar/nav_bar.dart';
import 'package:gail_india/utils/constants/sizes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();

  static String _titleFor(UserRole role, dynamic scope) {
    switch (role) {
      case UserRole.superAdmin:
        return "Today's Global Overview";
      case UserRole.gaIncharge:
        return "GA Overview";
      case UserRole.msAdmin:
        return "MS Overview";
      case UserRole.dbsAdmin:
        return "DBS Overview";
      // case UserRole.driver:
      //   return "Driver Overview";
    }
  }

  static String _scopeLabel(UserRole role, RoleScope scope) {
    switch (role) {
      case UserRole.superAdmin:
        return "All Regions";
      case UserRole.gaIncharge:
        return "GA: ${scope.gaId ?? '-'}";
      case UserRole.msAdmin:
        return "MS: ${scope.msId ?? '-'}";
      case UserRole.dbsAdmin:
        return "DBS: ${scope.dbsId ?? '-'}";
      // case UserRole.driver:
      //   return "Your Assignments";
    }
  }

  static Widget _rowCards(BuildContext context, List<Widget> cards) {
    return LayoutBuilder(
      builder: (ctx, c) {
        if (c.maxWidth > 720) {
          return Row(
            children: cards
                .map(
                  (w) => Expanded(
                    child: Padding(padding: const EdgeInsets.all(6), child: w),
                  ),
                )
                .toList(),
          );
        }
        return Column(
          children: cards
              .map((w) => Padding(padding: const EdgeInsets.all(6), child: w))
              .toList(),
        );
      },
    );
  }

  static List<Widget> _roleSpecificBlocks(
    BuildContext context,
    UserRole role,
    RoleScope scope,
  ) {
    switch (role) {
      case UserRole.superAdmin:
        return [
          _sectionTitle(context, 'System Statistics'),
          _rowCards(context, [
            DashboardStatCard(
              icon: Icons.group_outlined,
              iconBgColor: Colors.blueAccent,
              title: 'Total Active Users',
              subtitle: "Global",
              value: "168",
            ),
            DashboardStatCard(
              icon: Icons.place_outlined,
              iconBgColor: Colors.purpleAccent,
              title: "Geographical Areas",
              subtitle: "Global",
              value: "7",
            ),
          ]),
          _rowCards(context, [
            DashboardStatCard(
              icon: Icons.apartment_outlined,
              iconBgColor: Colors.teal,
              title: "Mother Stations",
              subtitle: "Global",
              value: "22",
            ),
            DashboardStatCard(
              icon: Icons.podcasts_outlined,
              iconBgColor: Colors.orangeAccent,
              title: "Daughter Stations",
              subtitle: "Global",
              value: "32",
            ),
            DashboardStatCard(
              icon: Icons.local_shipping_outlined,
              iconBgColor: Colors.green,
              title: "Total Active LCVs",
              subtitle: "Global",
              value: "40",
            ),
          ]),
          // const SizedBox(height: 4),
          // // Tip for impersonation UX
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, top: 8),
          //   child: Text(
          //     'Tip: Use "Switch to GA" in AppBar to view as a GA without re-login.',
          //     style: Theme.of(context).textTheme.bodySmall,
          //   ),
          // ),
        ];
      case UserRole.gaIncharge:
        return [
          _sectionTitle(context, 'Your GA'),
          _rowCards(context, [
            DashboardStatCard(
              icon: Icons.apartment_outlined,
              iconBgColor: Colors.teal,
              title: "Mother Stations",
              subtitle: "Scoped",
              value: "5",
            ),
            DashboardStatCard(
              icon: Icons.podcasts_outlined,
              iconBgColor: Colors.orangeAccent,
              title: "Daughter Stations",
              subtitle: "Scoped",
              value: "10",
            ),
          ]),
          _rowCards(context, [
            DashboardStatCard(
              icon: Icons.local_shipping_outlined,
              iconBgColor: Colors.green,
              title: "LCVs",
              subtitle: "Scoped",
              value: "40",
            ),
            DashboardStatCard(
              icon: Icons.attach_money_outlined,
              iconBgColor: Colors.indigo,
              title: "Sales (Today)",
              subtitle: "Scoped",
              value: "₹ 2.4M",
            ),
          ]),
        ];
      case UserRole.msAdmin:
        return [
          _sectionTitle(context, 'Your MS'),
          _rowCards(context, [
            DashboardStatCard(
              icon: Icons.podcasts_outlined,
              iconBgColor: Colors.orangeAccent,
              title: "Daughter Stations",
              subtitle: "Scoped",
              value: "6",
            ),
            DashboardStatCard(
              icon: Icons.local_shipping_outlined,
              iconBgColor: Colors.green,
              title: "LCVs",
              subtitle: "Scoped",
              value: "18",
            ),
          ]),
        ];
      case UserRole.dbsAdmin:
        return [
          _sectionTitle(context, 'Your DBS'),
          _rowCards(context, [
            DashboardStatCard(
              icon: Icons.local_shipping_outlined,
              iconBgColor: Colors.green,
              title: "LCVs",
              subtitle: "Scoped",
              value: "8",
            ),
            DashboardStatCard(
              icon: Icons.history_toggle_off,
              iconBgColor: Colors.brown,
              title: "Dry-Out History (30d)",
              subtitle: "Scoped",
              value: "0",
            ),
          ]),
        ];
      // case UserRole.driver:
      //   return [
      //     _sectionTitle(context, 'Your Trips'),
      //     _rowCards(context, [
      //       DashboardStatCard(
      //         icon: Icons.event_note_outlined,
      //         iconBgColor: Colors.cyan,
      //         title: "Today’s Trips",
      //         subtitle: "Assigned",
      //         value: "2",
      //       ),
      //       DashboardStatCard(
      //         icon: Icons.timeline,
      //         iconBgColor: Colors.deepPurple,
      //         title: "In-Transit",
      //         subtitle: "Now",
      //         value: "1",
      //       ),
      //     ]),
      //   ];
    }
  }

  static Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _DashboardPageState extends State<DashboardPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> _onRefresh() async {
    // TODO: put your real refresh call(s) here
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted(); // end the animation
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final role = auth.activeRole ?? UserRole.superAdmin;
    final scope = auth.activeScope;

    return Scaffold(
      appBar: const GAppBar(
        title: 'Dashboard',
        // subtitle: 'Role-aware Overview',
      ),
      drawer: const GSidebar(),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        header: const ClassicHeader(
          refreshingText: 'Refreshing…',
          idleText: 'Pull down to refresh',
          releaseText: 'Release to refresh',
          completeText: 'Refresh complete',
          failedText: 'Refresh failed',
          // (optional) you can tweak icons/sizes if you want
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  // Title on the left
                  Expanded(
                    child: Text(
                      DashboardPage._titleFor(role, scope),
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Actions on the right
                  TextButton(
                    onPressed: () {
                      // TODO: navigate to SCADA screen
                      // context.go('/scada');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('SCADA tapped')),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      backgroundColor: Colors.grey.shade300,
                      minimumSize: Size.zero, // keeps it compact
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: Colors.black87,
                      textStyle: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: .3,
                          ),
                    ),
                    child: const Text('SCADA'),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {
                      // TODO: navigate to VTS screen
                      // context.go('/vts');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('VTS tapped')),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      backgroundColor: Colors.grey.shade300,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: Colors.black87,
                      textStyle: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: .3,
                          ),
                    ),
                    child: const Text('VTS'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Cards common to all roles (but values should be scoped by role/scope)
            // _rowCards(context, [
            //   DashboardStatCard(
            //     icon: Icons.warning_amber_rounded,
            //     iconBgColor: Colors.pinkAccent,
            //     title: "Route Diversions Today",
            //     subtitle: _scopeLabel(role, scope),
            //     value: "0",
            //   ),
            //   DashboardStatCard(
            //     icon: Icons.cancel_outlined,
            //     iconBgColor: Colors.red,
            //     title: "Dry-Outs Today",
            //     subtitle: _scopeLabel(role, scope),
            //     value: "0",
            //   ),
            // ]),
            const SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardPage._rowCards(context, [
              DashboardStatCard(
                icon: Icons.warning_amber_rounded,
                iconBgColor: Colors.pinkAccent,
                title: "Route Diversions Today",
                subtitle: DashboardPage._scopeLabel(role, scope),
                value: "0",
                onTap: () {
                  context.push('/route_diversion');
                },
              ),
              DashboardStatCard(
                icon: Icons.check_circle_outline,
                iconBgColor: Colors.green,
                title: "No Dry-Out Detected Today",
                subtitle: DashboardPage._scopeLabel(role, scope),
                value: "0",
                onTap: () {
                  context.push('/no_dryout_detected_dbs');
                },
              ),
              DashboardStatCard(
                icon: Icons.cancel_outlined,
                iconBgColor: Colors.orange,
                title: "Dry-Out Detected Today",
                subtitle: DashboardPage._scopeLabel(role, scope),
                value: "0",
                onTap: () {
                  context.push('/dryout_today_dbs');
                },
              ),
              DashboardStatCard(
                icon: Icons.warning_amber_rounded,
                iconBgColor: Colors.red,
                title: "Dry-Outs Today",
                subtitle: DashboardPage._scopeLabel(role, scope),
                value: "0",
                onTap: () {
                  context.push('/dryouts_today');
                },
              ),
              DashboardStatCard(
                icon: Icons.local_shipping_outlined,
                iconBgColor: Colors.green,
                title: "Today Total Idle LCVs",
                subtitle: DashboardPage._scopeLabel(role, scope),
                value: "23",
                onTap: () {
                  context.push('/idle_lcv');
                },
              ),
            ]),
            const SizedBox(height: Gsizes.defaultSpaceSmall),

            // Role specific blocks
            ...DashboardPage._roleSpecificBlocks(context, role, scope),
          ],
        ),
      ),
      bottomNavigationBar: const GNavBar(current: AppTab.dashboard),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:gail_india/common/widgets/appbar/app_tab.dart';
// import 'package:gail_india/common/widgets/appbar/appbar.dart';
// import 'package:gail_india/common/widgets/navbar/nav_bar.dart';
// import 'package:gail_india/common/widgets/sidebar/sidebar.dart';
// import 'package:gail_india/features/dashboard/presentation/widgets/dashboard_cards.dart';
// import 'package:gail_india/utils/constants/sizes.dart';
// class DashSuperAdmin extends StatefulWidget {
//   const DashSuperAdmin({super.key});
//   @override
//   State<DashSuperAdmin> createState() => _DashSuperAdminState();
// }
// class _DashSuperAdminState extends State<DashSuperAdmin> {
//   Future<void> _onRefresh() async {
//     await Future.delayed(const Duration(seconds: 1));
//     if (!mounted) return;
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Refreshed')));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const GAppBar(
//         title: 'Fleet Dashboard',
//         subtitle: 'Super Admin Overview',
//       ),
//       drawer: const GSidebar(),
//       body: RefreshIndicator(
//         onRefresh: _onRefresh,
//         color: Colors.black,
//         child: ListView(
//           padding: EdgeInsets.all(16),
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 'Today\'s Overview',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.warning_amber_rounded,
//               iconBgColor: Colors.pinkAccent,
//               title: "Route Diversions Today",
//               subtitle: "Real-time data",
//               value: "0",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.check_circle_outline,
//               iconBgColor: Colors.green,
//               title: "No Dry-Out Detected Today",
//               subtitle: "Real-time data",
//               value: "0",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.cancel_outlined,
//               iconBgColor: Colors.orange,
//               title: "Dry-Out Detected Today",
//               subtitle: "Real-time data",
//               value: "0",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.warning_amber_rounded,
//               iconBgColor: Colors.red,
//               title: "Dry-Outs Today",
//               subtitle: "Real-time data",
//               value: "0",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.local_shipping_outlined,
//               iconBgColor: Colors.green,
//               title: "Today Total Idle LCVs",
//               subtitle: "Real-time data",
//               value: "23",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 'System Statistics',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.group_outlined,
//               iconBgColor: Colors.blueAccent,
//               title: 'Total Active Users',
//               subtitle: "Current count",
//               value: "168",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.place_outlined,
//               iconBgColor: Colors.purpleAccent,
//               title: "Geographical Areas",
//               subtitle: "Current count",
//               value: "7",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.place_outlined,
//               iconBgColor: Colors.teal,
//               title: "Mother Stations",
//               subtitle: "Current count",
//               value: "22",
//             ),
//             SizedBox(height: Gsizes.defaultSpaceSmall),
//             DashboardStatCard(
//               icon: Icons.place_outlined,
//               iconBgColor: Colors.orangeAccent,
//               title: "Daughter Stations",
//               subtitle: "Real-time data",
//               value: "32",
//             ),
//             DashboardStatCard(
//               icon: Icons.local_shipping_outlined,
//               iconBgColor: Colors.green,
//               title: "Today Active LCVs",
//               subtitle: "Real-time data",
//               value: "152",
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const GNavBar(current: AppTab.dashboard),
//     );
//   }
// }
