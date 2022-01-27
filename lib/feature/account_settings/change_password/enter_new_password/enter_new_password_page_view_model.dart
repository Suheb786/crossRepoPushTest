import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/usecase/account_setting/change_password/enter_new_password_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterNewPasswordPageViewModel extends BasePageViewModel {
  final EnterNewPasswordUseCase _enterPasswordUseCase;

  final TextEditingController currentPasswordController =
      TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  final GlobalKey<AppTextFieldState> currentPasswordKey =
      GlobalKey(debugLabel: "currentPassword");

  final GlobalKey<AppTextFieldState> newPasswordKey =
      GlobalKey(debugLabel: "newPassword");

  final GlobalKey<AppTextFieldState> confirmNewPasswordKey =
      GlobalKey(debugLabel: "confirmNewPassword");

  ///create password request subject holder
  PublishSubject<EnterNewPasswordUseCaseParams> _createPasswordRequest =
      PublishSubject();

  /// create password response subject holder
  PublishSubject<Resource<ProfileChangedSuccessResponse>>
      _createPasswordResponse = PublishSubject();

  Stream<Resource<ProfileChangedSuccessResponse>> get createPasswordStream =>
      _createPasswordResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterNewPasswordPageViewModel(this._enterPasswordUseCase) {
    _createPasswordRequest.listen((value) {
      RequestManager(value,
              createCall: () => _enterPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createPasswordResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  ///password Validation
  bool hasUpperCase = false;
  bool hasSymbol = false;
  bool minimumEightCharacters = false;
  bool containsDigit = false;
  bool isCurrentPasswordValid = false;

  void validatePassword() {
    minimumEightCharacters = newPasswordController.text.length > 7;
    hasUpperCase = Validator.hasUpperCase(newPasswordController.text);
    hasSymbol = Validator.hasSymbol(newPasswordController.text);
    containsDigit = Validator.containsDigit(newPasswordController.text);
    notifyListeners();
  }

  void validateCurrentPassword() {
    if (currentPasswordController.text.length > 7 &&
        Validator.hasUpperCase(currentPasswordController.text) &&
        Validator.hasSymbol(currentPasswordController.text) &&
        Validator.containsDigit(currentPasswordController.text)) {
      isCurrentPasswordValid = true;
    }
  }

  void createPassword() {
    _createPasswordRequest.safeAdd(EnterNewPasswordUseCaseParams(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmNewPassword: confirmNewPasswordController.text,
        containsDigit: containsDigit,
        hasSymbol: hasSymbol,
        hasUpperCase: hasUpperCase,
        minimumEightCharacters: minimumEightCharacters,
        isCurrentPasswordValid: isCurrentPasswordValid));
  }

  void validateAllFields() {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmNewPasswordController.text) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _createPasswordResponse.close();
    _createPasswordRequest.close();
    super.dispose();
  }
}
