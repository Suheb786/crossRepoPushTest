import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/usecase/payment/get_account_by_alias_usecase.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:domain/usecase/payment/request_from_new_recipient_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RequestFromNewRecipientViewModel extends BasePageViewModel {
  RequestFromNewRecipientUseCase _useCase;
  Account selectedAccount = Account();
  GetAccountByAliasUseCase _getAccountByAliasUseCase;

  UploadDocumentUseCase _uploadDocumentUseCase;

  GetPurposeUseCase _getPurposeUseCase;

  TextEditingController ibanOrMobileController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();
  TextEditingController addNickNameController = TextEditingController();

  bool? dropDownEnabled = true;

  String? addNickNameVal = "Add nickname";

  String selectedProfile = '';

  num? limit;

  ScrollController scrollController = ScrollController();

  BehaviorSubject<String> _uploadProfilePhotoResponse = BehaviorSubject.seeded("");

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();

  PublishSubject<GetPurposeUseCaseParams> _getPurposeRequest = PublishSubject();

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  PublishSubject<GetAccountByAliasUseCaseParams> _getAccountByAliasRequest = PublishSubject();

  final GlobalKey<AppTextFieldState> ibanOrMobileKey = GlobalKey(debugLabel: "ibanOrMobileNo");

  final GlobalKey<AppTextFieldState> purposeKey = GlobalKey(debugLabel: "purpose");

  final GlobalKey<AppTextFieldState> purposeDetailKey = GlobalKey(debugLabel: "purposeDetails");

  bool addContact = false;

  List<Purpose> purposeList = [];

  List<PurposeDetail> purposeDetailList = [];

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  PublishSubject<RequestFromNewRecipientUseCaseParams> _requestFromNewRecipientRequest = PublishSubject();

  PublishSubject<Resource<RequestToPayContentResponse>> _requestFromNewRecipientResponse = PublishSubject();

  PublishSubject<Resource<PurposeResponse>> _getPurposeResponse = PublishSubject();

  Stream<Resource<PurposeResponse>> get getPurposeResponseStream => _getPurposeResponse.stream;

  BehaviorSubject<Resource<GetAccountByAliasContentResponse>> _getAccountByAliasResponse = BehaviorSubject();

  Stream<Resource<GetAccountByAliasContentResponse>> get getAccountByAliasResponseStream =>
      _getAccountByAliasResponse.stream;

  BehaviorSubject<bool> _addNickNameSubject = BehaviorSubject();

  Stream<bool> get addNickNameStream => _addNickNameSubject.stream;

  Stream<Resource<RequestToPayContentResponse>> get requestFromNewRecipientResponseStream =>
      _requestFromNewRecipientResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  PublishSubject<String> _showAccountDetailSubject = PublishSubject();

  Stream<String> get showAccountDetailStream => _showAccountDetailSubject.stream;

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;
  String? type;
  String? detCustomerType;
  String? dbtrSurname;
  String? addressCity;
  String? addressCountry;

  RequestFromNewRecipientViewModel(
      this._useCase, this._uploadDocumentUseCase, this._getAccountByAliasUseCase, this._getPurposeUseCase) {
    _requestFromNewRecipientRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _requestFromNewRecipientResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadProfilePhotoResponse.safeAdd(event.data!);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _getAccountByAliasRequest.listen((value) {
      RequestManager(value, createCall: () => _getAccountByAliasUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountByAliasResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          purposeList = [];
          purposeDetailList = [];
          purposeController.clear();
          purposeDetailController.clear();
          _showAccountDetailSubject.safeAdd("");
        } else if (event.status == Status.SUCCESS) {
          dbtrBic = event.data?.getAccountByAliasContent?.bic;
          dbtrName = event.data?.getAccountByAliasContent?.name;
          dbtrAcct = event.data?.getAccountByAliasContent?.acciban;
          type = event.data?.getAccountByAliasContent?.type;
          detCustomerType = event.data?.getAccountByAliasContent?.detCustomerType;
          dbtrSurname = event.data?.getAccountByAliasContent?.surname;
          addressCity = event.data?.getAccountByAliasContent?.addressCity;
          addressCountry = event.data?.getAccountByAliasContent?.addressCountry;
          _showAccountDetailSubject.safeAdd(event.data?.getAccountByAliasContent?.name);
          getPurpose(dbtrAcct ?? '', "RTP", event.data?.getAccountByAliasContent?.detCustomerType ?? '',
              event.data?.getAccountByAliasContent?.type ?? '');
        }
      });
    });

    _getPurposeRequest.listen((value) {
      RequestManager(value, createCall: () => _getPurposeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPurposeResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          purposeList.clear();
          purposeList.addAll(event.data?.content?.transferPurposeResponse?.purposes ?? []);
        }
      });
    });
  }

  void updateNickName(bool value) {
    _addNickNameSubject.safeAdd(value);
  }

  void getPurpose(String toAccount, String transferType, String detCustomerType, String type) {
    _getPurposeRequest.safeAdd(GetPurposeUseCaseParams(
        toAccount: toAccount, transferType: transferType, type: type, detCustomerType: detCustomerType));
  }

  void getAccountByAlias(String value, String currency) {
    _getAccountByAliasRequest.safeAdd(GetAccountByAliasUseCaseParams(
        fromAccount: selectedAccount.accountNo, value: value, currency: currency, beneficiaryId: ''));
  }

  void requestFromNewRecipient(BuildContext context) {
    _requestFromNewRecipientRequest.safeAdd(RequestFromNewRecipientUseCaseParams(
        fromAccount: selectedAccount.accountNo,
        ibanOrMobile: ibanOrMobileController.text,
        purpose: purposeController.text,
        purposeDetail: purposeDetailController.text,
        amount: double.parse(
            ProviderScope.containerOf(context).read(requestMoneyViewModelProvider).currentPinValue),
        limit: limit,
        dbtrBic: dbtrBic ?? "",
        dbtrAcct: dbtrAcct ?? "",
        dbtrName: dbtrName ?? "",
        isFriend: addContact,
        image: selectedProfile,
        purposeCode: purpose?.code ?? "",
        purposeDetailCode: purposeDetail?.strCode ?? "",
        nickName: addContact ? (addNickNameController.text.isEmpty ? "" : addNickNameController.text) : '',
        type: type,
        detCustomerType: detCustomerType,
        alias: ibanOrMobileController.text,
        dbtrSurname: dbtrSurname,
        addressCity: addressCity,
        addressCountry: addressCountry));
  }

  validateField() {
    if (ibanOrMobileController.text.isNotEmpty &&
        purposeController.text.isNotEmpty &&
        purposeDetailController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void updatePurpose(Purpose value) {
    purpose = value;
    purposeController.text = value.labelEn ?? '';
  }

  void updatePurposeDetailList(List<PurposeDetail> purposeDetail) {
    purposeDetailController.clear();
    purposeDetailList.clear();
    purposeDetailList.addAll(purposeDetail);
  }

  void updatePurposeDetail(PurposeDetail value) {
    purposeDetailController.text = value.labelEn ?? '';
    purposeDetail = value;
    limit = value.limit ?? 0.0;
  }

  void validateAddress() {}

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void uploadProfilePhoto(DocumentTypeEnum type, {String cameraPhotoFile = ""}) {
    _uploadProfilePhotoRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type, cameraPhotoFile: cameraPhotoFile));
  }

  void removeImage() {
    _selectedImageSubject.value = "";
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _requestFromNewRecipientRequest.close();
    _requestFromNewRecipientResponse.close();
    _getPurposeResponse.close();
    _getPurposeRequest.close();
    _uploadProfilePhotoResponse.close();
    _getAccountByAliasResponse.close();
    _getAccountByAliasRequest.close();
    super.dispose();
  }
}
