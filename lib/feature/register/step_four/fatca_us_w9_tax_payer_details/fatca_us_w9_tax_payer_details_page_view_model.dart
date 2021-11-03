import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/enum/us_relevant_w9_tax_payer_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/fatca_us_w9_tax_payer_details_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaUSW9TaxPayersDetailsPageViewModel extends BasePageViewModel {
  final FatcaUSW9TaxPayerDetailsUseCase _fatcaUSW9taxPayerDetailsUseCase;

  final UploadDocumentUseCase _uploadDocumentUseCase;

  ///controllers and keys
  final TextEditingController taxPayerTypeController = TextEditingController();
  final GlobalKey<AppTextFieldState> taxPayerTypeKey =
      GlobalKey(debugLabel: "taxPayerType");

  final TextEditingController socialSecurityNumberController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> socialSecurityNumberKey =
      GlobalKey(debugLabel: "socialSecurityNumber");

  final TextEditingController uploadDocumentController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> uploadDocumentKey =
      GlobalKey(debugLabel: "uploadDocument");

  ///fatca us w9 taxPayer details request subject holder
  PublishSubject<FatcaUSW9TaxPayerDetailsUseCaseParams>
      _fatcaUSW9taxPayerDetailsRequest = PublishSubject();

  ///fatca us w9 taxPayer details response holder
  PublishSubject<Resource<bool>> _fatcaUSW9taxPayerDetailsResponse =
      PublishSubject();

  ///fatca us w9 taxPayer details stream
  Stream<Resource<bool>> get fatcaUSW9taxPayerDetailsStream =>
      _fatcaUSW9taxPayerDetailsResponse.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///social security number field visibility subject
  final BehaviorSubject<bool> _socialSecurityVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get socialSecurityVisibilityStream =>
      _socialSecurityVisibilitySubject.stream;

  void updateVisibilityValue(bool value) {
    _socialSecurityVisibilitySubject.safeAdd(value);
  }

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
  }

  bool isValid() {
    bool valid = false;
    if (_socialSecurityVisibilitySubject.value) {
      if (taxPayerTypeController.text.isNotEmpty &&
          socialSecurityNumberController.text.isNotEmpty &&
          _declarationSelected.value &&
          uploadDocumentController.text.isNotEmpty) {
        valid = true;
      }
    } else {
      if (taxPayerTypeController.text.isNotEmpty &&
          _declarationSelected.value) {
        valid = true;
      }
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  ///document selection request holder
  PublishSubject<UploadDocumentUseCaseParams> _uploadDocumentRequest =
      PublishSubject();

  ///document selection response holder
  PublishSubject<String> _uploadDocumentResponse = PublishSubject();

  ///document selection response stream
  Stream<String> get uploadDocumentStream => _uploadDocumentResponse.stream;

  ///document selection stream
  Stream<bool> get documentUploadedStream => _documentUploadedRequest.stream;

  ///document selection request holder
  PublishSubject<bool> _documentUploadedRequest = PublishSubject();

  void updateUploadDocumentField(String value) {
    uploadDocumentController.text = value.split("/").last;
    updateDocumentUploadedStream(true);
  }

  void updateDocumentUploadedStream(bool value) {
    _documentUploadedRequest.safeAdd(value);
  }

  FatcaUSW9TaxPayersDetailsPageViewModel(
      this._fatcaUSW9taxPayerDetailsUseCase, this._uploadDocumentUseCase) {
    _fatcaUSW9taxPayerDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _fatcaUSW9taxPayerDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _fatcaUSW9taxPayerDetailsResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _uploadDocumentRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.data != null) {
          _uploadDocumentResponse.safeAdd(event.data!);
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_TAX_PAYER:
        taxPayerTypeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_SECURITY_NUMBER:
        socialSecurityNumberKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_DOCUMENT:
        uploadDocumentKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_DECLARATION_SELECTION:
        break;
    }
  }

  void validateFatcaUSW9TaxPayersDetails() {
    _fatcaUSW9taxPayerDetailsRequest.safeAdd(
        FatcaUSW9TaxPayerDetailsUseCaseParams(
            isSocialSecurityTaxPayer: _socialSecurityVisibilitySubject.value,
            socialSecurityNumber: socialSecurityNumberController.text,
            taxPayerType: taxPayerTypeController.text,
            document: uploadDocumentController.text,
            declarationSelected: _declarationSelected.value));
  }

  void updateTaxPayerTypeField(String value) {
    taxPayerTypeController.text = value;
    if (value.fromValue() == USRelevantW9TaxPayerEnum.SOCIAL_SECURITY) {
      updateVisibilityValue(true);
    } else {
      updateVisibilityValue(false);
    }
  }

  void uploadDocument(DocumentTypeEnum type) {
    _uploadDocumentRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  @override
  void dispose() {
    _fatcaUSW9taxPayerDetailsRequest.close();
    _fatcaUSW9taxPayerDetailsResponse.close();
    _allFieldValidatorSubject.close();
    _uploadDocumentRequest.close();
    _uploadDocumentResponse.close();
    _documentUploadedRequest.close();
    super.dispose();
  }
}
