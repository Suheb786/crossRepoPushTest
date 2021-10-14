import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/user/send_documents_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:domain/constants/enum/document_type_enum.dart';

class UploadDocumentsPageViewModel extends BasePageViewModel {
  final SendDocumentsUseCase _documentsUseCase;
  final UploadDocumentUseCase _uploadDocumentUseCase;

  PublishSubject<SendDocumentsUseCaseParams> _documentsRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _documentsResponse = PublishSubject();

  Stream<Resource<bool>> get documentsStream => _documentsResponse.stream;

  PublishSubject<UploadDocumentUseCaseParams> _uploadIncomePoofRequest =
      PublishSubject();

  PublishSubject<String> _uploadIncomePoofResponse = PublishSubject();

  Stream<String> get uploadIncomePoofStream => _uploadIncomePoofResponse.stream;

  PublishSubject<UploadDocumentUseCaseParams> _uploadAddressPoofRequest =
      PublishSubject();
  PublishSubject<String> _uploadAddressPoofResponse = PublishSubject();

  Stream<String> get uploadAddressPoofStream =>
      _uploadAddressPoofResponse.stream;

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

  void updateIncomeFileName(String fileName) {
    incomeFileStr = fileName;
    incomeFileUploaded = !(incomeFileUploaded);
    notifyListeners();
  }

  void updateAddressFileName(String fileName) {
    addressFileStr = fileName;
    addressFileUploaded = !(addressFileUploaded);
    notifyListeners();
  }

  String? incomeFileStr;
  String? addressFileStr;
  bool incomeFileUploaded = false;
  bool addressFileUploaded = false;

  void pickIncomePoofDocument(DocumentTypeEnum type) {
    _uploadIncomePoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void pickAddressPoofDocument(DocumentTypeEnum type) {
    _uploadAddressPoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }
}
