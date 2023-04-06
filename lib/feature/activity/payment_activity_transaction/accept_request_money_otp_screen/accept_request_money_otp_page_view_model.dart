import "package:domain/constants/error_types.dart";
import 'package:domain/model/cliq/approve_rtp_otp/approve_rtp_otp.dart';
import 'package:domain/usecase/activity/activity_otp_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_rtp_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'accept_request_money_otp_page.dart';

class AcceptRequestMoneyOtpPageViewModel extends BasePageViewModel {
  final ActivityOtpValidationUseCase _activityOtpValidationUseCase;
  final ApproveRTPRequestUseCase _approveRTPRequestUseCase;
  final ApproveRTPOtpUseCase _approveRTPOtpUseCase;
  final AcceptRequestMoneyOtpPageArgument argument;

  AcceptRequestMoneyOtpPageViewModel(this.argument, this._activityOtpValidationUseCase,
      this._approveRTPRequestUseCase, this._approveRTPOtpUseCase) {
    ///OTP validation request
    _otpValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _activityOtpValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _otpValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          getError(event);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
    _approveRTPRequest.listen(
          (value) {
        RequestManager(value, createCall: () => _approveRTPRequestUseCase.execute(params: value))
            .asFlow()
            .listen(
              (event) {
            updateLoader();
            _approveRTPResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            }
          },
        );
      },
    );
    _approveRTPOtpRequest.listen(
          (value) {
        RequestManager(value, createCall: () => _approveRTPOtpUseCase.execute(params: value)).asFlow().listen(
              (event) {
            updateLoader();
            _approveRTPOtpResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            } else if (event.status == Status.SUCCESS) {
              updateTime();
            }
          },
        );
      },
    );
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  ///validation otp request

  void validateOtp() {
    _otpValidationRequest.safeAdd(ActivityOtpValidationUseCaseParams(otp: _otpSubject.value));
  }

  ///*--------------------[approve-otp]---------------------->>>>>>>

  PublishSubject<ApproveRTPOtpUseCaseParams> _approveRTPOtpRequest = PublishSubject();

  Stream<Resource<ApproveRTPOtp>> get approveRTPOtpStream => _approveRTPOtpResponse.stream;

  PublishSubject<Resource<ApproveRTPOtp>> _approveRTPOtpResponse = PublishSubject();

  void makeApproveRTPOtpRequest() {
    otpController.clear();
    _approveRTPOtpRequest.safeAdd(ApproveRTPOtpUseCaseParams());
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_OTP:
        otpControllerKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  ///*--------------------[approve rtp]---------------------->>>>>>>

  PublishSubject<ApproveRTPRequestUseCaseParam> _approveRTPRequest = PublishSubject();

  Stream<Resource<bool>> get approveRTPRequestStream => _approveRTPResponse.stream;

  PublishSubject<Resource<bool>> _approveRTPResponse = PublishSubject();

  void approveRTPRequest({
    required final String custID,
    required final String dbtrAcct,
    required final String dbtrName,
    required final String dbtrPstlAdr,
    required final String dbtrRecordID,
    required final String currency,
    required final String amount,
    required final String dbtrAlias,
    required final String cdtrBic,
    required final String cdtrName,
    required final String cdtrAcct,
    required final String cdtrPstlAdr,
    required final String cdtrRecordID,
    required final String cdtrAlias,
    required final String rgltryRptg,
    required final String payRefNo,
    required String OrgnlMsgId,
    required String CtgyPurp,
    required final String rejectReason,
    required final String rtpStatus,
    required final String rejectADdInfo,
    required final String otpCode,
    required final bool getToken,
  }) {
    _approveRTPRequest.safeAdd(
      ApproveRTPRequestUseCaseParam(
          custID: custID,
          dbtrAcct: dbtrAcct,
          dbtrName: dbtrName,
          dbtrPstlAdr: dbtrPstlAdr,
          dbtrRecordID: dbtrRecordID,
          dbtrAlias: dbtrAlias,
          currency: currency,
          amount: amount,
          cdtrBic: cdtrBic,
          cdtrName: cdtrName,
          cdtrAcct: cdtrAcct,
          cdtrPstlAdr: cdtrPstlAdr,
          cdtrRecordID: cdtrRecordID,
          cdtrAlias: cdtrAlias,
          rgltryRptg: rgltryRptg,
          payRefNo: payRefNo,
          OrgnlMsgId: OrgnlMsgId,
          CtgyPurp: CtgyPurp,
          rejectReason: rejectReason,
          rtpStatus: rtpStatus,
          rejectADdInfo: rejectADdInfo,
          GetToken: getToken,
          otpCode: otpCode),
    );
  }

  /// validation for i/p and btn
  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _otpSubject.safeAdd(value);
      _showButtonSubject.safeAdd(false);
    }
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  ///------------------------------------------variable--------------------------------------

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  TextEditingController otpController = TextEditingController();
  final GlobalKey<AppTextFieldState> otpControllerKey = GlobalKey(debugLabel: "otpController");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///========================================== otp request validation==============================///
  PublishSubject<ActivityOtpValidationUseCaseParams> _otpValidationRequest = PublishSubject();

  PublishSubject<Resource<bool>> _otpValidationResponse = PublishSubject();

  Stream<Resource<bool>> get otpValidationStream => _otpValidationResponse.stream;

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    _otpValidationRequest.close();
    _otpValidationResponse.close();

    super.dispose();
  }
}
