import 'package:flutter/material.dart';
import 'package:gail_india/features/dryout%20detected_today/dryout_detected_today_model.dart';
import 'package:gail_india/features/no_dryout_detected_dbs/no_dry_out_detected_dbs_model.dart';

class DryOutDetectedTodayDbsCard extends StatelessWidget {
  const DryOutDetectedTodayDbsCard({super.key, required this.item});
  final DryOutDetectedToday item;

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
            _row(context, 'Geographical Area:', item.gaName),
            _row(context, 'Mother Station:', item.motherStation),
            _row(context, 'Daughter Station:', item.daughterStation),
            _row(context, 'Current Stock(KG):', item.currentStock.toString()),

            // Lat/Long on the same line
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 6),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 130,
            //         child: Text(
            //           'Location',
            //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //             color: Colors.black54,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ),
            //       // const Icon(Icons.location_on_outlined, size: 16),
            //       // const SizedBox(width: 6),
            //       Text(
            //         '${item.latitude.toStringAsFixed(5)}, ${item.longitude.toStringAsFixed(5)}',
            //         style: Theme.of(context).textTheme.bodyMedium,
            //       ),
            //     ],
            //   ),
            // ),
            _row(context, 'Live Trip Status:', item.tripStatus),
            _row(context, 'Live Trip Dispatch Time:', item.dispatchedAt),
            _row(context, 'Next Scheduled Dispatch:', item.nextDispatchAt),
            _row(context, 'Live Trip Estimated Arrival Time:', item.arrivedAt),
            _row(context, 'Live Status of LCV:', item.statusLcv),
          ],
        ),
      ),
    );
  }
}
