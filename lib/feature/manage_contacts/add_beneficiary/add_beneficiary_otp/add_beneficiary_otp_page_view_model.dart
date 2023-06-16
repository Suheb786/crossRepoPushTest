import 'package:domain/constants/error_types.dart';
import 'package:domain/model/manage_contacts/add_beneficiary_response.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/resend_OTP_add_beneficiaryusecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/manage_contacts/manage_contacts_modules.dart';
import '../../../../main/app_viewmodel.dart';
import '../../../../utils/navgition_type.dart';

class AddBeneficiaryotpPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///--------------------------late-valiables-------------------------------------///

  late CountdownTimerController countDownController;

  ///--------------------------final-valiables-------------------------------------///

  final GlobalKey<AppTextFieldState> otpKey = GlobalKey();
  final AddBeneficiaryUseCase addBeneficiaryUseCase;
  final ResendOTPAddBeneficiaryUseCase resendOTPAddBeneficiaryUseCase;

  ///--------------------------controllers-------------------------------------///

  TextEditingController otpController = TextEditingController();

  ///-----------------add-contact-iban-otp-subjects-------------------------------------///

  PublishSubject<AddContactIBANuseCaseParams> addcontactIbanOTPuseCaseRequest = PublishSubject();
  PublishSubject<Resource<AddBeneficiaryResponse>> addcontactIbanOTPuseCaseResponse = PublishSubject();

  Stream<Resource<AddBeneficiaryResponse>> get addcontactIbanOTPValidationStream =>
      addcontactIbanOTPuseCaseResponse.stream;

  ///--------------------------otp-subject-------------------------------------///

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  ///--------------------------animated-button-subject-------------------------------------///

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  ///-----------------resend OTP-------------------------------------///

  PublishSubject<AddBeneficiaryOTPUseCaseParams> resendOTPUseCaseRequest = PublishSubject();
  PublishSubject<AddBeneficiaryOTPUseCaseParams> _resendOTPRequestStream = PublishSubject();

  ///--------------------------public-override-methods-------------------------------------///

  late NavigationType navigationType;

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    addcontactIbanOTPuseCaseRequest.close();
    addcontactIbanOTPuseCaseResponse.close();

    super.dispose();
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  ///--------------------------public-other-methods-------------------------------------///

  void validateOTP(BuildContext buildContext) {
    final provider = ProviderScope.containerOf(buildContext).read(
      addBeneficiaryFormPageViewModel,
    );

    addcontactIbanOTPuseCaseRequest.safeAdd(AddContactIBANuseCaseParams(
      IBANAccountNoMobileNoAlias: provider.ibanOrMobileController.text,
      purpose: '',
      beneficiaryType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM',
      purposeDetail: provider.purposeDetail?.strCode ?? '',
      name: provider.nameController.text,
      fullName: navigationType == NavigationType.REQUEST_MONEY
          ? provider.getAccountByAliasContentResponse.getAccountByAliasContent!.name ?? ''
          : provider.transferResponse.name ?? '',
      otp: _otpSubject.value,
    ));
  }

  void resendOTP() {
    _resendOTPRequestStream.safeAdd(AddBeneficiaryOTPUseCaseParams());
  }

  void validate(String val) {
    _otpSubject.safeAdd(val);
    if (otpController.text.isNotEmpty && otpController.text.length == 6) {
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

  ///--------------------------public-constructor-------------------------------------///

  AddBeneficiaryotpPageViewModel(this.addBeneficiaryUseCase, this.resendOTPAddBeneficiaryUseCase) {
    addcontactIbanOTPuseCaseRequest.listen((value) {
      RequestManager(value, createCall: () => addBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        addcontactIbanOTPuseCaseResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });

    resendOTPUseCaseRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  resendOTPAddBeneficiaryUseCase.execute(params: AddBeneficiaryOTPUseCaseParams()))
          .asFlow()
          .listen((event) {
        updateLoader();
        addcontactIbanOTPuseCaseResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    final provider = ProviderScope.containerOf(appLevelKey.currentContext!).read(
      addBeneficiaryViewModelProvider,
    );
    navigationType = provider.navigationType;
  }
}
