import 'package:flutter/material.dart';
import 'package:gail_india/features/role_driver/trip_schedules/models/trip_active_model.dart';
import 'package:gail_india/features/role_driver/trip_schedules/models/trip_pending_model.dart';
import 'package:gail_india/features/role_driver/trip_schedules/models/trip_schedule_model.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'widgets/trip_active_card.dart';
import 'widgets/trip_pending_card.dart';

class TripSchedules extends StatefulWidget {
  const TripSchedules({super.key});

  @override
  State<TripSchedules> createState() => _TripSchedulesState();
}

class _TripSchedulesState extends State<TripSchedules> {
  int _selected = 0; // 0 = All, 1 = Pending, 2 = Active
  bool _isLoading = false;

  List<TripItem> _allTrips = [
    TripItem(
      id: 'L2A456-001',
      from: 'Kolkata',
      to: 'Park Street',
      time: '09:00 AM',
      status: TripStatus.active,
      progress: 0.65,
    ),
    TripItem(
      id: 'L2A456-003',
      from: 'Howrah',
      to: 'Salt Lake',
      time: '05:30 PM',
      status: TripStatus.pending,
    ),
    TripItem(
      id: 'L2A456-004',
      from: 'Airport',
      to: 'New Town',
      time: '07:00 PM',
      status: TripStatus.pending,
    ),
    TripItem(
      id: 'L2A456-005',
      from: 'Esplanade',
      to: 'Garia',
      time: '08:30 PM',
      status: TripStatus.pending,
    ),
  ];

  Future<void> _refresh() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    _allTrips = List<TripItem>.from(_allTrips)..shuffle();

    _selected = 0;

    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Refreshed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      ('All', _allTrips.length),
      (
        'Pending',
        _allTrips.where((t) => t.status == TripStatus.pending).length,
      ),
      ('Active', _allTrips.where((t) => t.status == TripStatus.active).length),
    ];

    final filtered = switch (_selected) {
      1 => _allTrips.where((t) => t.status == TripStatus.pending).toList(),
      2 => _allTrips.where((t) => t.status == TripStatus.active).toList(),
      _ => _allTrips,
    };

    // Ensure running/active trips are always on top
    final filteredSorted = [...filtered]
      ..sort((a, b) {
        if (a.status == TripStatus.active && b.status != TripStatus.active)
          return -1;
        if (b.status == TripStatus.active && a.status != TripStatus.active)
          return 1;
        return 0; // keep relative order for same status
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Schedules'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
        ],
      ),
      backgroundColor: Colors.yellow[200],
      body: Column(
        children: [
          // Filters
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(items.length, (i) {
                final isSelected = _selected == i;
                final (label, count) = items[i];

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i < items.length - 1 ? 8 : 0,
                    ),
                    child: ElevatedButton(
                      onPressed: () => setState(() => _selected = i),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: isSelected
                            ? GColors.primary
                            : const Color(0xFFF7F7F7),
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.black : Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEDEDED)
                                  : const Color(0xFFDADADA),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Colors.black
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredSorted.length,
              itemBuilder: (context, index) {
                final t = filteredSorted[index];
                if (t.status == TripStatus.active) {
                  return TripActiveCard(
                    model: TripActiveModel.fromTripItem(t),
                    onNavigate: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop(); // go back to previous page
                      }
                    },
                    onDetails: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Details for ${t.id}')),
                      );
                    },
                  );
                }
                return TripPendingCard(
                  model: TripPendingModel.fromTripItem(t),
                  onStart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Trip in Progress, cannot start a new trip until this one is completed.',
                        ),
                      ),
                    );
                  },
                  onDetails: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Details for ${t.id}')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
