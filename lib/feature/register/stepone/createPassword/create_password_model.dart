import 'package:domain/usecase/user/create_password_usecase.dart';
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

  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<AppTextFieldState> passwordKey =
      GlobalKey(debugLabel: "createPassword");

  final GlobalKey<AppTextFieldState> confirmPasswordKey =
      GlobalKey(debugLabel: "confirmPassword");

  ///create password request subject holder
  PublishSubject<CreatePasswordUseCaseParams> _createPasswordRequest =
      PublishSubject();

  /// create password response subject holder
  PublishSubject<Resource<bool>> _createPasswordResponse = PublishSubject();

  Stream<Resource<bool>> get createPasswordStream =>
      _createPasswordResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  CreatePasswordViewModel(this._createPasswordUseCase) {
    _createPasswordRequest.listen((value) {
      RequestManager(value,
              createCall: () => _createPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createPasswordResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void createPassword() {
    _createPasswordRequest.safeAdd(CreatePasswordUseCaseParams(
        createPassword: createPasswordController.text,
        confirmPassword: confirmPasswordController.text));
  }

  void validatePassword() {
    if (createPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
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
