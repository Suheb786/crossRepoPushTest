import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/model/upload_document/save_upload_document_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/usecase/account/check_other_nationality_status_usecase.dart';
import 'package:domain/usecase/bank_smart/create_account_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_usecase.dart';
import 'package:domain/usecase/bank_smart/remove_debit_lock_usecase.dart';
import 'package:domain/usecase/upload_doc/file_upload_usecase.dart';
import 'package:domain/usecase/upload_doc/send_documents_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:domain/usecase/user/check_customer_status_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class UploadDocumentsPageViewModel extends BasePageViewModel {
  final SendDocumentsUseCase _documentsUseCase;

  ///SaveUploadDocumentsDocs usecase
  final UploadDocumentUseCase _uploadDocumentUseCase;

  ///check other nationality usecase
  final CheckOtherNationalityStatusUseCase _checkOtherNationalityStatusUseCase;

  ///upload individual document usecase
  final FileUploadUseCase _fileUploadUseCase;

  ///remove debit credit lock
  final RemoveDebitLockUseCase _removeDebitLockUseCase;

  ///check customer status
  final CheckCustomerStatusUseCase _checkCustomerStatusUseCase;

  ///get account
  final GetAccountUseCase _getAccountUseCase;

  bool isDocumentSkipped = false;

  ///create account
  final CreateAccountUseCase _createAccountUseCase;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController additionalNationalityController = TextEditingController();

  // GlobalKey<AppTextFieldState> addressDocumentKey =
  //     new GlobalKey(debugLabel: "addressDocument");
  // GlobalKey<AppTextFieldState> incomeDocumentKey =
  //     new GlobalKey(debugLabel: "incomeDocument");
  // GlobalKey<AppTextFieldState> additionalNationalityKey =
  //     new GlobalKey(debugLabel: "additionalNationality");

  ///documents
  PublishSubject<SendDocumentsUseCaseParams> _documentsRequest = PublishSubject();

  PublishSubject<Resource<SaveUploadDocumentResponse>> _documentsResponse = PublishSubject();

  Stream<Resource<SaveUploadDocumentResponse>> get documentsStream => _documentsResponse.stream;

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

  bool isSecondNextPage = false;

  bool isIncomeDocumentUploaded = false;
  bool isAddressDocumentUploaded = false;
  bool isOtherNationalityDocumentUploaded = false;

  /// animated button visibility subject
  BehaviorSubject<bool> _showAnimatedButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showAnimatedButtonStream => _showAnimatedButtonSubject.stream;

  ///remove debit lock
  PublishSubject<RemoveDebitLockUseCaseParams> _removeDebitLockRequest = PublishSubject();

  PublishSubject<Resource<bool>> _removeDebitLockResponse = PublishSubject();

  Stream<Resource<bool>> get removeDebitLockStream => _removeDebitLockResponse.stream;

  ///User Status subject holder
  PublishSubject<CheckCustomerStatusUseCaseParams> _checkCustomerStatusRequest = PublishSubject();

  ///User Status response holder
  PublishSubject<Resource<CustomerStatus>> _checkCustomerStatusResponse = PublishSubject();

  ///User Status stream
  Stream<Resource<CustomerStatus>> get customerStatusStream => _checkCustomerStatusResponse.stream;

  ///get Account subject holder
  PublishSubject<GetAccountUseCaseParams> _getAccountRequest = PublishSubject();

  ///get Account response holder
  PublishSubject<Resource<GetAccountResponse>> _getAccountResponse = PublishSubject();

  ///get Account stream
  Stream<Resource<GetAccountResponse>> get getAccountStream => _getAccountResponse.stream;

  ///create Account subject holder
  PublishSubject<CreateAccountUseCaseParams> _createAccountRequest = PublishSubject();

  ///create Account response holder
  PublishSubject<Resource<CreateAccountResponse>> _createAccountResponse = PublishSubject();

  ///create Account stream
  Stream<Resource<CreateAccountResponse>> get createAccountStream => _createAccountResponse.stream;

  UploadDocumentsPageViewModel(
      this._documentsUseCase,
      this._uploadDocumentUseCase,
      this._checkOtherNationalityStatusUseCase,
      this._fileUploadUseCase,
      this._removeDebitLockUseCase,
      this._checkCustomerStatusUseCase,
      this._getAccountUseCase,
      this._createAccountUseCase) {
    _documentsRequest.listen((value) {
      RequestManager(value, createCall: () => _documentsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
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
        updateLoader();
        if (event.data != null) {
          _uploadIncomePoofResponse.safeAdd(event.data!);
        }
      });
    });

    _uploadAddressPoofRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.data != null) {
          _uploadAddressPoofResponse.safeAdd(event.data!);
        }
      });
    });

    _additionalNationalityProofRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.data != null) {
          _additionalNationalityProofResponse.safeAdd(event.data!);
        }
      });
    });

    _uploadIncomeProofDocumentRequest.listen((value) {
      RequestManager(value, createCall: () => _fileUploadUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
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
        updateLoader();
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
        updateLoader();
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
        updateLoader();
        _checkOtherNationalityStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _removeDebitLockRequest.listen((value) {
      RequestManager(value, createCall: () => _removeDebitLockUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _removeDebitLockResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _checkCustomerStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _checkCustomerStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkCustomerStatusResponse.add(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _getAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _getAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _createAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _createAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createAccountResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    ///commented as not required now
    //checkOtherNationality();
  }

  void uploadIncomeDocument(DocumentTypeEnum type, {String cameraPhotoFile = ""}) {
    _uploadIncomePoofRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type, cameraPhotoFile: cameraPhotoFile));
  }

  void updateIncomeDocumentField(String value) {
    incomeController.text = value.split("/").last;
    uploadIncomeProof(value);
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

  void getAccount() {
    _getAccountRequest.safeAdd(GetAccountUseCaseParams());
  }

  void createAccount(CustomerAccountDetails accountDetails, CustomerInformation customerInformation) {
    _createAccountRequest.safeAdd(
        CreateAccountUseCaseParams(accountDetails: accountDetails, customerInformation: customerInformation));
  }

  void updateAddressDocumentField(String value) {
    addressController.text = value.split("/").last;
    uploadAddressProof(value);
    updateAddressUploadedStream(true);
  }

  void updateAddressUploadedStream(bool value) {
    _documentAddressRequest.safeAdd(value);
  }

  void validateDocuments() {
    _documentsRequest.safeAdd(SendDocumentsUseCaseParams(
        incomeProof: incomeProofDocumentId,
        addressProof: addressProofDocumentId,
        isOtherNationality: isOtherNationality,
        nationalityProof: otherNationalityProofDocumentId));
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
      if (isIncomeDocumentUploaded && isAddressDocumentUploaded && isOtherNationalityDocumentUploaded) {
        isValid = true;
      }
    } else if (isIncomeDocumentUploaded && isAddressDocumentUploaded) {
      isValid = true;
    }
    _showAnimatedButtonSubject.safeAdd(isValid);
  }

  ///remove debit lock
  void removeDebitLock() {
    _removeDebitLockRequest.safeAdd(RemoveDebitLockUseCaseParams());
  }

  void getCustomerStatus() {
    _checkCustomerStatusRequest.safeAdd(CheckCustomerStatusUseCaseParams());
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
    _removeDebitLockRequest.close();
    _removeDebitLockResponse.close();
    super.dispose();
  }
}
