import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/user/create_password_usecase.dart';
import 'package:domain/usecase/user/register_prospect_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreatePasswordViewModel extends BasePageViewModel {
  final CreatePasswordUseCase _createPasswordUseCase;
  final RegisterProspectUseCase _registerProspectUseCase;
  final TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<AppTextFieldState> passwordKey = GlobalKey(debugLabel: "createPassword");
  final GlobalKey<AppTextFieldState> confirmPasswordKey = GlobalKey(debugLabel: "confirmPassword");

  ///create password request subject holder
  PublishSubject<CreatePasswordUseCaseParams> _createPasswordRequest = PublishSubject();

  /// create password response subject holder
  PublishSubject<Resource<bool>> _createPasswordResponse = PublishSubject();

  Stream<Resource<bool>> get createPasswordStream => _createPasswordResponse.stream;

  ///Register user request subject holder
  PublishSubject<RegisterProspectUseCaseParams> _registerUserRequest = PublishSubject();

  /// Register user response subject holder
  PublishSubject<Resource<User>> _registerUserResponse = PublishSubject();

  Stream<Resource<User>> get registerUserStream => _registerUserResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  CreatePasswordViewModel(this._createPasswordUseCase, this._registerProspectUseCase) {
    _createPasswordRequest.listen((value) {
      RequestManager(value, createCall: () => _createPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createPasswordResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _registerUserRequest.listen((value) {
      RequestManager(value, createCall: () => _registerProspectUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _registerUserResponse.safeAdd(event);
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
    _createPasswordRequest.safeAdd(CreatePasswordUseCaseParams(
      createPassword: createPasswordController.text,
      confirmPassword: confirmPasswordController.text,
      minimumEightCharacters: minimumEightCharacters,
      hasUpperCase: hasUpperCase,
      hasSymbol: hasSymbol,
      containsDigit: containsDigit,
      emailAddress: '',
      isEmailExist: 1,
    ));
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

  void registerUser({
    String? email,
    String? phone,
    String? country,
    String? mobileCode,
  }) {
    _registerUserRequest.safeAdd(RegisterProspectUseCaseParams(
        email: email,
        countryName: country,
        mobileNumber: phone,
        mobileCode: '00$mobileCode',
        userName: email,
        password: createPasswordController.text,
        confirmPassword: confirmPasswordController.text));
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _createPasswordResponse.close();
    _createPasswordRequest.close();
    _registerUserRequest.close();
    _registerUserResponse.close();
    super.dispose();
  }
}
