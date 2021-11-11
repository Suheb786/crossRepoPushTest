import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/taxation_details_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class TaxationDetailsPageViewModel extends BasePageViewModel {
  final TaxationDetailsUseCase _taxationDetailsUseCase;

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

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
  }

  ///taxation details request subject holder
  PublishSubject<TaxationDetailsUseCaseParams> _taxationDetailsRequest =
      PublishSubject();

  ///taxation details response holder
  PublishSubject<Resource<bool>> _taxationDetailsResponse = PublishSubject();

  ///taxation details stream
  Stream<Resource<bool>> get taxationDetailsStream =>
      _taxationDetailsResponse.stream;

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

  TaxationDetailsPageViewModel(this._taxationDetailsUseCase) {
    _taxationDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _taxationDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _taxationDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          getError(event);
        }
      });
    });
  }

  void getError(Resource<bool> event) {
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
    }
  }

  void validateTaxationDetails() {
    _taxationDetailsRequest.safeAdd(TaxationDetailsUseCaseParams(
        declarationSelected: _declarationSelected.value,
        isPEP: isPEP,
        relationShipPEP: relationShipController.text,
        personName: personNameController.text,
        personRole: personRoleController.text,
        anyOtherCountryResident: anyOtherCountryResident,
        country: countrySelectorController.text));
  }

  @override
  void dispose() {
    _taxationDetailsRequest.close();
    _taxationDetailsResponse.close();
    _declarationSelected.close();
    super.dispose();
  }
}
