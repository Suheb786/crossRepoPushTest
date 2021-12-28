import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/send_to_new_recipient_usecase.dart';
import 'package:domain/usecase/payment/transfer_verify_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SendToNewRecipientViewModel extends BasePageViewModel {
  SendToNewRecipientUseCase _useCase;

  final CheckSendMoneyUseCase _checkSendMoneyUseCase;

  final TransferVerifyUseCase _transferVerifyUseCase;

  UploadDocumentUseCase _uploadDocumentUseCase;

  TextEditingController ibanOrMobileController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();

  bool? dropDownEnabled = true;
  String selectedProfile = '';

  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream =>
      _uploadProfilePhotoResponse.stream;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject.seeded(false);

  Stream<bool> get switchValue => _switchSubject.stream;

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject =
      BehaviorSubject.seeded('');

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest =
      PublishSubject();

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  final GlobalKey<AppTextFieldState> ibanOrMobileKey =
      GlobalKey(debugLabel: "ibanOrMobileNo");

  final GlobalKey<AppTextFieldState> purposeKey =
      GlobalKey(debugLabel: "purpose");

  final GlobalKey<AppTextFieldState> purposeDetailKey =
      GlobalKey(debugLabel: "purposeDetails");

  PublishSubject<SendToNewRecipientUseCaseParams> _sendToNewRecipientRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _sendToNewRecipientResponse = PublishSubject();

  Stream<Resource<bool>> get sendToNewRecipientResponseStream =>
      _sendToNewRecipientResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  TransferResponse transferResponse = TransferResponse();

  ///check send money request
  PublishSubject<CheckSendMoneyUseCaseParams> _checkSendMoneyRequest =
      PublishSubject();

  ///check send money response
  PublishSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse =
      PublishSubject();

  ///check send money response stream
  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneyStream =>
      _checkSendMoneyResponse.stream;

  PublishSubject<bool> _showNameVisibilityRequest = PublishSubject();

  Stream<bool> get showNameVisibilityStream =>
      _showNameVisibilityRequest.stream;

  bool isFriend = false;

  ///transfer verify request
  PublishSubject<TransferVerifyUseCaseParams> _transferVerifyRequest =
      PublishSubject();

  ///transfer verify response
  PublishSubject<Resource<bool>> _transferVerifyResponse = PublishSubject();

  ///transfer verify response stream
  Stream<Resource<bool>> get transferVerifyStream =>
      _transferVerifyResponse.stream;

  SendToNewRecipientViewModel(this._useCase, this._uploadDocumentUseCase,
      this._checkSendMoneyUseCase, this._transferVerifyUseCase) {
    _sendToNewRecipientRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _sendToNewRecipientResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
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

    _checkSendMoneyRequest.listen((value) {
      RequestManager(value,
              createCall: () => _checkSendMoneyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkSendMoneyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          transferResponse =
              event.data!.checkSendMoneyContent!.transferResponse!;
          _showNameVisibilityRequest.safeAdd(true);
        }
      });
    });

    _transferVerifyRequest.listen((value) {
      RequestManager(value,
              createCall: () => _transferVerifyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferVerifyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void checkSendMoney({required String iban, required String amount}) {
    _checkSendMoneyRequest.safeAdd(CheckSendMoneyUseCaseParams(
        toAccount: iban, toAmount: int.parse(amount)));
  }

  void sendToNewRecipient() {
    _sendToNewRecipientRequest.safeAdd(SendToNewRecipientUseCaseParams(
        ibanOrMobile: ibanOrMobileController.text,
        purpose: purposeController.text,
        purposeDetail: purposeDetailController.text));
  }

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updatePurpose(String value) {
    purposeController.text = value;
  }

  void updatePurposeDetail(String value) {
    purposeDetailController.text = value;
  }

  void removeImage() {
    _selectedImageSubject.value = "";
  }

  void verifyTransfer() {
    print('isFrient--->$isFriend');
    _transferVerifyRequest.safeAdd(TransferVerifyUseCaseParams());
  }

  void validateAddress() {}

  @override
  void dispose() {
    _showButtonSubject.close();
    _sendToNewRecipientRequest.close();
    _sendToNewRecipientResponse.close();
    super.dispose();
  }
}
