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

  GlobalKey<AppTextFieldState> nameKey = GlobalKey(debugLabel: "name");

  GlobalKey<AppTextFieldState> idNumberKey = GlobalKey(debugLabel: "idNumber");

  GlobalKey<AppTextFieldState> dobKey = GlobalKey(debugLabel: "dob");

  GlobalKey<AppTextFieldState> nationalityKey =
      GlobalKey(debugLabel: "nationality");

  GlobalKey<AppTextFieldState> expiryDateKey =
      GlobalKey(debugLabel: "expiryDate");

  GlobalKey<AppTextFieldState> genderKey = GlobalKey(debugLabel: "gender");

  GlobalKey<AppTextFieldState> motherNameKey =
      GlobalKey(debugLabel: "mother's name");

  GlobalKey<AppTextFieldState> legalDocumentKey =
      GlobalKey(debugLabel: "legalDocument");

  GlobalKey<AppTextFieldState> issuingDateKey =
      GlobalKey(debugLabel: "issuingDate");

  GlobalKey<AppTextFieldState> issuingPlaceKey =
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
        updateLoader();
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

  bool isNameReadOnly = false;
  bool isIdNoReadOnly = false;
  bool isDobReadOnly = false;
  bool isNationalityReadOnly = false;
  bool isExpiryDateReadOnly = false;
  bool isGenderReadOnly = false;
  bool isMotherNameReadOnly = false;
  bool isLegalDocumentReadOnly = false;
  bool isIssuingDateReadOnly = false;
  bool isIssuingPlaceReadOnly = false;

  void confirmDetail() {
    _confirmDetailRequest.safeAdd(ConfirmDetailUseCaseParams(
        name: nameController.text,
        idNumber: idNumberController.text,
        dateOfBirth: scannedDocumentResult.dob!.year == 0
            ? selectedDobDate
            : scannedDocumentResult.dob.toString(),
        nationality: scannedDocumentResult.nationalityIsoCode3,
        //nationalityController.text,
        expiryDate: scannedDocumentResult.doe!.year == 0
            ? selectedExpiryDate
            : scannedDocumentResult.doe!.toString(),
        gender: genderController.text,
        motherName: motherNameController.text,
        legalDocumentNo: legalDocumentController.text,
        issuingDate: scannedDocumentResult.issuingDate!.year == 0
            ? selectedIssuingDate
            : scannedDocumentResult.issuingDate.toString(),
        issuingPlace: scannedDocumentResult.issuingPlaceISo3,
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

    setVisibility();
  }

  void setVisibility() {
    isNameReadOnly = nameController.text.isNotEmpty;
    isIdNoReadOnly = idNumberController.text.isNotEmpty;
    isDobReadOnly = dobController.text.isNotEmpty;
    isNationalityReadOnly = nationalityController.text.isNotEmpty;
    isGenderReadOnly = genderController.text.isNotEmpty;
    isMotherNameReadOnly = motherNameController.text.isNotEmpty;
    isLegalDocumentReadOnly = legalDocumentController.text.isNotEmpty;
    isIssuingDateReadOnly = issuingDateController.text.isNotEmpty;
    isIssuingPlaceReadOnly = issuingPlaceController.text.isNotEmpty;
    isExpiryDateReadOnly = expiryDateController.text.isNotEmpty;
  }
}
