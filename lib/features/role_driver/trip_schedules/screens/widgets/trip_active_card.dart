import 'package:flutter/material.dart';
import 'package:gail_india/features/role_driver/trip_schedules/models/trip_active_model.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class TripActiveCard extends StatelessWidget {
  final TripActiveModel model;
  final VoidCallback onNavigate;
  final VoidCallback onDetails;

  const TripActiveCard({
    super.key,
    required this.model,
    required this.onNavigate,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final pct = (model.progress * 100).clamp(0, 100).toStringAsFixed(0);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Trip ID + status chip + time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Text(
                      model.tripId,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _chip(
                      context,
                      icon: Icons.play_arrow_rounded,
                      label: 'Running',
                      bg: const Color(0xFFE6FAEE),
                      fg: const Color(0xFF14A44D),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    model.time,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0B2239),
                    ),
                  ),
                  const Text(
                    'Time',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // From / To
          _fromTo(model.fromLabel, model.toLabel),

          const SizedBox(height: 12),

          // Trip progress title + % on right
          Row(
            children: [
              const Text(
                'Trip Progress',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const Spacer(),
              Text(
                '$pct%',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: model.progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
            ),
          ),

          const SizedBox(height: 14),

          // Bottom buttons: Navigate + Details
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onNavigate,
                  icon: const Icon(Icons.near_me_outlined),
                  label: const Text('Navigate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E74FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              // const SizedBox(width: 12),
              // _detailsButton(onDetails),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color bg,
    required Color fg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fromTo(String from, String to) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _placeRow(from, Colors.green, sub: 'From')),
        const SizedBox(width: 12),
        Expanded(child: _placeRow(to, Colors.red, sub: 'To')),
      ],
    );
  }

  Widget _placeRow(String name, Color color, {required String sub}) {
    return Row(
      children: [
        Icon(Icons.place_rounded, size: 18, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Text(
                sub,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot(Color c) => Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );

  Widget _detailsButton(VoidCallback onTap) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF2F4F7),
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
