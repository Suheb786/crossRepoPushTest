import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/fatca_crs/fatca_set_data.dart';
import 'package:domain/model/fatca_crs/set_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_questions_response_usecase.dart';
import 'package:domain/usecase/fatca_crs/upload_signature_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaSignaturePageViewModel extends BasePageViewModel {
  final UploadSignatureUseCase _uploadSignatureUseCase;
  final SetFatcaQuestionsResponseUseCase _setFatcaQuestionsUseCase;

  ///upload document usecase
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final TextEditingController signatureController = TextEditingController();

  final GlobalKey<AppTextFieldState> signatureKey =
      GlobalKey(debugLabel: "signatureKey");

  ///upload signature
  PublishSubject<UploadSignatureUseCaseParams> _uploadSignatureRequest =
      PublishSubject();

  PublishSubject<Resource<UploadSignatureResponse>> _uploadSignatureResponse =
      PublishSubject();

  Stream<Resource<UploadSignatureResponse>> get uploadSignatureStream =>
      _uploadSignatureResponse.stream;

  ///get document
  PublishSubject<UploadDocumentUseCaseParams> _getDocumentRequest =
      PublishSubject();

  PublishSubject<String> _getDocumentResponse = PublishSubject();

  Stream<String> get getDocumentStream => _getDocumentResponse.stream;

  ///is signature document uploaded
  PublishSubject<bool> _signatureUploadedRequest = PublishSubject();

  Stream<bool> get signatureUploadedStream => _signatureUploadedRequest.stream;

  bool isSignatureUploaded = false;

  String selectedFile = '';

  String fileId = '';

  /// animated button visibility subject
  BehaviorSubject<bool> _showAnimatedButtonSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get showAnimatedButtonStream =>
      _showAnimatedButtonSubject.stream;

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
  }

  ///verify info declaration selected  subject
  BehaviorSubject<bool> _verifyInfoDeclarationSelected =
      BehaviorSubject.seeded(false);

  ///verify info declaration selected stream
  Stream<bool> get verifyInfoDeclarationSelectedStream =>
      _verifyInfoDeclarationSelected.stream;

  ///update declaration selection function
  void updateVerifyInfoDeclarationSelection(bool value) {
    _verifyInfoDeclarationSelected.safeAdd(value);
  }

  ///set fatca questions request subject holder
  PublishSubject<SetFatcaQuestionsResponseUseCaseParams>
      _setFatcaQuestionsRequest = PublishSubject();

  ///set fatca questions response holder
  PublishSubject<Resource<SetFatcaQuestionsResponse>>
      _setFatcaQuestionsResponse = PublishSubject();

  ///set fatca questions stream
  Stream<Resource<SetFatcaQuestionsResponse>> get setFatcaQuestionsStream =>
      _setFatcaQuestionsResponse.stream;

  FatcaSignaturePageViewModel(this._uploadSignatureUseCase,
      this._uploadDocumentUseCase, this._setFatcaQuestionsUseCase) {
    _uploadSignatureRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadSignatureUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadSignatureResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _getDocumentRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getDocumentResponse.safeAdd(event.data!);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _setFatcaQuestionsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _setFatcaQuestionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _setFatcaQuestionsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void getDocument(DocumentTypeEnum type) {
    _getDocumentRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updateSignatureField(String value) {
    signatureController.text = value.split("/").last;
    selectedFile = value;
    updateSignatureUploadedStream(true);
  }

  void updateSignatureUploadedStream(bool value) {
    _signatureUploadedRequest.safeAdd(value);
  }

  void signatureUpload() {
    print('${signatureController.text}');
    _uploadSignatureRequest.safeAdd(UploadSignatureUseCaseParams(
        signature: selectedFile,
        declarationSelected: _declarationSelected.value,
        verifyInfoDeclarationSelected: _verifyInfoDeclarationSelected.value));
  }

  bool isValid() {
    bool valid = false;
    if (signatureController.text.isNotEmpty &&
        _declarationSelected.value &&
        _verifyInfoDeclarationSelected.value) {
      valid = true;
    }

    _showAnimatedButtonSubject.safeAdd(valid);
    return valid;
  }

  // void setFatcaQuestionResponse(BuildContext context) {
  //   _setFatcaQuestionsRequest.safeAdd(SetFatcaQuestionsResponseUseCaseParams(
  //       declarationSelected: ProviderScope.containerOf(context)
  //           .read(taxationDetailsPageViewModelProvider)
  //           .declarationSelectedStream
  //           .previous(animation: true), isUSTaxResident: null;,
  //       isPEP: isPEP,
  //       relationShipPEP: relationShipController.text,
  //       personName: personNameController.text,
  //       personRole: personRoleController.text,
  //       anyOtherCountryResident: anyOtherCountryResident,
  //       country: countrySelectorController.text,
  //       isUSCitizen: isUSCitizen,
  //       isUSTaxResident: usTaxResident,
  //       wasBornInUS: bornInUS));
  // }

  ///update data to main page
  void updateData(BuildContext context) {
    FatcaSetData fatcaSetData = ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .fatcaData;
    fatcaSetData.signatureId = fileId;
    ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .setFatcaData(fatcaSetData);
  }

  @override
  void dispose() {
    _signatureUploadedRequest.close();
    _uploadSignatureRequest.close();
    _uploadSignatureResponse.close();
    _showAnimatedButtonSubject.close();
    _getDocumentRequest.close();
    _getDocumentResponse.close();
    super.dispose();
  }
}
