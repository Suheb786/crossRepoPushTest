import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

import '../../../../base/base_page_view_model.dart';

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
