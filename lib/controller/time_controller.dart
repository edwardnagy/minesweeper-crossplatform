import 'dart:async';

import 'package:flutter/material.dart';

class TimeController with ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  late final Timer _timer;

  TimeController({required Duration updateFrequency}) {
    _timer = Timer.periodic(updateFrequency, (_) => notifyListeners());
  }

  Duration get elapsed => _stopwatch.elapsed;

  void start() {
    _stopwatch.start();
    notifyListeners();
  }

  void stop() {
    _stopwatch.stop();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
