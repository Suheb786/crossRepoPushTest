import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:domain/usecase/user/send_documents_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class UploadDocumentsPageViewModel extends BasePageViewModel {
  final SendDocumentsUseCase _documentsUseCase;
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();

  final GlobalKey<AppTextFieldState> addressDocumentKey =
      GlobalKey(debugLabel: "addressDocument");
  final GlobalKey<AppTextFieldState> incomeDocumentKey =
      GlobalKey(debugLabel: "incomeDocument");

  ///documents
  PublishSubject<SendDocumentsUseCaseParams> _documentsRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _documentsResponse = PublishSubject();

  Stream<Resource<bool>> get documentsStream => _documentsResponse.stream;

  ///upload income proof
  PublishSubject<UploadDocumentUseCaseParams> _uploadIncomePoofRequest =
      PublishSubject();

  PublishSubject<String> _uploadIncomePoofResponse = PublishSubject();

  Stream<String> get uploadIncomePoofStream => _uploadIncomePoofResponse.stream;

  ///is income document uploaded
  Stream<bool> get documentIncomeStream => _documentIncomeRequest.stream;

  PublishSubject<bool> _documentIncomeRequest = PublishSubject();

  ///upload address proof
  PublishSubject<UploadDocumentUseCaseParams> _uploadAddressPoofRequest =
      PublishSubject();

  PublishSubject<String> _uploadAddressPoofResponse = PublishSubject();

  Stream<String> get uploadAddressPoofStream =>
      _uploadAddressPoofResponse.stream;

  ///is address document uploaded
  Stream<bool> get documentAddressStream => _documentAddressRequest.stream;

  PublishSubject<bool> _documentAddressRequest = PublishSubject();

  UploadDocumentsPageViewModel(
      this._documentsUseCase, this._uploadDocumentUseCase) {
    _documentsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _documentsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _documentsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _uploadIncomePoofRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadIncomePoofResponse.safeAdd(event.data!);
      });
    });

    _uploadAddressPoofRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadAddressPoofResponse.safeAdd(event.data!);
      });
    });
  }

  void uploadIncomeDocument(DocumentTypeEnum type) {
    _uploadIncomePoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updateIncomeDocumentField(String value) {
    incomeController.text = value.split("/").last;
    updateIncomeUploadedStream(true);
  }

  void updateIncomeUploadedStream(bool value) {
    _documentIncomeRequest.safeAdd(value);
  }

  void uploadAddressDocument(DocumentTypeEnum type) {
    _uploadAddressPoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updateAddressDocumentField(String value) {
    addressController.text = value.split("/").last;
    updateAddressUploadedStream(true);
  }

  void updateAddressUploadedStream(bool value) {
    _documentAddressRequest.safeAdd(value);
  }

  void validateDocuments() {
    _documentsRequest.safeAdd(SendDocumentsUseCaseParams(
        incomeProof: incomeController.text,
        addressProof: addressController.text));
  }

  @override
  void dispose() {
    _documentsRequest.close();
    _uploadIncomePoofRequest.close();
    _uploadAddressPoofRequest.close();
    _documentAddressRequest.close();
    _documentIncomeRequest.close();
    super.dispose();
  }
}
