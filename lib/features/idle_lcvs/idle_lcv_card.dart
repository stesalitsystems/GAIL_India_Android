import 'package:flutter/material.dart';
import 'package:gail_india/features/idle_lcvs/idle_lcv_model.dart';

class IdleLcvCard extends StatelessWidget {
  const IdleLcvCard({super.key, required this.item});
  final IdleLcvItems item;

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0.6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row(context, 'LCV Number:', item.lcvNumber),
            _row(context, 'Status:', item.status),
            _row(context, 'Upcoming Trips:', item.upcomingTrips),
            _row(context, 'Avg.Waiting Time:', item.watingTime.toString()),
            _row(context, 'Avg.Filling Time:', item.fillingTime.toString()),
            _row(context, 'Last Trip End:', item.lastTripEndedAt),
          ],
        ),
      ),
    );
  }
}
