import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:domain/model/fatca_crs/fatca_w8_data.dart';
import 'package:domain/model/fatca_crs/fatca_w9_data.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_w8_usecase.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_w9_usecase.dart';
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

  final SetFatcaW8UseCase _setFatcaW8UseCase;

  final SetFatcaW9UseCase _setFatcaW9UseCase;

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

  ///set fatca w8 response request subject holder
  PublishSubject<SetFatcaW8UseCaseParams> _setFatcaW8Request = PublishSubject();

  ///set fatca w8 response response holder
  PublishSubject<Resource<bool>> _setFatcaW8Response = PublishSubject();

  ///set fatca w8 response stream
  Stream<Resource<bool>> get setFatcaW8Stream => _setFatcaW8Response.stream;

  ///set fatca w9 response request subject holder
  PublishSubject<SetFatcaW9UseCaseParams> _setFatcaW9Request = PublishSubject();

  // ///set fatca w9 response response holder
  // PublishSubject<Resource<bool>> _setFatcaW9Response = PublishSubject();
  //
  // ///set fatca w9 response stream
  // Stream<Resource<bool>> get setFatcaW9Stream => _setFatcaW9Response.stream;

  FatcaSignaturePageViewModel(
      this._uploadSignatureUseCase,
      this._uploadDocumentUseCase,
      this._setFatcaW8UseCase,
      this._setFatcaW9UseCase) {
    _uploadSignatureRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadSignatureUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _uploadSignatureResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getDocumentRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          _getDocumentResponse.safeAdd(event.data!);
        } else if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _setFatcaW8Request.listen((value) {
      RequestManager(value,
              createCall: () => _setFatcaW8UseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _setFatcaW8Response.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _setFatcaW9Request.listen((value) {
      RequestManager(value,
              createCall: () => _setFatcaW9UseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _setFatcaW8Response.safeAdd(event);
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
    signatureUpload();
  }

  void updateSignatureUploadedStream(bool value) {
    _signatureUploadedRequest.safeAdd(value);
  }

  void signatureUpload() {
    _uploadSignatureRequest
        .safeAdd(UploadSignatureUseCaseParams(signature: selectedFile));
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

  void setFatcaw9Response(BuildContext context) {
    FatcaW9Data fatcaW9Data = ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .getFatcaW9Data;

    fatcaW9Data.signatureId = fileId;
    ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .setFatcaW9(fatcaW9Data);
    _setFatcaW9Request.safeAdd(SetFatcaW9UseCaseParams(
        fatcaW9Data: fatcaW9Data,
        declarationSelected: _declarationSelected.value,
        verifyInfoDeclarationSelected: _verifyInfoDeclarationSelected.value));
  }

  void setFatcaw8Response(BuildContext context) {
    FatcaW8Data fatcaW8Data = ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .getFatcaW8Data;

    fatcaW8Data.signatureId = fileId;
    ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .setFatcaW8(fatcaW8Data);
    _setFatcaW8Request.safeAdd(SetFatcaW8UseCaseParams(
        fatcaW8Data: fatcaW8Data,
        declarationSelected: _declarationSelected.value,
        verifyInfoDeclarationSelected: _verifyInfoDeclarationSelected.value));
  }

  void setFatcaResponse(BuildContext context) {
    TaxPayerTypeEnum taxPayerTypeEnum = ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .taxPayerType;

    if (taxPayerTypeEnum == TaxPayerTypeEnum.W8) {
      setFatcaw8Response(context);
    } else if (taxPayerTypeEnum == TaxPayerTypeEnum.W9) {
      setFatcaw9Response(context);
    }
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
