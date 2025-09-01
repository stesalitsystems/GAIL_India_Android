import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:gail_india/common/widgets/appbar/appbar.dart';
import 'package:gail_india/common/widgets/navbar/nav_bar.dart';
import 'package:gail_india/common/widgets/sidebar/sidebar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(title: 'Fleet Map'),
      drawer: const GSidebar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(28.6139, 77.2090), // New Delhi (example)
          initialZoom: 5.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.gail_india',
          ),
          MarkerLayer(
            markers: [
              // Marker(
              //   point: LatLng(28.6139, 77.2090),
              //   width: 80,
              //   height: 80,
              //   child: const Icon(
              //     Icons.location_pin,
              //     size: 40,
              //     color: Colors.red,
              //   ),
              // ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const GNavBar(current: AppTab.map),
    );
  }
}
