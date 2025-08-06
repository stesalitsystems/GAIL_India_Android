// lib/features/DriverDashboard/screens/driver_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/models/user_model.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/screens/widgets/expanded_container.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/screens/widgets/hamburger_menu.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/screens/widgets/progress_bar.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/screens/widgets/trip_history_button.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/screens/widgets/trip_schedules_button.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:gail_india/utils/constants/sizes.dart';
import 'package:gail_india/utils/helper/helper_functions.dart';
import 'package:latlong2/latlong.dart' as ltlng;

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  ltlng.LatLng? _currentLocation;
  bool _isTripExpanded = false;
  final double _tripTotalKm = 45.2;
  final double _tripCompletedKm = 28.5;
  double get _tripProgress => (_tripCompletedKm / _tripTotalKm).clamp(0.0, 1.0);
  double get _tripRemainingKm =>
      (_tripTotalKm - _tripCompletedKm).clamp(0.0, _tripTotalKm);

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    final location = await GHelperFunctions.getCurrentLocation();
    setState(() {
      _currentLocation = location ?? ltlng.LatLng(28.6139, 77.2090); // fallback
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // 1) Show a loader until we have a location
    if (_currentLocation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        // Left: hamburger
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: GColors.primary,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => const HamburgerMenu(),
            );
          },
        ),
        // Center/Left title: two lines
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome, Donold Trufb',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2),
            Text(
              'Driver • Active',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        // Right: notification bell with red dot
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // TODO: open notifications
                  },
                ),
                // Red dot
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: GColors.primary, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.75,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: _currentLocation!, // Delhi coords
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: GColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.fire_truck,
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Current Trip Details:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              // Expand/Collapse arrow
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () => setState(
                                  () => _isTripExpanded = !_isTripExpanded,
                                ),
                                icon: AnimatedRotation(
                                  turns: _isTripExpanded
                                      ? 0.5
                                      : 0.0, // rotate ▼ to ▲
                                  duration: const Duration(milliseconds: 200),
                                  child: const Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: Gsizes.defaultSpaceSmall),
                          // One cross-fade that shows BOTH sections when expanded
                          expandedContainer(isTripExpanded: _isTripExpanded),

                          if (_isTripExpanded)
                            const SizedBox(height: Gsizes.defaultSpaceSmall),
                          progressBar(
                            tripProgress: _tripProgress,
                            tripCompletedKm: _tripCompletedKm,
                            tripRemainingKm: _tripRemainingKm,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tripSchedules(),
                SizedBox(width: 8),
                tripHistoryButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
