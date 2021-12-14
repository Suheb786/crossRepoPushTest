import 'package:domain/model/id_card/ahwal_details_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/id_card/get_ahwal_details_usecase.dart';
import 'package:domain/usecase/user/id_verification_info_usecase.dart';
import 'package:domain/usecase/user/scan_user_document_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class IdVerificationInfoViewModel extends BasePageViewModel {
  final IdVerificationInfoUseCase _idVerificationInfoUseCase;
  final ScanUserDocumentUseCase _scanUserDocumentUseCase;
  final GetAhwalDetailsUseCase _getAhwalDetailsUseCase;

  /// retrieve condition check subject holder
  BehaviorSubject<bool> _isRetrievedConditionSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isRetrievedConditionStream =>
      _isRetrievedConditionSubject.stream;

  /// id verification info request subject holder
  PublishSubject<IdVerificationInfoUseCaseParams> _idVerificationInfoRequest =
      PublishSubject();

  Stream<IdVerificationInfoUseCaseParams> get idVerificationRequestStream =>
      _idVerificationInfoRequest.stream;

  /// id verification info response subject holder
  PublishSubject<Resource<bool>> _idVerificationInfoResponse = PublishSubject();

  Stream<Resource<bool>> get idVerificationResponseStream =>
      _idVerificationInfoResponse.stream;

  void updateIsRetrievedConditionStream(bool value) {
    _isRetrievedConditionSubject.safeAdd(value);
  }

  ///scan document request holder
  final PublishSubject<ScanUserDocumentUseCaseParams> _scanUserDocumentRequest =
      PublishSubject();

  ///scan document response holder
  final PublishSubject<Resource<ScannedDocumentInformation>>
      _scanUserDocumentResponse = PublishSubject();

  ///scan document response stream
  Stream<Resource<ScannedDocumentInformation>> get scanUserDocumentStream =>
      _scanUserDocumentResponse.stream;

  ///get ahwal details subject holder
  final PublishSubject<GetAhwalDetailsUseCaseParams> _getAhwalDetailsRequest =
      PublishSubject();

  ///get ahwal details subject response holder
  final PublishSubject<Resource<AhwalDetailResponse>> _getAhwalDetailsResponse =
      PublishSubject();

  ///get ahwal details response stream
  Stream<Resource<AhwalDetailResponse>> get getAhwalDetailsStream =>
      _getAhwalDetailsResponse.stream;

  ScannedDocumentInformation scannedDocumentInformation = ScannedDocumentInformation();

  IdVerificationInfoViewModel(this._idVerificationInfoUseCase,
      this._scanUserDocumentUseCase, this._getAhwalDetailsUseCase) {
    _idVerificationInfoRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _idVerificationInfoUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _idVerificationInfoResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _scanUserDocumentRequest
        .debounceTime(Duration(milliseconds: 800))
        .distinct()
        .listen((value) {
      RequestManager(value,
              createCall: () => _scanUserDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _scanUserDocumentResponse.safeAdd(event);
      });
    });

    _getAhwalDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getAhwalDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAhwalDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void idVerificationInfo() {
    _idVerificationInfoRequest.safeAdd(IdVerificationInfoUseCaseParams(
        isRetrieveConditionChecked: _isRetrievedConditionSubject.value));
  }

  void scanDocument() {
    _scanUserDocumentRequest.safeAdd(ScanUserDocumentUseCaseParams());
  }

  void getAhwalResponse(String id) {
    _getAhwalDetailsRequest.safeAdd(GetAhwalDetailsUseCaseParams(idNo: id));
  }

  @override
  void dispose() {
    _isRetrievedConditionSubject.close();
    _idVerificationInfoRequest.close();
    _idVerificationInfoResponse.close();
    _scanUserDocumentRequest.close();
    _scanUserDocumentResponse.close();
    _getAhwalDetailsRequest.close();
    _getAhwalDetailsResponse.close();
    super.dispose();
  }
}
