import 'package:domain/usecase/forgot_password/create_new_password_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreateNewPasswordPageViewModel extends BasePageViewModel {
  final CreateNewPasswordUseCase _createPasswordUseCase;

  final TextEditingController createPasswordController =
      TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<AppTextFieldState> passwordKey =
      GlobalKey(debugLabel: "createPassword");

  final GlobalKey<AppTextFieldState> confirmPasswordKey =
      GlobalKey(debugLabel: "confirmPassword");

  ///create password request subject holder
  PublishSubject<CreateNewPasswordUseCaseParams> _createPasswordRequest =
      PublishSubject();

  /// create password response subject holder
  PublishSubject<Resource<bool>> _createPasswordResponse = PublishSubject();

  Stream<Resource<bool>> get createPasswordStream =>
      _createPasswordResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  CreateNewPasswordPageViewModel(this._createPasswordUseCase) {
    _createPasswordRequest.listen((value) {
      RequestManager(value,
              createCall: () => _createPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createPasswordResponse.safeAdd(event);
        updateLoader();
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

  void validatePassword() {
    minimumEightCharacters = createPasswordController.text.length > 7;
    hasUpperCase = Validator.hasUpperCase(createPasswordController.text);
    hasSymbol = Validator.hasSymbol(createPasswordController.text);
    containsDigit = Validator.containsDigit(createPasswordController.text);
    notifyListeners();
  }

  void createPassword() {
    _createPasswordRequest.safeAdd(CreateNewPasswordUseCaseParams(
        createPassword: createPasswordController.text,
        confirmPassword: confirmPasswordController.text,
        minimumEightCharacters: minimumEightCharacters,
        hasUpperCase: hasUpperCase,
        hasSymbol: hasSymbol,
        containsDigit: containsDigit));
  }

  void validateAllFields() {
    if (createPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        confirmPasswordController.text == createPasswordController.text) {
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
