import 'package:data/di/local_module.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/base_page_view_model.dart';
import '../../../../main/app_viewmodel.dart';

class SessionTimeoutDialogViewModel extends BasePageViewModel {
  late int remainTime;

  late CountdownTimerController countDownController;

  SessionTimeoutDialogViewModel() {}

  @override
  void dispose() {
    countDownController.dispose();
    super.dispose();
  }
}
