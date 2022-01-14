import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/forgot_password/add_id_number_for_reset_password_usecase.dart';
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
  final AddIdNumberForResetPasswordUseCase _addIdNumberForResetPasswordUseCase;

  ///controllers and keys
  final TextEditingController nationalIdController = TextEditingController();
  final GlobalKey<AppTextFieldState> nationalIdKey =
      GlobalKey(debugLabel: "nationalId");

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  final TextEditingController idExpiryDateController = TextEditingController();
  final GlobalKey<AppTextFieldState> idExpiryDateKey =
      GlobalKey(debugLabel: "idExpiryDate");

  PublishSubject<AddIdNumberForResetPasswordUseCaseParams>
      _idNumberForResetPasswordRequest = PublishSubject();

  PublishSubject<Resource<bool>> _idNumberForResetPasswordResponse =
      PublishSubject();

  Stream<Resource<bool>> get idNumberForResetPasswordStream =>
      _idNumberForResetPasswordResponse.stream;

  String selectedExpiryDate = DateTime.now().toLocal().toString();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  AddIDNumberForResetPasswordPageViewModel(
      this._addIdNumberForResetPasswordUseCase) {
    _idNumberForResetPasswordRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _addIdNumberForResetPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _idNumberForResetPasswordResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
        }
      });
    });
  }

  void addIdNumberForResetPassword() {
    _idNumberForResetPasswordRequest.safeAdd(
        AddIdNumberForResetPasswordUseCaseParams(
            emailAddress: emailController.text,
            idExpiryDate: idExpiryDateController.text,
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
    _idNumberForResetPasswordRequest.close();
    _idNumberForResetPasswordResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
