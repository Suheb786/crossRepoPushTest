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
  PublishSubject<AddContactIbanOTPuseCaseParams> addcontactIbanOTPuseCaseRequest = PublishSubject();
  PublishSubject<Resource<bool>> addcontactIbanOTPuseCaseResponse = PublishSubject();
  late CountdownTimerController countDownController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  TextEditingController otpController = TextEditingController();
  final GlobalKey<AppTextFieldState> otpKey = GlobalKey();
  PublishSubject<bool> showbuttom = PublishSubject();

  PublishSubject<Resource<bool>> _enterOtpForCliqIdValidationResponse = PublishSubject();
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  AddContactIBANotpPageViewModel(this.addContactIbanOTPuseCase) {
    addcontactIbanOTPuseCaseRequest.listen((value) {
      RequestManager(value, createCall: () => addContactIbanOTPuseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        addcontactIbanOTPuseCaseResponse.safeAdd(event);
        if (event.status == Status.SUCCESS) {
          showErrorState();
          getError(event);
        }
      });
    });
  }

  void validate() {
    if (otpController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
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

  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  Stream<bool> get showStreamButom => showbuttom.stream;

  Stream<Resource<bool>> get enterOtpForCliqIdValidationStream => _enterOtpForCliqIdValidationResponse.stream;

  Stream<Resource<bool>> get addcontactIbanOTPValidationStream => addcontactIbanOTPuseCaseResponse.stream;

  @override
  void dispose() {
    countDownController.dispose();
    super.dispose();
  }
}
