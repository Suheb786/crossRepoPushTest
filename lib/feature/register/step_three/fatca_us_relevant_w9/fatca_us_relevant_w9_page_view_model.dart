import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w9_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaUSRelevantW9PageViewModel extends BasePageViewModel {
  final FatcaUSRelevantW9UseCase _fatcaUSRelevantW8UseCase;

  final UploadDocumentUseCase _uploadDocumentUseCase;

  ///controllers and keys
  final TextEditingController nameAsPerTaxReturnController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> nameAsPerTaxReturnKey =
      GlobalKey(debugLabel: "nameAsPerTaxReturn");

  final TextEditingController businessNameController = TextEditingController();
  final GlobalKey<AppTextFieldState> businessNameKey =
      GlobalKey(debugLabel: "businessName");

  final TextEditingController uploadDocumentController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> uploadDocumentKey =
      GlobalKey(debugLabel: "uploadDocument");

  ///fatca us relevant request subject holder
  PublishSubject<FatcaUSRelevantW9UseCaseParams> _fatcaUSRelevantW8Request =
      PublishSubject();

  ///fatca us relevant response holder
  PublishSubject<Resource<bool>> _fatcaUSRelevantW8Response = PublishSubject();

  ///fatca us relevant stream
  Stream<Resource<bool>> get fatcaUSRelevantW8Stream =>
      _fatcaUSRelevantW8Response.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///document selection request holder
  PublishSubject<UploadDocumentUseCaseParams> _uploadDocumentRequest =
      PublishSubject();

  ///document selection response holder
  PublishSubject<String> _uploadDocumentResponse = PublishSubject();

  ///document selection response stream
  Stream<String> get uploadDocumentStream => _uploadDocumentResponse.stream;

  bool isValid() {
    bool valid = false;
    if (nameAsPerTaxReturnController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  ///all field validate stream
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

  FatcaUSRelevantW9PageViewModel(
      this._fatcaUSRelevantW8UseCase, this._uploadDocumentUseCase) {
    _fatcaUSRelevantW8Request.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _fatcaUSRelevantW8UseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _fatcaUSRelevantW8Response.add(event);
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
      case ErrorType.INVALID_NAME_AS_PER_TAX_RETURN:
        nameAsPerTaxReturnKey.currentState!.isValid = false;
        break;
    }
  }

  void validateFatcaUSRelevantW9Details() {
    _fatcaUSRelevantW8Request.safeAdd(FatcaUSRelevantW9UseCaseParams(
        nameAsPerTax: nameAsPerTaxReturnController.text,
        businessName: businessNameController.text));
  }

  void uploadDocument(DocumentTypeEnum type) {
    _uploadDocumentRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  @override
  void dispose() {
    _fatcaUSRelevantW8Request.close();
    _fatcaUSRelevantW8Response.close();
    _allFieldValidatorSubject.close();
    _uploadDocumentRequest.close();
    _uploadDocumentResponse.close();
    _documentUploadedRequest.close();
    super.dispose();
  }
}
