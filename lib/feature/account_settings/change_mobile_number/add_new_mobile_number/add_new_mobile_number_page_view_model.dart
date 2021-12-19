import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/add_new_mobile_number_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddNewMobileNumberPageViewModel extends BasePageViewModel {
  final AddNewMobileNumberUseCase _addNewMobileUseCase;

  /// controller
  final TextEditingController mobileController = TextEditingController();

  final GlobalKey<AppTextFieldState> mobileKey =
  GlobalKey(debugLabel: "mobileNumber");

  ///add new mobile number request subject holder
  PublishSubject<AddNewMobileNumberUseCaseParams> _addNewMobileRequest =
  PublishSubject();

  ///add new mobile number response holder
  PublishSubject<Resource<bool>> _addNewMobileResponse = PublishSubject();

  ///add new mobile number stream
  Stream<Resource<bool>> get addNewMobileStream => _addNewMobileResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  AddNewMobileNumberPageViewModel(this._addNewMobileUseCase) {
    _addNewMobileRequest.listen((value) {
      RequestManager(value,
          createCall: () => _addNewMobileUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _addNewMobileResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void changeMobileNumber() {
    _addNewMobileRequest.safeAdd(
        AddNewMobileNumberUseCaseParams(mobileNumber: mobileController.text));
  }

  void validate() {
    if (mobileController.text.isNotEmpty && mobileController.text.length > 8) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_MOBILE:
        mobileKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _addNewMobileRequest.close();
    _addNewMobileResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
