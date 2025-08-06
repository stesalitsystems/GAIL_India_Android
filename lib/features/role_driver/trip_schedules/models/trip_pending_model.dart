// trip_pending_model.dart
import 'trip_schedule_model.dart';

class TripPendingModel {
  final String tripId;
  final String fromLabel;
  final String toLabel;
  final String time;

  const TripPendingModel({
    required this.tripId,
    required this.fromLabel,
    required this.toLabel,
    required this.time,
  });

  factory TripPendingModel.fromTripItem(TripItem t) {
    assert(
      t.status == TripStatus.pending,
      'TripPendingModel expects TripStatus.pending',
    );
    return TripPendingModel(
      tripId: t.id,
      fromLabel: t.from,
      toLabel: t.to,
      time: t.time,
    );
  }
}
