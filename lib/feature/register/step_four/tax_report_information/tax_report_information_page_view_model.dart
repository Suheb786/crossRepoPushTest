import 'package:domain/constants/enum/reason_unavailability_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/tax_report_information_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class TaxReportInformationPageViewModel extends BasePageViewModel {
  final TaxReportInformationUseCase _taxReportInformationUseCase;
  TextEditingController countrySelectorController = TextEditingController();
  final GlobalKey<AppTextFieldState> countrySelectorKey =
      GlobalKey(debugLabel: "countrySelector");

  TextEditingController tinController = TextEditingController();
  final GlobalKey<AppTextFieldState> tinKey = GlobalKey(debugLabel: "tin");

  TextEditingController reasonController = TextEditingController();
  final GlobalKey<AppTextFieldState> reasonSelectorKey =
      GlobalKey(debugLabel: "reasonSelector");

  TextEditingController explainReasonController = TextEditingController();
  final GlobalKey<AppTextFieldState> explainReasonKey =
      GlobalKey(debugLabel: "explainReason");

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject.seeded(true);

  Stream<bool> get switchValue => _switchSubject.stream;

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  ///validate  fields
  PublishSubject<bool> _taxReportFieldValidateSubject = PublishSubject();

  Stream<bool> get taxReportFieldValidateStream =>
      _taxReportFieldValidateSubject.stream;

  ///tax report information request subject holder
  PublishSubject<TaxReportInformationUseCaseParams>
      _taxReportInformationRequest = PublishSubject();

  ///tax report information response holder
  PublishSubject<Resource<bool>> _taxReportInformationResponse =
      PublishSubject();

  ///tax report information stream
  Stream<Resource<bool>> get taxReportInformationStream =>
      _taxReportInformationResponse.stream;

  ///update reasonControllerText text field
  void updateReasonControllerField(String value) {
    reasonController.text = value;
    if (reasonController.text.fromValue() ==
        ReasonUnavailabilityEnum.REASON_B) {
      updateExplainReasonVisibility(true);
    } else {
      updateExplainReasonVisibility(false);
    }
  }

  ///explain Reason visibility
  PublishSubject<bool> _explainReasonSubject = PublishSubject();

  Stream<bool> get explainReasonStream => _explainReasonSubject.stream;

  void updateExplainReasonVisibility(bool value) {
    _explainReasonSubject.safeAdd(value);
  }

  void validateFields() {
    bool isValid = false;
    if (_switchSubject.value) {
      if (!Validator.isEmpty(countrySelectorController.text) &&
          !Validator.isEmpty(tinController.text)) {
        isValid = true;
      }
    } else {
      if (reasonController.text.fromValue() ==
          ReasonUnavailabilityEnum.REASON_B) {
        if (!Validator.isEmpty(countrySelectorController.text) &&
            !Validator.isEmpty(reasonController.text) &&
            !Validator.isEmpty(explainReasonController.text)) {
          isValid = true;
        }
      } else {
        if (!Validator.isEmpty(reasonController.text) &&
            !Validator.isEmpty(countrySelectorController.text)) {
          isValid = true;
        }
      }
    }
    updateValidateFieldValue(isValid);
  }

  TaxReportInformationPageViewModel(this._taxReportInformationUseCase) {
    _taxReportInformationRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _taxReportInformationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _taxReportInformationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_TAX_COUNTRY:
        countrySelectorKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_TIN_NUMBER:
        tinKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REASON_OF_UNAVAILABILITY:
        reasonSelectorKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EXPLANATION_FOR_UNAVAILABILITY:
        explainReasonKey.currentState!.isValid = false;
        break;
      default:
        return;
    }
  }

  void validateTaxReportInformation() {
    if (_switchSubject.value) {
      _taxReportInformationRequest.safeAdd(TaxReportInformationUseCaseParams(
          tinNumber: tinController.text,
          explainReason: 'no',
          reasonOfUnavailability: 'no',
          taxCountry: countrySelectorController.text));
    } else {
      if (reasonController.text.fromValue() ==
          ReasonUnavailabilityEnum.REASON_B) {
        _taxReportInformationRequest.safeAdd(TaxReportInformationUseCaseParams(
            tinNumber: 'text',
            explainReason: explainReasonController.text,
            reasonOfUnavailability: reasonController.text,
            taxCountry: countrySelectorController.text));
      } else {
        _taxReportInformationRequest.safeAdd(TaxReportInformationUseCaseParams(
            tinNumber: "text",
            explainReason: 'no',
            reasonOfUnavailability: reasonController.text,
            taxCountry: countrySelectorController.text));
      }
    }
  }

  void updateValidateFieldValue(bool value) {
    _taxReportFieldValidateSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _taxReportFieldValidateSubject.close();
    _switchSubject.close();
    _explainReasonSubject.close();
    _taxReportInformationRequest.close();
    _taxReportInformationResponse.close();
    super.dispose();
  }
}
