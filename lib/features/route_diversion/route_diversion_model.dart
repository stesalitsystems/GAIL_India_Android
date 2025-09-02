class RouteDiversionItem {
  final String lcvNumber;
  final String motherStation;
  final String daughterStation;
  final double latitude;
  final double longitude;
  final String detectedAt;
  final String resolvedAt;

  RouteDiversionItem({
    required this.lcvNumber,
    required this.motherStation,
    required this.daughterStation,
    required this.latitude,
    required this.longitude,
    required this.detectedAt,
    required this.resolvedAt,
  });
}
