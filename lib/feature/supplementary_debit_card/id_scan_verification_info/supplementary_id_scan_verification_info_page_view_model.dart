import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/user/scan_user_document_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SupplementaryIdScanVerificationInfoDebitPageViewModel
    extends BasePageViewModel {
  final ScanUserDocumentUseCase _scanUserDocumentUseCase;

  ///scan document request holder
  final PublishSubject<ScanUserDocumentUseCaseParams> _scanUserDocumentRequest =
      PublishSubject();

  ///scan document response holder
  final PublishSubject<Resource<ScannedDocumentInformation>>
      _scanUserDocumentResponse = PublishSubject();

  ///scan document response stream
  Stream<Resource<ScannedDocumentInformation>> get scanUserDocumentStream =>
      _scanUserDocumentResponse.stream;

  ScannedDocumentInformation scannedDocumentInformation =
      ScannedDocumentInformation();

  SupplementaryIdScanVerificationInfoDebitPageViewModel(
    this._scanUserDocumentUseCase,
  ) {
    _scanUserDocumentRequest
        .debounceTime(Duration(milliseconds: 800))
        .distinct()
        .listen((value) {
      RequestManager(value,
              createCall: () => _scanUserDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          scannedDocumentInformation = event.data!;
        }
        _scanUserDocumentResponse.safeAdd(event);
      });
    });
  }

  void scanDocument() {
    _scanUserDocumentRequest.safeAdd(ScanUserDocumentUseCaseParams());
  }

  @override
  void dispose() {
    _scanUserDocumentRequest.close();
    _scanUserDocumentResponse.close();

    super.dispose();
  }
}
