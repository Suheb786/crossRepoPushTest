import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_account_by_customerID_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CliqIdTypeSelectionPageViewModel extends BasePageViewModel {
  final CliqIdTypeSelectionValidationUseCase _cliqIdTypeSelectionValidationUseCase;
  final GetAccountByCustomerIDUseCase _getAccountByCustomerIDUseCase;

  CliqIdTypeSelectionPageViewModel(
      this._cliqIdTypeSelectionValidationUseCase, this._getAccountByCustomerIDUseCase) {
    ///validation request
    _cliqIdTypeSelectionValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _cliqIdTypeSelectionValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _cliqIdTypeSelectionValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          getError(event);
        }
      });
    });

    _getAccountByCustomerIdRequest.listen((value) {
      RequestManager(value, createCall: () => _getAccountByCustomerIDUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountByCustomerIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void validateUserInput() {
    _cliqIdTypeSelectionValidationRequest.safeAdd(CliqIdTypeSelectionValidationUseCaseParams(
        cliqIdType: cliqIdTypeController.text,
        alias: aliasController.text,
        cliqIdTypeEnum: cliqIdTypeSubject.value,
        mobileNo: mobileNumberController.text));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_CLIQ_ID_TYPE:
        clickIdTypeKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_ALIAS:
        aliasKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_MOBILE:
        mobileNumberKey.currentState!.isValid = false;
        break;
      case ErrorType.PLEASE_ENTER_MOBILE_NO:
        mobileNumberKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_ALIAS_LENGTH:
        aliasKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  List<String> cliqIDTypeListEn = ['Alias', 'Mobile Number'];
  List<String> cliqIDTypeListAr = ['اسم مستعار', 'رقم الموبايل'];

  void validate() {
    if (cliqIdTypeController.text.isNotEmpty &&
        cliqIdTypeSubject.value == CliqIdTypeEnum.ALIAS &&
        aliasController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else if (cliqIdTypeController.text.isNotEmpty &&
        cliqIdTypeSubject.value == CliqIdTypeEnum.MOBILE_NO &&
        mobileNumberController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void updateCliqIdType(CliqIdTypeEnum cliqIdTypeEnum) {
    cliqIdTypeSubject.safeAdd(cliqIdTypeEnum);
  }

  @override
  void dispose() {
    _cliqIdTypeSelectionValidationRequest.close();
    _cliqIdTypeSelectionValidationResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }

  ///---------------------------------------variables--------------------------------------------------

  ///controllers and keys
  final TextEditingController aliasController = TextEditingController();
  final GlobalKey<AppTextFieldState> aliasKey = GlobalKey(debugLabel: "alias");

  final TextEditingController cliqIdTypeController = TextEditingController();
  final GlobalKey<AppTextFieldState> clickIdTypeKey = GlobalKey(debugLabel: "clickIdType");

  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey = GlobalKey(debugLabel: "mobileNumber");

  ///validation request and response
  PublishSubject<CliqIdTypeSelectionValidationUseCaseParams> _cliqIdTypeSelectionValidationRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _cliqIdTypeSelectionValidationResponse = PublishSubject();

  Stream<Resource<bool>> get cliqIdTypeSelectionValidationStream =>
      _cliqIdTypeSelectionValidationResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///cliq id type
  BehaviorSubject<CliqIdTypeEnum> cliqIdTypeSubject = BehaviorSubject.seeded(CliqIdTypeEnum.NONE);

  Stream<CliqIdTypeEnum> get cliqIdTypeStream => cliqIdTypeSubject.stream;

  ///-------------------Get Account By Customer ID----------------///
  ///

  PublishSubject<GetAccountByCustomerIDUseCaseParams> _getAccountByCustomerIdRequest = PublishSubject();

  PublishSubject<Resource<List<GetAccountByCustomerId>>> _getAccountByCustomerIdResponse = PublishSubject();

  Stream<Resource<List<GetAccountByCustomerId>>> get getAccountByCustomerIdStream =>
      _getAccountByCustomerIdResponse.stream;

  void getAccountByCustomerId() {
    _getAccountByCustomerIdRequest.safeAdd(GetAccountByCustomerIDUseCaseParams());
  }
}
