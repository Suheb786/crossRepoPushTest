import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_new_mobile_number_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_otp_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class DcEnterOtpViewModel extends BasePageViewModel {
  DcEnterOtpUseCase _dcEnterOtpUseCase;
  DcEnterNewMobileNumberUseCase _dcEnterNewMobileNumberUseCase;
  TextEditingController otpController = TextEditingController();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///resend otp
  PublishSubject<GetTokenUseCaseParams> _getTokenRequest = PublishSubject();

  void updateTime(BuildContext context) {
    // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    // notifyListeners();
    verifyMobile(context);
  }

  PublishSubject<DcEnterOtpUseCaseParams> _dcEnterOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _dcEnterOtpResponse = PublishSubject();

  Stream<Resource<bool>> get dcEnterOtpStream => _dcEnterOtpResponse.stream;

  PublishSubject<DcEnterNewMobileNumberUseCaseParams> _enterMobileRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _enterMobileResponse = PublishSubject();

  Stream<Resource<bool>> get enterMobileStream => _enterMobileResponse.stream;

  DcEnterOtpViewModel(
      this._dcEnterOtpUseCase, this._dcEnterNewMobileNumberUseCase) {
    _enterMobileRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _dcEnterNewMobileNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterMobileResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          listenForSmsCode();
        }
      });
    });

    _dcEnterOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _dcEnterOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _dcEnterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enterOtp(String? tokenizedPan, String? mobileNumber, String? mobileCode,
      CardType cardType) {
    _dcEnterOtpRequest.safeAdd(DcEnterOtpUseCaseParams(
        otpCode: _otpSubject.value,
        tokenizedPan: tokenizedPan,
        cardType: cardType,
        mobileCode: "00${mobileCode}",
        mobileNumber: mobileNumber));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void verifyMobile(BuildContext context) {
    _enterMobileRequest.safeAdd(DcEnterNewMobileNumberUseCaseParams(
        tokenizedPan: ProviderScope.containerOf(context)
            .read(dcChangeLinkedMobileNumberViewModelProvider)
            .arguments!
            .tokenizedPan,
        mobileNumber: ProviderScope.containerOf(context)
            .read(dcEnterNewMobileNumberViewModelProvider)
            .mobileNumberController
            .text,
        mobileCode: ProviderScope.containerOf(context)
            .read(dcEnterNewMobileNumberViewModelProvider)
            .countryData
            .phoneCode,
        cardType: CardType.DEBIT));
  }

  @override
  void dispose() {
    _otpSubject.close();
    _showButtonSubject.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
