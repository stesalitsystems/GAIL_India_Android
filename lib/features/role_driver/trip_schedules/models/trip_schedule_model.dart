// trip_schedule_model.dart
enum TripStatus { active, pending }

class TripItem {
  final String id;
  final String from;
  final String to;
  final String time; // e.g. "09:00 AM"
  final TripStatus status;
  final double progress; // 0..1; used only when status == active

  const TripItem({
    required this.id,
    required this.from,
    required this.to,
    required this.time,
    required this.status,
    this.progress = 0,
  });
}
