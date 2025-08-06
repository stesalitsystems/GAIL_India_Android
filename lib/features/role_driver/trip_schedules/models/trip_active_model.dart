// trip_active_model.dart
import 'trip_schedule_model.dart';

class TripActiveModel {
  final String tripId;
  final String fromLabel;
  final String toLabel;
  final String time;
  final double progress; // 0..1

  const TripActiveModel({
    required this.tripId,
    required this.fromLabel,
    required this.toLabel,
    required this.time,
    required this.progress,
  });

  factory TripActiveModel.fromTripItem(TripItem t) {
    assert(
      t.status == TripStatus.active,
      'TripActiveModel expects TripStatus.active',
    );
    return TripActiveModel(
      tripId: t.id,
      fromLabel: t.from,
      toLabel: t.to,
      time: t.time,
      progress: t.progress,
    );
  }
}
