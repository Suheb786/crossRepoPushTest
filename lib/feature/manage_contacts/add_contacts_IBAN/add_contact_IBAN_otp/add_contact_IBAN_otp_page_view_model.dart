import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class AddContactIBANotpPageViewModel extends BasePageViewModel {
  TextEditingController otpController = TextEditingController();
  PublishSubject<bool> showbuttom = PublishSubject();

  Stream<bool> get showStreamButom => showbuttom.stream;
  PublishSubject<Resource<bool>> _enterOtpForCliqIdValidationResponse = PublishSubject();

  Stream<Resource<bool>> get enterOtpForCliqIdValidationStream => _enterOtpForCliqIdValidationResponse.stream;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  late CountdownTimerController countDownController;
}
