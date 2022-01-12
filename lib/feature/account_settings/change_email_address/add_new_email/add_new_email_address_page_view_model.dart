import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/account_setting/change_email_address/add_new_email_address_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddNewEmailAddressPageViewModel extends BasePageViewModel {
  final AddNewEmailAddressUseCase _addNewEmailUseCase;

  /// controller
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<AppTextFieldState> changeEmailKey =
      GlobalKey(debugLabel: "changeEmail");

  ///add new email address request subject holder
  PublishSubject<AddNewEmailAddressUseCaseParams> _addNewEmailAddressRequest =
      PublishSubject();

  ///add new email address response holder
  PublishSubject<Resource<bool>> _addNewEmailAddressResponse = PublishSubject();

  ///add new email address stream
  Stream<Resource<bool>> get addNewEmailAddressStream =>
      _addNewEmailAddressResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  AddNewEmailAddressPageViewModel(this._addNewEmailUseCase) {
    _addNewEmailAddressRequest.listen((value) {
      RequestManager(value,
              createCall: () => _addNewEmailUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _addNewEmailAddressResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void changeEmail() {
    _addNewEmailAddressRequest
        .safeAdd(AddNewEmailAddressUseCaseParams(email: emailController.text));
  }

  void validate() {
    if (Validator.validateEmail(emailController.text)) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_EMAIL:
        changeEmailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMAIL:
        changeEmailKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _addNewEmailAddressRequest.close();
    _addNewEmailAddressResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
