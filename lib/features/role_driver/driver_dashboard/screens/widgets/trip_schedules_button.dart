// lib/features/driver_dashboard/screens/widgets/trip_schedules_button.dart
import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';

class tripSchedules extends StatelessWidget {
  const tripSchedules({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: GColors.primary,
          side: BorderSide.none,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/tripSchedules');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Trip Schedule", style: TextStyle(color: Colors.black)),
            SizedBox(width: 4),
            Icon(Icons.schedule, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
