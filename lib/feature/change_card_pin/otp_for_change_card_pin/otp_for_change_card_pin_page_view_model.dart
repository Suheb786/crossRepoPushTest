import 'package:domain/usecase/card_delivery/change_debit_card_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/otp_for_change_card_pin_usecase.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class OtpForChangeCardPinPageViewModel extends BasePageViewModel {
  final OtpForChangeCardPinUseCase _otpForChangeCardPinUseCase;

  final ChangeDebitCardPinUseCase _changeDebitCardPinUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  String otp = '';

  ///verify otp request subject holder
  PublishSubject<OtpForChangeCardPinUseCaseParams> _verifyOtpRequest =
      PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<bool>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<bool>> get verifyOtpStream => _verifyOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///change debit card pin request subject holder
  PublishSubject<ChangeDebitCardPinUseCaseParams> _changDebitCardPinRequest =
      PublishSubject();

  ///change debit card pin response holder
  PublishSubject<Resource<bool>> _changDebitCardPinResponse = PublishSubject();

  ///change debit card pin stream
  Stream<Resource<bool>> get changDebitCardPinStream =>
      _changDebitCardPinResponse.stream;

  OtpForChangeCardPinPageViewModel(
      this._otpForChangeCardPinUseCase, this._changeDebitCardPinUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _otpForChangeCardPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _changDebitCardPinRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _changeDebitCardPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changDebitCardPinResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void validateOtp() {
    otp = _otpSubject.value;
    _verifyOtpRequest
        .safeAdd(OtpForChangeCardPinUseCaseParams(otp: _otpSubject.value));
  }

  void changeDebitCardPin(
      {required String pin,
      required String tokenizedPan,
      required String cardNumber}) {
    _changDebitCardPinRequest.safeAdd(ChangeDebitCardPinUseCaseParams(
        pin: pin,
        otp: _otpSubject.value,
        tokenizedPan: tokenizedPan,
        cardNumber: cardNumber));
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _verifyOtpRequest.close();
    _verifyOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
