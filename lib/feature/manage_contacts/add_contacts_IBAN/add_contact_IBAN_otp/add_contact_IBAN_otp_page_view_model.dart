import 'package:animated_widgets/generated/i18n.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/manage_contacts/add_contact_OTP_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class AddContactIBANotpPageViewModel extends BasePageViewModel {
  final AddContactIbanOTPuseCase addContactIbanOTPuseCase;

  late CountdownTimerController countDownController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  TextEditingController otpController = TextEditingController();
  final GlobalKey<AppTextFieldState> otpKey = GlobalKey();

  AddContactIBANotpPageViewModel(this.addContactIbanOTPuseCase) {
    addcontactIbanOTPuseCaseRequest.listen((value) {
      RequestManager(value, createCall: () => addContactIbanOTPuseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        addcontactIbanOTPuseCaseResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
  }

  validateOTP() {
    addcontactIbanOTPuseCaseRequest.safeAdd(AddContactIbanOTPuseCaseParams(otp: _otpSubject.value));
  }

  void validate(String val) {
    if (otpController.text.isNotEmpty && otpController.text.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(val);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getError(Resource<bool> event) {
    switch (event.appError?.type) {
      case ErrorType.INVALID_OTP:
        break;
      default:
    }
  }

  PublishSubject<AddContactIbanOTPuseCaseParams> addcontactIbanOTPuseCaseRequest = PublishSubject();
  PublishSubject<Resource<bool>> addcontactIbanOTPuseCaseResponse = PublishSubject();
  Stream<Resource<bool>> get addcontactIbanOTPValidationStream => addcontactIbanOTPuseCaseResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");
  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  @override
  void dispose() {
    countDownController.disposeTimer();

    _showButtonSubject.close();
    _otpSubject.close();
    addcontactIbanOTPuseCaseRequest.close();
    addcontactIbanOTPuseCaseResponse.close();

    super.dispose();
  }
}
