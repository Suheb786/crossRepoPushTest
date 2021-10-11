import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

import '../../../../utils/request_manager.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';

class ValidateOtpViewModel extends BasePageViewModel {
  final VerifyOtpUseCase _verifyOtpUseCase;

  ///otp controller
  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  ///verify otp request subject holder
  PublishSubject<VerifyOtpUseCaseParams> _verifyOtpRequest = PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<bool>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<bool>> get verifyOtpStream => _verifyOtpResponse.stream;

  ///error detector subject
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  ///error detector stream
  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  ValidateOtpViewModel(this._verifyOtpUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _verifyOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _verifyOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateOtp() {
    _verifyOtpRequest.safeAdd(VerifyOtpUseCaseParams(otp: otpController.text));
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 800), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }

  @override
  void dispose() {
    _verifyOtpRequest.close();
    _verifyOtpResponse.close();
    _errorDetectorSubject.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
