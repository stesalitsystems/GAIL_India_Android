import 'package:flutter/material.dart';

class expandedContainer extends StatelessWidget {
  const expandedContainer({super.key, required bool isTripExpanded})
    : _isTripExpanded = isTripExpanded;

  final bool _isTripExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: _isTripExpanded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
      firstChild: Column(
        children: [
          // LVN + Route
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // LVN
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LVN Number",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'LK16235',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
              // Route
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Route:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'Kolkata - Park Street',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Arrival + Dispatch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Arrival:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '9:00 AM',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dispatch:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '11:00 AM',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Collapsed state shows nothing (only the header row with arrow remains)
      secondChild: const SizedBox.shrink(),
    );
  }
}
