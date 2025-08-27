import 'package:flutter/material.dart';
import 'package:gail_india/common/widgets/app_tab.dart';
import 'package:gail_india/common/widgets/appbar.dart';
import 'package:gail_india/common/widgets/nav_bar.dart';
import 'package:gail_india/common/widgets/sidebar.dart';
import 'package:gail_india/dashboard/presentation/widgets/dashboard_cards.dart';
import 'package:gail_india/utils/constants/sizes.dart';

class DashSuperAdmin extends StatefulWidget {
  const DashSuperAdmin({super.key});

  @override
  State<DashSuperAdmin> createState() => _DashSuperAdminState();
}

class _DashSuperAdminState extends State<DashSuperAdmin> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Refreshed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(
        title: 'Fleet Dashboard',
        subtitle: 'Super Admin Overview',
      ),
      drawer: const GSidebar(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Today\'s Overview',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.warning_amber_rounded,
              iconBgColor: Colors.pinkAccent,
              title: "Route Diversions Today",
              subtitle: "Real-time data",
              value: "0",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.check_circle_outline,
              iconBgColor: Colors.green,
              title: "No Dry-Out Detected Today",
              subtitle: "Real-time data",
              value: "0",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.cancel_outlined,
              iconBgColor: Colors.orange,
              title: "Dry-Out Detected Today",
              subtitle: "Real-time data",
              value: "0",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.warning_amber_rounded,
              iconBgColor: Colors.red,
              title: "Dry-Outs Today",
              subtitle: "Real-time data",
              value: "0",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.local_shipping_outlined,
              iconBgColor: Colors.green,
              title: "Today Total Idle LCVs",
              subtitle: "Real-time data",
              value: "23",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'System Statistics',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.group_outlined,
              iconBgColor: Colors.blueAccent,
              title: 'Total Active Users',
              subtitle: "Current count",
              value: "168",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.place_outlined,
              iconBgColor: Colors.purpleAccent,
              title: "Geographical Areas",
              subtitle: "Current count",
              value: "7",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.place_outlined,
              iconBgColor: Colors.teal,
              title: "Mother Stations",
              subtitle: "Current count",
              value: "22",
            ),
            SizedBox(height: Gsizes.defaultSpaceSmall),
            DashboardStatCard(
              icon: Icons.place_outlined,
              iconBgColor: Colors.orangeAccent,
              title: "Daughter Stations",
              subtitle: "Real-time data",
              value: "32",
            ),
            DashboardStatCard(
              icon: Icons.local_shipping_outlined,
              iconBgColor: Colors.green,
              title: "Today Active LCVs",
              subtitle: "Real-time data",
              value: "152",
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GNavBar(current: AppTab.dashboard),
    );
  }
}
