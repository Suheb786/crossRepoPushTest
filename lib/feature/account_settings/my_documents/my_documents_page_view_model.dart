import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/usecase/account/check_other_nationality_status_usecase.dart';
import 'package:domain/usecase/account_setting/my_documents/get_customer_doc_id_usecase.dart';
import 'package:domain/usecase/account_setting/my_documents/get_customer_document_usecase.dart';
import 'package:domain/usecase/account_setting/my_documents/my_documents_usecase.dart';
import 'package:domain/usecase/upload_doc/file_upload_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class MyDocumentsPageViewModel extends BasePageViewModel {
  final MyDocumentsUseCase _myDocumentsUseCase;

  ///SaveUploadDocumentsDocs usecase
  final UploadDocumentUseCase _uploadDocumentUseCase;

  ///check other nationality usecase
  final CheckOtherNationalityStatusUseCase _checkOtherNationalityStatusUseCase;

  final GetCustomerDocIdUseCase _getCustomerDocIdUseCase;

  final GetCustomerDocumentUseCase _getCustomerDocumentUseCase;

  ///upload individual document usecase
  final FileUploadUseCase _fileUploadUseCase;

  final TextEditingController addressController = TextEditingController(text: 'Home-Address.jpg');
  final TextEditingController incomeController = TextEditingController(text: 'Salam-Income.jpg');
  final TextEditingController additionalNationalityController = TextEditingController();

  final GlobalKey<AppTextFieldState> addressDocumentKey = GlobalKey(debugLabel: "addressDocument");
  final GlobalKey<AppTextFieldState> incomeDocumentKey = GlobalKey(debugLabel: "incomeDocument");
  final GlobalKey<AppTextFieldState> additionalNationalityKey =
      GlobalKey(debugLabel: "additionalNationality");

  ///documents
  PublishSubject<MyDocumentsUseCaseParams> _documentsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _documentsResponse = PublishSubject();

  Stream<Resource<bool>> get documentsStream => _documentsResponse.stream;

  ///upload income proof
  PublishSubject<UploadDocumentUseCaseParams> _uploadIncomePoofRequest = PublishSubject();

  PublishSubject<String> _uploadIncomePoofResponse = PublishSubject();

  Stream<String> get uploadIncomePoofStream => _uploadIncomePoofResponse.stream;

  ///is income document uploaded
  Stream<bool> get documentIncomeStream => _documentIncomeRequest.stream;

  PublishSubject<bool> _documentIncomeRequest = PublishSubject();

  ///upload address proof
  PublishSubject<UploadDocumentUseCaseParams> _uploadAddressPoofRequest = PublishSubject();

  PublishSubject<String> _uploadAddressPoofResponse = PublishSubject();

  Stream<String> get uploadAddressPoofStream => _uploadAddressPoofResponse.stream;

  ///is address document uploaded
  Stream<bool> get documentAddressStream => _documentAddressRequest.stream;

  PublishSubject<bool> _documentAddressRequest = PublishSubject();

  ///upload additional nationality  proof
  PublishSubject<UploadDocumentUseCaseParams> _additionalNationalityProofRequest = PublishSubject();

  PublishSubject<String> _additionalNationalityProofResponse = PublishSubject();

  Stream<String> get additionalNationalityProofStream => _additionalNationalityProofResponse.stream;

  ///is additional nationality document uploaded
  PublishSubject<bool> _documentNationalityRequest = PublishSubject();

  Stream<bool> get documentNationalityStream => _documentNationalityRequest.stream;

  ///check other nationality
  PublishSubject<CheckOtherNationalityStatusUseCaseParams> _checkOtherNationalityStatusRequest =
      PublishSubject();

  PublishSubject<Resource<CheckOtherNationalityResponse>> _checkOtherNationalityStatusResponse =
      PublishSubject();

  Stream<Resource<CheckOtherNationalityResponse>> get checkOtherNationalityStatusStream =>
      _checkOtherNationalityStatusResponse.stream;

  void checkOtherNationality() {
    _checkOtherNationalityStatusRequest.safeAdd(CheckOtherNationalityStatusUseCaseParams());
  }

  ///upload income proof
  String incomeProofDocumentId = '';
  PublishSubject<FileUploadUseCaseParams> _uploadIncomeProofDocumentRequest = PublishSubject();

  PublishSubject<Resource<FileUploadResponse>> _uploadIncomeProofDocumentResponse = PublishSubject();

  Stream<Resource<FileUploadResponse>> get uploadIncomeProofDocumentStream =>
      _uploadIncomeProofDocumentResponse.stream;

  ///upload address proof
  String addressProofDocumentId = '';
  PublishSubject<FileUploadUseCaseParams> _uploadAddressProofDocumentRequest = PublishSubject();

  PublishSubject<Resource<FileUploadResponse>> _uploadAddressProofDocumentResponse = PublishSubject();

  Stream<Resource<FileUploadResponse>> get uploadAddressProofDocumentStream =>
      _uploadAddressProofDocumentResponse.stream;

  ///upload other nationality proof
  String otherNationalityProofDocumentId = '';
  PublishSubject<FileUploadUseCaseParams> _uploadOtherNationalityProofDocumentRequest = PublishSubject();

  PublishSubject<Resource<FileUploadResponse>> _uploadOtherNationalityProofDocumentResponse =
      PublishSubject();

  Stream<Resource<FileUploadResponse>> get uploadOtherNationalityProofDocumentStream =>
      _uploadOtherNationalityProofDocumentResponse.stream;

  bool isOtherNationality = false;

  bool isIncomeDocumentUploaded = false;
  bool isAddressDocumentUploaded = false;
  bool isOtherNationalityDocumentUploaded = false;

  /// animated button visibility subject
  BehaviorSubject<bool> _showAnimatedButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showAnimatedButtonStream => _showAnimatedButtonSubject.stream;

  ///get customer document id
  PublishSubject<GetCustomerDocIdUseCaseParams> _getCustomerDocumentIdRequest = PublishSubject();

  ///get customer address document
  PublishSubject<GetCustomerDocumentUseCaseParams> _getCustomerAddressDocumentRequest = PublishSubject();

  // PublishSubject<Resource<GetCustomerDocumentResponse>>
  //     _getCustomerAddressDocumentResponse = PublishSubject();

  ///get customer income document
  PublishSubject<GetCustomerDocumentUseCaseParams> _getCustomerIncomeDocumentRequest = PublishSubject();

  // PublishSubject<Resource<GetCustomerDocumentResponse>>
  //     _getCustomerIncomeDocumentResponse = PublishSubject();

  MyDocumentsPageViewModel(
      this._myDocumentsUseCase,
      this._uploadDocumentUseCase,
      this._checkOtherNationalityStatusUseCase,
      this._fileUploadUseCase,
      this._getCustomerDocIdUseCase,
      this._getCustomerDocumentUseCase) {
    _documentsRequest.listen((value) {
      RequestManager(value, createCall: () => _myDocumentsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _documentsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _uploadIncomePoofRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadIncomePoofResponse.safeAdd(event.data!);
      });
    });

    _uploadAddressPoofRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadAddressPoofResponse.safeAdd(event.data!);
      });
    });

    _additionalNationalityProofRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _additionalNationalityProofResponse.safeAdd(event.data!);
      });
    });

    _uploadIncomeProofDocumentRequest.listen((value) {
      RequestManager(value, createCall: () => _fileUploadUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadIncomeProofDocumentResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _uploadAddressProofDocumentRequest.listen((value) {
      RequestManager(value, createCall: () => _fileUploadUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadAddressProofDocumentResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _uploadOtherNationalityProofDocumentRequest.listen((value) {
      RequestManager(value, createCall: () => _fileUploadUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadOtherNationalityProofDocumentResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _checkOtherNationalityStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _checkOtherNationalityStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _checkOtherNationalityStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getCustomerDocumentIdRequest.listen((value) {
      RequestManager(value, createCall: () => _getCustomerDocIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _getCustomerAddressDocumentRequest.safeAdd(GetCustomerDocumentUseCaseParams(
              docId: event.data!.getCustomerDocIdContentData!.getCustomerDocIdContent!.proofOfAddress!));

          _getCustomerIncomeDocumentRequest.safeAdd(GetCustomerDocumentUseCaseParams(
              docId: event.data!.getCustomerDocIdContentData!.getCustomerDocIdContent!.proofOfIncome!));
        }
      });
    });

    _getCustomerAddressDocumentRequest.listen((value) {
      RequestManager(value, createCall: () => _getCustomerDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          addressController.text = event.data!.getCustomerDocumentContent!.doc!;
        }
      });
    });

    _getCustomerIncomeDocumentRequest.listen((value) {
      RequestManager(value, createCall: () => _getCustomerDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          incomeController.text = event.data!.getCustomerDocumentContent!.doc!;
        }
      });
    });

    //getCustomerDocId();

    ///commented as not required now
    //checkOtherNationality();
  }

  void uploadIncomeDocument(DocumentTypeEnum type, {String cameraPhotoFile = ""}) {
    _uploadIncomePoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type, cameraPhotoFile: cameraPhotoFile));
  }

  void updateIncomeDocumentField(String value) {
    print('income value:--->$value');
    incomeController.text = value.split("/").last;
    //uploadIncomeProof(value);
    updateIncomeUploadedStream(true);
  }

  void updateIncomeUploadedStream(bool value) {
    _documentIncomeRequest.safeAdd(value);
  }

  void uploadAdditionalNationalityDocument(DocumentTypeEnum type, {String cameraPhotoFile = ""}) {
    _additionalNationalityProofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type, cameraPhotoFile: cameraPhotoFile));
  }

  void updateAdditionalNationalityUploadedStream(bool value) {
    _documentNationalityRequest.safeAdd(value);
  }

  void updateAdditionalNationalityField(String value) {
    additionalNationalityController.text = value.split("/").last;
    uploadOtherNationalityProof(value);
    updateAdditionalNationalityUploadedStream(true);
  }

  void uploadAddressDocument(DocumentTypeEnum type, {String cameraPhotoFile = ""}) {
    _uploadAddressPoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type, cameraPhotoFile: cameraPhotoFile));
  }

  void updateAddressDocumentField(String value) {
    addressController.text = value.split("/").last;
    //uploadAddressProof(value);
    updateAddressUploadedStream(true);
  }

  void updateAddressUploadedStream(bool value) {
    _documentAddressRequest.safeAdd(value);
  }

  void getCustomerDocId() {
    _getCustomerDocumentIdRequest.safeAdd(GetCustomerDocIdUseCaseParams());
  }

  ///uncomment once api integration
  // void validateDocuments() {
  //   _documentsRequest.safeAdd(SendDocumentsUseCaseParams(
  //       incomeProof: incomeProofDocumentId,
  //       addressProof: addressProofDocumentId,
  //       isOtherNationality: isOtherNationality,
  //       nationalityProof: otherNationalityProofDocumentId));
  // }

  void validateDocuments() {
    _documentsRequest.safeAdd(MyDocumentsUseCaseParams(
        incomeProof: incomeController.text,
        addressProof: addressController.text,
        isOtherNationality: isOtherNationality,
        nationalityProof: additionalNationalityController.text));
  }

  void uploadIncomeProof(String image) {
    _uploadIncomeProofDocumentRequest.safeAdd(FileUploadUseCaseParams(path: image));
  }

  void uploadAddressProof(String image) {
    _uploadAddressProofDocumentRequest.safeAdd(FileUploadUseCaseParams(path: image));
  }

  void uploadOtherNationalityProof(String image) {
    _uploadOtherNationalityProofDocumentRequest.safeAdd(FileUploadUseCaseParams(path: image));
  }

  void validateFields() {
    bool isValid = false;
    if (isOtherNationality) {
      if (incomeController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          additionalNationalityController.text.isNotEmpty) {
        isValid = true;
      }
    } else if (incomeController.text.isNotEmpty && addressController.text.isNotEmpty) {
      isValid = true;
    }
    _showAnimatedButtonSubject.safeAdd(isValid);
  }

  @override
  void dispose() {
    _documentsRequest.close();
    _uploadIncomePoofRequest.close();
    _uploadAddressPoofRequest.close();
    _documentAddressRequest.close();
    _documentIncomeRequest.close();
    _additionalNationalityProofRequest.close();
    _additionalNationalityProofResponse.close();
    _documentNationalityRequest.close();
    _checkOtherNationalityStatusRequest.close();
    _checkOtherNationalityStatusResponse.close();
    _uploadIncomeProofDocumentRequest.close();
    _uploadIncomeProofDocumentResponse.close();
    _uploadAddressProofDocumentRequest.close();
    _uploadAddressProofDocumentResponse.close();
    _uploadOtherNationalityProofDocumentRequest.close();
    _uploadOtherNationalityProofDocumentResponse.close();
    _showAnimatedButtonSubject.close();
    super.dispose();
  }
}
