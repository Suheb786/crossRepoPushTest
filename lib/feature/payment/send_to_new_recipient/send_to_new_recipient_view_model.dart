import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:domain/usecase/payment/send_to_new_recipient_usecase.dart';
import 'package:domain/usecase/payment/transfer_verify_usecase.dart';
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

class SendToNewRecipientViewModel extends BasePageViewModel {
  SendToNewRecipientUseCase _useCase;

  final CheckSendMoneyUseCase _checkSendMoneyUseCase;

  final TransferVerifyUseCase _transferVerifyUseCase;

  UploadDocumentUseCase _uploadDocumentUseCase;

  GetPurposeUseCase _getPurposeUseCase;

  ScrollController scrollController = ScrollController();

  TextEditingController ibanOrMobileController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();
  TextEditingController addNickNameController = TextEditingController();
  TextEditingController recipientAddressController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();

  bool? dropDownEnabled = true;
  String selectedProfile = '';

  List<Purpose> purposeList = [];

  List<PurposeDetail> purposeDetaiList = [];

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  String? addNickNameVal = "Add nickname";

  ///---------------Check send money recipient Details Visibility----------///

  PublishSubject<bool> _checkSendMoneyRecipientDetailsVisibilitySubject = PublishSubject();

  Stream<bool> get checkSendMoneyRecipientDetailsVisibilityStream =>
      _checkSendMoneyRecipientDetailsVisibilitySubject.stream;

  void showCheckSendMoneyRecipientDetailsVisibility(bool show) {
    _checkSendMoneyRecipientDetailsVisibilitySubject.safeAdd(show);
  }

  ///---------------Check send money recipient Details Visibility----------///

  CheckSendMoneyMessageEnum checkSendMoneyMessageEnum = CheckSendMoneyMessageEnum.NONE;

  PublishSubject<bool> _addNickNameSubject = PublishSubject();

  Stream<bool> get addNickNameStream => _addNickNameSubject.stream;

  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject.seeded(false);

  Stream<bool> get switchValue => _switchSubject.stream;

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();

  PublishSubject<GetPurposeUseCaseParams> _getPurposeRequest = PublishSubject();

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  final GlobalKey<AppTextFieldState> ibanOrMobileKey = GlobalKey(debugLabel: "ibanOrMobileNo");
  final GlobalKey<AppTextFieldState> recipientAddressKey = GlobalKey(debugLabel: "recipientAddress");
  final GlobalKey<AppTextFieldState> recipientNameKey = GlobalKey(debugLabel: "recipientName");
  final GlobalKey<AppTextFieldState> purposeKey = GlobalKey(debugLabel: "purpose");
  final GlobalKey<AppTextFieldState> purposeDetailKey = GlobalKey(debugLabel: "purposeDetails");

  PublishSubject<SendToNewRecipientUseCaseParams> _sendToNewRecipientRequest = PublishSubject();

  PublishSubject<Resource<bool>> _sendToNewRecipientResponse = PublishSubject();

  Stream<Resource<bool>> get sendToNewRecipientResponseStream => _sendToNewRecipientResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  TransferResponse transferResponse = TransferResponse();

  ///check send money request
  PublishSubject<CheckSendMoneyUseCaseParams> _checkSendMoneyRequest = PublishSubject();

  ///check send money response
  PublishSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse = PublishSubject();

  ///check send money response stream
  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneyStream => _checkSendMoneyResponse.stream;

  PublishSubject<bool> _showNameVisibilityRequest = PublishSubject();

  Stream<bool> get showNameVisibilityStream => _showNameVisibilityRequest.stream;

  void showNameVisibility(bool value) {
    _showNameVisibilityRequest.safeAdd(value);
  }

  PublishSubject<Resource<PurposeResponse>> _getPurposeResponse = PublishSubject();

  Stream<Resource<PurposeResponse>> get getPurposeResponseStream => _getPurposeResponse.stream;

  bool isFriend = false;

  num? limit;

  ///transfer verify request
  PublishSubject<TransferVerifyUseCaseParams> _transferVerifyRequest = PublishSubject();

  ///transfer verify response
  PublishSubject<Resource<bool>> _transferVerifyResponse = PublishSubject();

  ///transfer verify response stream
  Stream<Resource<bool>> get transferVerifyStream => _transferVerifyResponse.stream;

  SendToNewRecipientViewModel(this._useCase, this._uploadDocumentUseCase, this._checkSendMoneyUseCase,
      this._transferVerifyUseCase, this._getPurposeUseCase) {
    _sendToNewRecipientRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value)).asFlow().listen((event) {
        _sendToNewRecipientResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          getError(event);
        }
      });
    });
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _uploadProfilePhotoResponse.safeAdd(event.data!);
      });
    });

    _checkSendMoneyRequest.listen((value) {
      RequestManager(value, createCall: () => _checkSendMoneyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkSendMoneyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          transferResponse = event.data!.checkSendMoneyContent!.transferResponse!;
          // _showNameVisibilityRequest.safeAdd(true);
          getPurpose(event.data!.checkSendMoneyContent!.transferResponse!.toAccount!, "TransferI");
        }
      });
    });

    _transferVerifyRequest.listen((value) {
      RequestManager(value, createCall: () => _transferVerifyUseCase.execute(params: value))
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
          purposeList.addAll(event.data!.content!.transferPurposeResponse!.purposes!);
          print("got purposeList: $purposeList");
        }
      });
    });
  }

  void updateNickName(bool value) {
    _addNickNameSubject.safeAdd(value);
  }

  void getPurpose(String toAccount, String transferType) {
    _getPurposeRequest.safeAdd(GetPurposeUseCaseParams(
        toAccount: toAccount, transferType: transferType, detCustomerType: "", type: ""));
  }

  void updatePurposeDetaiList(List<PurposeDetail> list) {
    purposeDetailController.clear();
    purposeDetaiList.clear();
    purposeDetaiList.addAll(list);
  }

  void checkSendMoney({required String iban, required String amount}) {
    _checkSendMoneyRequest
        .safeAdd(CheckSendMoneyUseCaseParams(toAccount: iban, toAmount: double.parse(amount)));
  }

  void sendToNewRecipient(BuildContext context) {
    _sendToNewRecipientRequest.safeAdd(SendToNewRecipientUseCaseParams(
        ibanOrMobile: ibanOrMobileController.text,
        purpose: purposeController.text,
        nickName: addNickNameController.text.isEmpty ? "" : addNickNameController.text,
        isFriend: isFriend,
        purposeDetail: purposeDetailController.text,
        amount:
        double.parse(ProviderScope
            .containerOf(context)
            .read(sendMoneyViewModelProvider)
            .currentPinValue),
        limit: limit,
        messageEnum: checkSendMoneyMessageEnum,
        recipientName: recipientNameController.text,
        recipientAddress: recipientAddressController.text));
  }

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest.safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updatePurpose(Purpose value) {
    purposeController.text = value.labelEn!;
    purpose = value;
  }

  void updatePurposeDetail(PurposeDetail value) {
    purposeDetailController.text = value.labelEn!;
    purposeDetail = value;
    limit = value.limit!;
  }

  void removeImage() {
    _selectedImageSubject.value = "";
  }

  void verifyTransfer({required String amount}) {
    _transferVerifyRequest.safeAdd(TransferVerifyUseCaseParams(amount: amount));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_IBAN_MOBILE:
        ibanOrMobileKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_RECIPIENT_NAME:
        recipientNameKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_RECIPIENT_ADDRESS:
        recipientAddressKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_PURPOSE:
        purposeKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_PURPOSE_DETAIL:
        purposeDetailKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _sendToNewRecipientRequest.close();
    _sendToNewRecipientResponse.close();
    _getPurposeRequest.close();
    _checkSendMoneyResponse.close();
    _checkSendMoneyRequest.close();
    _getPurposeResponse.close();
    super.dispose();
  }
}
