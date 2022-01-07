import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/model/id_card/ahwal_details_response.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/country/fetch_allowed_issuers_usecase.dart';
import 'package:domain/usecase/id_card/get_ahwal_details_usecase.dart';
import 'package:domain/usecase/user/confirm_detail_usecase.dart';
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
  final ConfirmDetailUseCase _confirmDetailUseCase;
  final FetchAllowedIssuersUseCase _fetchAllowedIssuersUseCase;

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

  /// confirm detail request subject holder
  PublishSubject<ConfirmDetailUseCaseParams> _confirmDetailRequest =
      PublishSubject();

  /// confirm detail response subject holder
  PublishSubject<Resource<SaveIdInfoResponse>> _confirmDetailResponse =
      PublishSubject();

  Stream<Resource<SaveIdInfoResponse>> get confirmDetailResponseStream =>
      _confirmDetailResponse.stream;

  ///get allowed issuers subject
  final PublishSubject<FetchAllowedIssuersUseCaseParams>
      _getAllowedIssuersRequest = PublishSubject();

  ///get allowed issuers subject response
  final BehaviorSubject<Resource<List<AllowedIssuerCountry>>>
      _getAllowedIssuersResponse = BehaviorSubject();

  ScannedDocumentInformation scannedDocumentInformation =
      ScannedDocumentInformation();

  IdVerificationInfoViewModel(
      this._idVerificationInfoUseCase,
      this._scanUserDocumentUseCase,
      this._getAhwalDetailsUseCase,
      this._confirmDetailUseCase,
      this._fetchAllowedIssuersUseCase) {
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
        if (event.status == Status.SUCCESS) {
          scannedDocumentInformation = event.data!;
        }
        _scanUserDocumentResponse.safeAdd(event);
      });
    });

    _getAhwalDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getAhwalDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAhwalDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _confirmDetailRequest.listen((value) {
      RequestManager(value,
              createCall: () => _confirmDetailUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _confirmDetailResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _getAllowedIssuersRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _fetchAllowedIssuersUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAllowedIssuersResponse.safeAdd(event);
        if (event.status == Status.SUCCESS) {
          scanDocument();
        }
      });
    });
  }

  void idVerificationInfo() {
    _idVerificationInfoRequest.safeAdd(IdVerificationInfoUseCaseParams(
        isRetrieveConditionChecked: _isRetrievedConditionSubject.value));
  }

  void fetchAllowedIssuers() {
    _getAllowedIssuersRequest.safeAdd(FetchAllowedIssuersUseCaseParams());
  }

  void scanDocument() {
    _scanUserDocumentRequest.safeAdd(ScanUserDocumentUseCaseParams());
  }

  void getAhwalResponse(String id) {
    if (_getAllowedIssuersResponse.value.data!.any((element) =>
        element.countryIsoCode3 ==
        scannedDocumentInformation.issuingPlaceISo3)) {
      _getAhwalDetailsRequest.safeAdd(GetAhwalDetailsUseCaseParams(idNo: id));
    } else {
      _getAhwalDetailsResponse.safeAdd(Resource.error(
          error: AppError(
              error: ErrorInfo(message: ''),
              cause: Exception(""),
              type: ErrorType.NOT_ALLOWED_COUNTRY)));
    }
  }

  void setScannedData() {
    _confirmDetailRequest.safeAdd(ConfirmDetailUseCaseParams(
        name: scannedDocumentInformation.fullName,
        idNumber: scannedDocumentInformation.idNumber,
        dateOfBirth: scannedDocumentInformation.dob!.year == 0
            ? ""
            : scannedDocumentInformation.dob.toString(),
        nationality: scannedDocumentInformation.nationalityIsoCode3,
        expiryDate: scannedDocumentInformation.doe!.year == 0
            ? ""
            : scannedDocumentInformation.doe!.toString(),
        gender: scannedDocumentInformation.gender,
        motherName: "",
        legalDocumentNo: scannedDocumentInformation.documentNumber,
        issuingDate: scannedDocumentInformation.issuingDate!.year == 0
            ? ""
            : scannedDocumentInformation.issuingDate.toString(),
        issuingPlace: scannedDocumentInformation.issuingPlaceISo3,
        declarationSelected: true,
        scannedDocumentInformation: scannedDocumentInformation,
        isMotherNameRequired: false,
        isCardIssueDateRequired: false));
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
    _getAllowedIssuersRequest.close();
    _getAllowedIssuersResponse.close();
    super.dispose();
  }
}
