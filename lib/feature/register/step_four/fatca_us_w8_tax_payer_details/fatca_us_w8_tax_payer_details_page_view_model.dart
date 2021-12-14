import 'package:domain/constants/enum/us_relevant_w8_tax_payer_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/fatca_crs/fatca_set_data.dart';
import 'package:domain/usecase/register/fatca_us_w8_tax_payer_details_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/register/register_modules.dart';
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

  final TextEditingController referenceNumberController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> referenceNumberKey =
      GlobalKey(debugLabel: "referenceNumber");

  final TextEditingController beneficialCountryController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> beneficialCountryKey =
      GlobalKey(debugLabel: "beneficialCountry");

  final TextEditingController provisionClaimController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> provisionClaimKey =
      GlobalKey(debugLabel: "provisionClaim");

  final TextEditingController treatyClaimRateController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> treatyClaimRateKey =
      GlobalKey(debugLabel: "treatyClaimRate");

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

  ///tax treaty benefits switch value subject
  final BehaviorSubject<bool> _taxTreatyBenefitsSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get taxTreatyBenefitsValue => _taxTreatyBenefitsSubject.stream;

  void updateTaxTreatyBenefitsValue(bool value) {
    _taxTreatyBenefitsSubject.safeAdd(value);
  }

  bool isValid() {
    bool valid = false;

    if (_taxTreatyBenefitsSubject.value) {
      if (_identificationVisibilitySubject.value) {
        if (taxPayerTypeController.text.isNotEmpty &&
            identificationNumberController.text.isNotEmpty &&
            referenceNumberController.text.isNotEmpty &&
            beneficialCountryController.text.isNotEmpty &&
            treatyClaimRateController.text.isNotEmpty &&
            provisionClaimController.text.isNotEmpty &&
            incomeTypeController.text.isNotEmpty &&
            explanationController.text.isNotEmpty) {
          valid = true;
        }
      } else {
        if (taxPayerTypeController.text.isNotEmpty &&
            beneficialCountryController.text.isNotEmpty &&
            treatyClaimRateController.text.isNotEmpty &&
            provisionClaimController.text.isNotEmpty &&
            incomeTypeController.text.isNotEmpty &&
            explanationController.text.isNotEmpty) {
          valid = true;
        }
      }
    } else {
      if (_identificationVisibilitySubject.value) {
        if (taxPayerTypeController.text.isNotEmpty &&
            identificationNumberController.text.isNotEmpty &&
            referenceNumberController.text.isNotEmpty) {
          valid = true;
        }
      } else {
        if (taxPayerTypeController.text.isNotEmpty) {
          valid = true;
        }
      }
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
        updateLoader();
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
      case ErrorType.INVALID_BENEFICIAL_ADDRESS:
        beneficialCountryKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_TREATY_CLAIM_RATE:
        treatyClaimRateKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_PROVISION_CLAIM:
        provisionClaimKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_INCOME_TYPE:
        incomeTypeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EXPLANATION:
        explanationKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REFERENCE_NO:
        referenceNumberKey.currentState!.isValid = false;
        break;
    }
  }

  void validateFatcaUSW8TaxPayersDetails() {
    _fatcaUSW8taxPayerDetailsRequest
        .safeAdd(FatcaUSW8TaxPayerDetailsUseCaseParams(
      isUSTaxPayer: _identificationVisibilitySubject.value,
      identificationNumber: identificationNumberController.text,
      wantToClaimTaxTreatyBenefits: _taxTreatyBenefitsSubject.value,
      beneficialAddress: beneficialCountryController.text,
      treatyClaimRate: treatyClaimRateController.text,
      provisionClaimArticle: provisionClaimController.text,
      typeOfIncome: incomeTypeController.text,
      explanation: explanationController.text,
      taxPayerType: taxPayerTypeController.text,
      referenceNumber: referenceNumberController.text,
    ));
  }

  void updateTaxPayerTypeField(String value) {
    taxPayerTypeController.text = value;
    if (value.fromValue() == USRelevantW8TaxPayerEnum.US) {
      updateVisibilityValue(true);
    } else {
      updateVisibilityValue(false);
    }
  }

  ///update data to main page
  void updateData(BuildContext context) {
    FatcaSetData fatcaSetData = ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .fatcaData;
    fatcaSetData.taxPayer = taxPayerTypeController.text;
    fatcaSetData.usTaxIdNo = identificationNumberController.text;

    ///referenece no is missing
    fatcaSetData.claimTaxTreatBenefits = _taxTreatyBenefitsSubject.value;
    fatcaSetData.beneficialOwnerResident = beneficialCountryController.text;

    ///provision claim is missing
    ///treaty identified to claim rate
    fatcaSetData.typeOfIncome = incomeTypeController.text;
    fatcaSetData.explanation = explanationController.text;
    ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .setFatcaData(fatcaSetData);
  }

  @override
  void dispose() {
    _fatcaUSW8taxPayerDetailsRequest.close();
    _fatcaUSW8taxPayerDetailsResponse.close();
    _allFieldValidatorSubject.close();
    _taxTreatyBenefitsSubject.close();
    super.dispose();
  }
}
