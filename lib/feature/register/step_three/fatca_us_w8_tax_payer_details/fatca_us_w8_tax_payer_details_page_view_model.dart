import 'package:domain/constants/enum/tax_payer_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/fatca_us_w8_tax_payer_details_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaUSW8TaxPayersDetailsPageViewModel extends BasePageViewModel {
  final FatcaUSW8TaxPayerDetailsUseCase _fatcaUSW8taxPayerDetailsUseCase;

  ///controllers and keys
  final TextEditingController taxPayerTypeController = TextEditingController();
  final GlobalKey<AppTextFieldState> taxPayerTypeKey =
      GlobalKey(debugLabel: "taxPayerType");

  final TextEditingController identificationNumberController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> identificationNumberKey =
      GlobalKey(debugLabel: "identificationNumber");

  final TextEditingController beneficialCountryController =
      TextEditingController(text: 'hello');
  final GlobalKey<AppTextFieldState> beneficialCountryKey =
      GlobalKey(debugLabel: "beneficialCountry");

  final TextEditingController beneficialIdentificationNumberController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> beneficialIdentificationNumberKey =
      GlobalKey(debugLabel: "beneficialIdentificationNumber");

  final TextEditingController incomeTypeController = TextEditingController();
  final GlobalKey<AppTextFieldState> incomeTypeKey =
      GlobalKey(debugLabel: "incomeType");

  final TextEditingController explanationController = TextEditingController();
  final GlobalKey<AppTextFieldState> explanationKey =
      GlobalKey(debugLabel: "explanation");

  ///fatca us w9 taxPayer details request subject holder
  PublishSubject<FatcaUSW8TaxPayerDetailsUseCaseParams>
      _fatcaUSW8taxPayerDetailsRequest = PublishSubject();

  ///fatca us w9 taxPayer details response holder
  PublishSubject<Resource<bool>> _fatcaUSW8taxPayerDetailsResponse =
      PublishSubject();

  ///fatca us w9 taxPayer details stream
  Stream<Resource<bool>> get fatcaUSW8taxPayerDetailsStream =>
      _fatcaUSW8taxPayerDetailsResponse.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///social security number field visibility subject
  final BehaviorSubject<bool> _identificationVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get identificationVisibilityStream =>
      _identificationVisibilitySubject.stream;

  void updateVisibilityValue(bool value) {
    _identificationVisibilitySubject.safeAdd(value);
  }

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
  }

  ///show Declaration Error Subject holder
  final BehaviorSubject<bool> _showDeclarationErrorSubject =
      BehaviorSubject.seeded(false);

  ///show Declaration Error response stream
  Stream<bool> get showDeclarationError => _showDeclarationErrorSubject.stream;

  void updateDeclarationErrorValue(bool value) {
    _showDeclarationErrorSubject.safeAdd(value);
  }

  ///tax treaty benefits switch value subject
  final BehaviorSubject<bool> _taxTreatyBenefitsSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get taxTreatyBenefitsValue => _taxTreatyBenefitsSubject.stream;

  void updateTaxTreatyBenefitsValue(bool value) {
    _taxTreatyBenefitsSubject.safeAdd(value);
  }

  bool isValid() {
    bool valid = false;
    if (_taxTreatyBenefitsSubject.value &&
        _identificationVisibilitySubject.value &&
        taxPayerTypeController.text.isNotEmpty &&
        identificationNumberController.text.isNotEmpty &&
        beneficialCountryController.text.isNotEmpty &&
        beneficialIdentificationNumberController.text.isNotEmpty &&
        incomeTypeController.text.isNotEmpty &&
        explanationController.text.isNotEmpty &&
        _declarationSelected.value) {
      valid = true;
    } else if (_identificationVisibilitySubject.value &&
        taxPayerTypeController.text.isNotEmpty &&
        identificationNumberController.text.isNotEmpty &&
        _declarationSelected.value) {
      valid = true;
    } else if (taxPayerTypeController.text.isNotEmpty &&
        _declarationSelected.value) {
      valid = true;
    } else if (_declarationSelected.value &&
        taxPayerTypeController.text.isNotEmpty &&
        _taxTreatyBenefitsSubject.value &&
        beneficialCountryController.text.isNotEmpty &&
        beneficialIdentificationNumberController.text.isNotEmpty &&
        incomeTypeController.text.isNotEmpty &&
        explanationController.text.isNotEmpty) {
      valid = true;
    }

    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  FatcaUSW8TaxPayersDetailsPageViewModel(
      this._fatcaUSW8taxPayerDetailsUseCase) {
    _fatcaUSW8taxPayerDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _fatcaUSW8taxPayerDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _fatcaUSW8taxPayerDetailsResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_TAX_PAYER:
        taxPayerTypeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_IDENTIFICATION_NUMBER:
        identificationNumberKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_DECLARATION_SELECTION:
        updateDeclarationErrorValue(true);
        break;
      case ErrorType.INVALID_BENEFICIAL_ADDRESS:
        beneficialCountryKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_BENEFICIAL_IDENTIFICATION_NUMBER:
        beneficialIdentificationNumberKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_INCOME_TYPE:
        incomeTypeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EXPLANATION:
        explanationKey.currentState!.isValid = false;
        break;
    }
  }

  void validateFatcaUSW8TaxPayersDetails() {
    _fatcaUSW8taxPayerDetailsRequest.safeAdd(
        FatcaUSW8TaxPayerDetailsUseCaseParams(
            isUSTaxPayer: _identificationVisibilitySubject.value,
            identificationNumber: identificationNumberController.text,
            wantToClaimTaxTreatyBenefits: _taxTreatyBenefitsSubject.value,
            beneficialAddress: beneficialCountryController.text,
            beneficialIdentificationNumber:
                beneficialIdentificationNumberController.text,
            typeOfIncome: incomeTypeController.text,
            explanation: explanationController.text,
            taxPayerType: taxPayerTypeController.text,
            declarationSelected: _declarationSelected.value));
  }

  void updateTaxPayerTypeField(String value) {
    taxPayerTypeController.text = value;
    if (value.fromValue() == TaxPayerEnum.SOCIAL_SECURITY) {
      updateVisibilityValue(true);
    } else {
      updateVisibilityValue(false);
    }
  }

  @override
  void dispose() {
    _fatcaUSW8taxPayerDetailsRequest.close();
    _fatcaUSW8taxPayerDetailsResponse.close();
    _allFieldValidatorSubject.close();
    _taxTreatyBenefitsSubject.close();
    _declarationSelected.close();
    super.dispose();
  }
}
