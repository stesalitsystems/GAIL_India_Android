import 'dart:async';
import 'package:flutter/foundation.dart';

/// Listens to a Stream and calls `notifyListeners()` whenever
/// a new event comes in. Used to trigger GoRouter refreshes.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
