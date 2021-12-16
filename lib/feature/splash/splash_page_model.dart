import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/subjects.dart';

class SplashViewModel extends BasePageViewModel {
  ///linear progress bar progress holder subject
  final BehaviorSubject<double> _splashProgressSubject =
      BehaviorSubject.seeded(0.0);

  Stream<double> get splashProgressStream => _splashProgressSubject.stream;

  AnimationController? animationController;

  /// Timer logic to trigger after 1 sec
  startTimer(Duration duration) {
    Timer(duration, () {
      _splashProgressSubject.safeAdd(1.0);
    });
  }

  @override
  void dispose() {
    _splashProgressSubject.close();
    super.dispose();
  }
}
