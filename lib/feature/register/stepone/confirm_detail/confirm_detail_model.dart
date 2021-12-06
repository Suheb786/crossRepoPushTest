import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/user/confirm_detail_usecase.dart';
import 'package:domain/usecase/user/scan_user_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmDetailViewModel extends BasePageViewModel {
  final ConfirmDetailUseCase _confirmDetailUseCase;
  final ScanUserDocumentUseCase _scanUserDocumentUseCase;
  TextEditingController nameController = new TextEditingController();
  TextEditingController idNumberController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController nationalityController = new TextEditingController();
  TextEditingController expiryDateController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController motherNameController = new TextEditingController();
  TextEditingController legalDocumentController = new TextEditingController();
  TextEditingController issuingDateController = new TextEditingController();
  TextEditingController issuingPlaceController = new TextEditingController();

  final GlobalKey<AppTextFieldState> nameKey = GlobalKey(debugLabel: "name");

  final GlobalKey<AppTextFieldState> idNumberKey =
      GlobalKey(debugLabel: "idNumber");

  final GlobalKey<AppTextFieldState> dobKey = GlobalKey(debugLabel: "dob");

  final GlobalKey<AppTextFieldState> nationalityKey =
      GlobalKey(debugLabel: "nationality");

  final GlobalKey<AppTextFieldState> expiryDateKey =
      GlobalKey(debugLabel: "expiryDate");

  final GlobalKey<AppTextFieldState> genderKey =
      GlobalKey(debugLabel: "gender");

  final GlobalKey<AppTextFieldState> motherNameKey =
      GlobalKey(debugLabel: "mother's name");

  final GlobalKey<AppTextFieldState> legalDocumentKey =
      GlobalKey(debugLabel: "legalDocument");

  final GlobalKey<AppTextFieldState> issuingDateKey =
      GlobalKey(debugLabel: "issuingDate");

  final GlobalKey<AppTextFieldState> issuingPlaceKey =
      GlobalKey(debugLabel: "issuingPlace");

  String selectedDobDate = DateTime.now().toLocal().toString();

  String selectedIssuingDate = DateTime.now().toLocal().toString();

  String selectedExpiryDate = DateTime.now().toLocal().toString();

  ///scan document request holder
  final PublishSubject<ScanUserDocumentUseCaseParams> _scanUserDocumentRequest =
      PublishSubject();

  ///scan document response holder
  final PublishSubject<Resource<ScannedDocumentInformation>>
      _scanUserDocumentResponse = PublishSubject();

  ///scan document response stream
  Stream<Resource<ScannedDocumentInformation>> get scanUserDocumentStream =>
      _scanUserDocumentResponse.stream;

  /// declaration selected subject holder
  BehaviorSubject<bool> _declarationSelectedSubject =
      BehaviorSubject.seeded(false);

  /// declaration selected response stream
  Stream<bool> get declarationSelectedStream =>
      _declarationSelectedSubject.stream;

  void updateDeclarationValue(bool value) {
    _declarationSelectedSubject.safeAdd(value);
  }

  /// confirm detail request subject holder
  PublishSubject<ConfirmDetailUseCaseParams> _confirmDetailRequest =
      PublishSubject();

  /// confirm detail response subject holder
  PublishSubject<Resource<SaveIdInfoResponse>> _confirmDetailResponse =
      PublishSubject();

  Stream<Resource<SaveIdInfoResponse>> get confirmDetailResponseStream =>
      _confirmDetailResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ScannedDocumentInformation scannedDocumentResult =
      ScannedDocumentInformation();

  ConfirmDetailViewModel(
      this._confirmDetailUseCase, this._scanUserDocumentUseCase) {
    _confirmDetailRequest.listen((value) {
      RequestManager(value,
              createCall: () => _confirmDetailUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _confirmDetailResponse.safeAdd(event);
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
  }

  void scanDocument() {
    _scanUserDocumentRequest.safeAdd(ScanUserDocumentUseCaseParams());
  }

  void confirmDetail() {
    _confirmDetailRequest.safeAdd(ConfirmDetailUseCaseParams(
        name: nameController.text,
        idNumber: idNumberController.text,
        dateOfBirth: scannedDocumentResult.dob!.year == 0
            ? selectedDobDate
            : scannedDocumentResult.dob.toString(),
        nationality: nationalityController.text,
        expiryDate: scannedDocumentResult.doe!.year == 0
            ? selectedExpiryDate
            : scannedDocumentResult.doe!.toString(),
        gender: genderController.text,
        motherName: motherNameController.text,
        legalDocumentNo: legalDocumentController.text,
        issuingDate: scannedDocumentResult.issuingDate!.year == 0
            ? selectedIssuingDate
            : scannedDocumentResult.issuingDate.toString(),
        issuingPlace: issuingPlaceController.text,
        declarationSelected: _declarationSelectedSubject.value,
        scannedDocumentInformation: scannedDocumentResult));
  }

  void validateDetails() {
    if (nameController.text.isNotEmpty &&
        idNumberController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        nationalityController.text.isNotEmpty &&
        expiryDateController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        motherNameController.text.isNotEmpty &&
        legalDocumentController.text.isNotEmpty &&
        issuingPlaceController.text.isNotEmpty &&
        issuingDateController.text.isNotEmpty &&
        _declarationSelectedSubject.value) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _confirmDetailRequest.close();
    _showButtonSubject.close();
    _confirmDetailResponse.close();
    _declarationSelectedSubject.close();
    _scanUserDocumentRequest.close();
    _scanUserDocumentResponse.close();
    super.dispose();
  }

  void setData(ScannedDocumentInformation? data) {
    scannedDocumentResult = data!;
    nameController.text = data.fullName!;
    idNumberController.text = data.idNumber!;
    dobController.text = data.dob!.year != 0
        ? TimeUtils.getFormattedDOB(data.dob!.toString())
        : '';
    nationalityController.text = data.nationality!;
    genderController.text = data.gender!;
    motherNameController.text = data.motherName!;
    legalDocumentController.text = data.documentNumber!;
    issuingDateController.text = data.issuingDate!.year != 0
        ? TimeUtils.getFormattedDOB(data.issuingDate!.toString())
        : '';
    expiryDateController.text = data.doe!.year != 0
        ? TimeUtils.getFormattedDOB(data.doe!.toString())
        : '';
    issuingPlaceController.text = data.issuingPlace!;
  }
}
