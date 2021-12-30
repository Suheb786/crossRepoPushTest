import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/usecase/payment/get_account_by_alias_usecase.dart';
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

  GetAccountByAliasUseCase _getAccountByAliasUseCase;

  UploadDocumentUseCase _uploadDocumentUseCase;

  TextEditingController ibanOrMobileController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();

  bool? dropDownEnabled = true;

  String selectedProfile = '';

  ScrollController scrollController = ScrollController();

  BehaviorSubject<String> _uploadProfilePhotoResponse = BehaviorSubject.seeded(
      "");

  Stream<String> get uploadProfilePhotoStream =>
      _uploadProfilePhotoResponse.stream;

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject =
  BehaviorSubject.seeded('');

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest =
      PublishSubject();

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  PublishSubject<GetAccountByAliasUseCaseParams> _getAccountByAliasRequest =
      PublishSubject();

  final GlobalKey<AppTextFieldState> ibanOrMobileKey =
  GlobalKey(debugLabel: "ibanOrMobileNo");

  final GlobalKey<AppTextFieldState> purposeKey =
  GlobalKey(debugLabel: "purpose");

  final GlobalKey<AppTextFieldState> purposeDetailKey =
  GlobalKey(debugLabel: "purposeDetails");

  bool addContact = false;

  PublishSubject<RequestFromNewRecipientUseCaseParams>
  _requestFromNewRecipientRequest = PublishSubject();

  PublishSubject<Resource<RequestToPayContentResponse>>
  _requestFromNewRecipientResponse = PublishSubject();

  BehaviorSubject<Resource<GetAccountByAliasContentResponse>>
  _getAccountByAliasResponse = BehaviorSubject();

  Stream<Resource<GetAccountByAliasContentResponse>>
  get getAccountByAliasResponseStream => _getAccountByAliasResponse.stream;

  Stream<Resource<RequestToPayContentResponse>>
  get requestFromNewRecipientResponseStream =>
      _requestFromNewRecipientResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  PublishSubject<String> _showAccountDetailSubject = PublishSubject();

  Stream<String> get showAccountDetailStream =>
      _showAccountDetailSubject.stream;

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;

  RequestFromNewRecipientViewModel(this._useCase, this._uploadDocumentUseCase,
      this._getAccountByAliasUseCase) {
    _requestFromNewRecipientRequest.listen((value) {
      updateLoader();
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _requestFromNewRecipientResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadProfilePhotoResponse.safeAdd(event.data!);
      });
    });

    _getAccountByAliasRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getAccountByAliasUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountByAliasResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          dbtrBic = event.data!.getAccountByAliasContent!.bic;
          dbtrName = event.data!.getAccountByAliasContent!.name;
          dbtrAcct = event.data!.getAccountByAliasContent!.acciban;
          print("got value: ${event.data!.getAccountByAliasContent!.bic}");
          _showAccountDetailSubject
              .safeAdd(event.data!.getAccountByAliasContent!.name);
        }
      });
    });
  }

  void getAccountByAlias(String value, String currency) {
    _getAccountByAliasRequest.safeAdd(
        GetAccountByAliasUseCaseParams(value: value, currency: currency));
  }

  void requestFromNewRecipient(BuildContext context) {
    _requestFromNewRecipientRequest
        .safeAdd(RequestFromNewRecipientUseCaseParams(
        ibanOrMobile: ibanOrMobileController.text,
        purpose: purposeController.text,
        purposeDetail: purposeDetailController.text,
        amount: int.parse(ProviderScope
            .containerOf(context)
            .read(requestMoneyViewModelProvider)
            .currentPinValue),
        dbtrBic: dbtrBic ?? "",
        dbtrAcct: dbtrAcct ?? "",
        dbtrName: dbtrName ?? "",
        isFriend: addContact,
        image: _uploadProfilePhotoResponse.value
    ));
  }

  void updatePurpose(String value) {
    purposeController.text = value;
  }

  void updatePurposeDetail(String value) {
    purposeDetailController.text = value;
  }

  void validateAddress() {}

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void removeImage() {
    _selectedImageSubject.value = "";
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _requestFromNewRecipientRequest.close();
    _requestFromNewRecipientResponse.close();
    super.dispose();
  }
}
