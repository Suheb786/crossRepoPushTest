import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'network_properties.dart';

class LocalSessionService {
  Timer? _warningTimer;
  Timer? _sessionTimer;

  BehaviorSubject<bool> warningStreamSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> sessionStreamSubject = BehaviorSubject.seeded(false);
  final Stopwatch _stopwatch = Stopwatch();

  Duration get getTimeoutRemainTime => _stopwatch.elapsed;

  bool startTimer() {
    debugPrint('timer started ');
    if (_warningTimer != null) {
      _warningTimer!.cancel();
      _warningTimer = null;
      if (warningStreamSubject.value) warningStreamSubject.add(false);
    }
    if (_sessionTimer != null) {
      _sessionTimer!.cancel();
      _sessionTimer = null;
      if (sessionStreamSubject.value) sessionStreamSubject.add(false);
    }

    _sessionTimer = Timer(NetworkProperties.MAIN_TIMEOUT, () {
      debugPrint("------------------------------------------------------------------------------");
      debugPrint("--------------------------- Session Ended         ----------------------------");
      debugPrint("------------------------------------------------------------------------------");
      _stopwatch.stop();
      if (!sessionStreamSubject.value) sessionStreamSubject.add(true);
    });
    _warningTimer = Timer(NetworkProperties.WARNING_TIMEOUT, () {
      debugPrint("------------------------------------------------------------------------------");
      debugPrint("---------------------------Session End Warning   -----------------------------");
      debugPrint("------------------------------------------------------------------------------");
      _stopwatch.reset();
      if (!sessionStreamSubject.value) warningStreamSubject.add(true);
    });
    _stopwatch.stop();

    return true;
  }

  bool stopTimer() {
    if (_warningTimer != null && _warningTimer!.isActive) {
      debugPrint('_timer closed ');
      _warningTimer!.cancel();
      _warningTimer = null;
    }
    if (_sessionTimer != null && _sessionTimer!.isActive) {
      debugPrint('_timer closed ');
      _sessionTimer!.cancel();
      _sessionTimer = null;
    }
    _stopwatch.stop();
    return true;
  }
}
