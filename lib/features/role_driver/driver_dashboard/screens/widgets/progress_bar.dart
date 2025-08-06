import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';

class progressBar extends StatelessWidget {
  const progressBar({
    super.key,
    required double tripProgress,
    required double tripCompletedKm,
    required double tripRemainingKm,
  }) : _tripProgress = tripProgress,
       _tripCompletedKm = tripCompletedKm,
       _tripRemainingKm = tripRemainingKm;

  final double _tripProgress;
  final double _tripCompletedKm;
  final double _tripRemainingKm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: GColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + percentage
          Row(
            children: [
              const Text(
                'Trip Progress',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '${(_tripProgress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Progress bar (rounded)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _tripProgress, // 0.0 - 1.0
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 4),

          // Completed / Remaining labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_tripCompletedKm.toStringAsFixed(1)} km completed',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                '${_tripRemainingKm.toStringAsFixed(1)} km remaining',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
