import 'package:domain/constants/error_types.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:domain/usecase/forget_password/check_forget_password_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddIDNumberForResetPasswordPageViewModel extends BasePageViewModel {
  final CheckForgetPasswordUseCase _checkForgetPasswordUseCase;

  ///controllers and keys
  final TextEditingController nationalIdController = TextEditingController();
  final GlobalKey<AppTextFieldState> nationalIdKey =
      GlobalKey(debugLabel: "nationalId");

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  final TextEditingController idExpiryDateController = TextEditingController();
  final GlobalKey<AppTextFieldState> idExpiryDateKey =
      GlobalKey(debugLabel: "idExpiryDate");

  PublishSubject<CheckForgetPasswordUseCaseParams> _checkForgetPasswordRequest =
      PublishSubject();

  PublishSubject<Resource<CheckForgetPasswordResponse>>
      _checkForgetPasswordResponse = PublishSubject();

  Stream<Resource<CheckForgetPasswordResponse>>
      get checkForgetPasswordResponseStream =>
          _checkForgetPasswordResponse.stream;

  String selectedExpiryDate = DateTime.now().toLocal().toString();

  DateTime initialDate = DateTime.now();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  AddIDNumberForResetPasswordPageViewModel(this._checkForgetPasswordUseCase) {
    _checkForgetPasswordRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkForgetPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkForgetPasswordResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void addIdNumberForResetPassword() {
    _checkForgetPasswordRequest.safeAdd(CheckForgetPasswordUseCaseParams(
        email: emailController.text,
        expiryDate: idExpiryDateController.text,
        nationalId: nationalIdController.text));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_ID_NUMBER:
        nationalIdKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_EXPIRY_DATE:
        idExpiryDateKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validate() {
    if (Validator.validateEmail(emailController.text) &&
        idExpiryDateController.text.isNotEmpty &&
        nationalIdController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _checkForgetPasswordRequest.close();
    _checkForgetPasswordResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
