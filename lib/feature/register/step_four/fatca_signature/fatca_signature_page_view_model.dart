import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/usecase/fatca_crs/upload_signature_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaSignaturePageViewModel extends BasePageViewModel {
  final UploadSignatureUseCase _uploadSignatureUseCase;

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

  String fileId='';

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

  FatcaSignaturePageViewModel(
      this._uploadSignatureUseCase, this._uploadDocumentUseCase) {
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
