import 'package:domain/constants/enum/additional_data_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_response.dart';
import 'package:domain/usecase/fatca_crs/get_fatca_questions_usecase.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_questions_response_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class TaxationDetailsPageViewModel extends BasePageViewModel {
  final SetFatcaQuestionsResponseUseCase _setFatcaQuestionsUseCase;
  final GetFatcaQuestionsUseCase _getFatcaQuestionsUseCase;

  final TextEditingController relationShipController = TextEditingController();
  final GlobalKey<AppTextFieldState> relationShipWithPepKey =
      GlobalKey(debugLabel: "relationShipWithPep");

  final TextEditingController personNameController = TextEditingController();
  final GlobalKey<AppTextFieldState> personNameKey =
      GlobalKey(debugLabel: "personName");

  final TextEditingController personRoleController = TextEditingController();
  final GlobalKey<AppTextFieldState> personRoleKey =
      GlobalKey(debugLabel: "personRole");

  TextEditingController countrySelectorController = TextEditingController();
  final GlobalKey<AppTextFieldState> countrySelectorKey =
      GlobalKey(debugLabel: "countrySelector");

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  bool anyOtherCountryResident = false;
  bool usTaxResident = false;
  bool bornInUS = false;
  bool isUSCitizen = false;
  bool isPEP = false;
  bool isFatcaGet = false;

  final SetFatcaQuestionsResponseUseCaseParams setFatcaParams =
      SetFatcaQuestionsResponseUseCaseParams();

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
  }

  ///set fatca questions request subject holder
  PublishSubject<SetFatcaQuestionsResponseUseCaseParams>
      _setFatcaQuestionsRequest = PublishSubject();

  ///set fatca questions response holder
  PublishSubject<Resource<SetFatcResponse>> _setFatcaQuestionsResponse =
      PublishSubject();

  ///set fatca questions stream
  Stream<Resource<SetFatcResponse>> get setFatcaQuestionsStream =>
      _setFatcaQuestionsResponse.stream;

  void updateRelationShipWithPEP(String value) {
    relationShipController.text = value;
  }

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all fieldd validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  bool isValid() {
    bool valid = false;
    if (isPEP) {
      if (relationShipController.text.isNotEmpty &&
          personRoleController.text.isNotEmpty &&
          personNameController.text.isNotEmpty &&
          _declarationSelected.value) {
        valid = true;
      }
    } else if (anyOtherCountryResident) {
      if (countrySelectorController.text.isNotEmpty &&
          _declarationSelected.value) {
        valid = true;
      }
    } else {
      if (_declarationSelected.value) {
        valid = true;
      }
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  ///get fatca question request subject holder
  PublishSubject<GetFatcaQuestionsUseCaseParams> _getFatcaQuestionsRequest =
      PublishSubject();

  ///get fatca question response holder
  PublishSubject<Resource<GetFatcaQuestionsResponse>>
      _getFatcaQuestionsResponseSubject = PublishSubject();

  ///get fatca question stream
  Stream<Resource<GetFatcaQuestionsResponse>> get getFatcaQuestionsStream =>
      _getFatcaQuestionsResponseSubject.stream;

  void getFatcaQuestions() {
    _getFatcaQuestionsRequest.safeAdd(GetFatcaQuestionsUseCaseParams());
  }

  TaxationDetailsPageViewModel(
      this._setFatcaQuestionsUseCase, this._getFatcaQuestionsUseCase) {
    _setFatcaQuestionsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _setFatcaQuestionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _setFatcaQuestionsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          // getError(event);
        }
      });
    });

    _getFatcaQuestionsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getFatcaQuestionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getFatcaQuestionsResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
    //getFatcaQuestions();
  }

  void getError(Resource<SetFatcResponse> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_RELATIONSHIP:
        relationShipWithPepKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_PERSON_NAME:
        personNameKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_PERSON_ROLE:
        personRoleKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_TAX_COUNTRY:
        countrySelectorKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_DECLARATION_SELECTION:
        break;
      default:
        break;
    }
  }

  void setFatcaQuestionResponse() {
    _setFatcaQuestionsRequest.safeAdd(setFatcaParams);
  }

  void toggleSelection(bool value, int index) {
    switch (index) {
      case 0:
        setFatcaParams.response1 = value;
        break;
      case 1:
        setFatcaParams.response2 = value;
        break;
      case 2:
        setFatcaParams.response3 = value;
        break;
      case 3:
        setFatcaParams.response4 = value;
        break;
      case 4:
        setFatcaParams.response5 = value;
        break;
    }
  }

  void setDropDownSelection(AdditionalDataDropDownData selectedDropDown,
      AdditionalData additionalData) {
    if (additionalData.label!.toLowerCase().contains("country") &&
        additionalData.type == AdditionalDataTypeEnum.DROPDOWN) {
      setFatcaParams.country = selectedDropDown.value ?? "";
    }

    if (additionalData.label!.toLowerCase().contains("pep") &&
        additionalData.type == AdditionalDataTypeEnum.DROPDOWN) {
      setFatcaParams.relationShipPEP = selectedDropDown.value ?? "";
    }
  }

  void setOtherData(AdditionalData additionalData, String updatedValue) {
    if (additionalData.label!.toLowerCase().contains("name") &&
        additionalData.type == AdditionalDataTypeEnum.TEXT_FIELD) {
      setFatcaParams.personName = updatedValue;
    }
    if (additionalData.label!.toLowerCase().contains("role") &&
        additionalData.type == AdditionalDataTypeEnum.TEXT_FIELD) {
      setFatcaParams.personRole = updatedValue;
    }
  }

  ///update value to initials
  void updateData(BuildContext context) {
    ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .updateFatcaToInitial();
  }

  @override
  void dispose() {
    _setFatcaQuestionsRequest.close();
    _setFatcaQuestionsResponse.close();
    _declarationSelected.close();
    _getFatcaQuestionsRequest.close();
    _getFatcaQuestionsResponseSubject.close();
    super.dispose();
  }
}
