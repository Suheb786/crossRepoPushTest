import 'dart:developer';

import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_usecase.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/get_account_by_alias_usecase.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/subjects.dart';

class AddBeneficiaryFormPageViewModel extends BasePageViewModel {
  final CheckSendMoneyUseCase _checkSendMoneyUseCase;
  final AddBeneficiaryUseCase addContactIBANuseCase;
  final GetPurposeUseCase getPurposeUseCase;
  final GetAccountByAliasUseCase _getAccountByAliasUseCase;

  List<Purpose> purposeList = [];

  List<PurposeDetail> purposeDetailList = [];

  TransferResponse transferResponse = TransferResponse();

  CheckSendMoneyMessageEnum checkSendMoneyMessageEnum = CheckSendMoneyMessageEnum.NONE;

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  num? limit;

  ///--------------------------keys-valiables-------------------------------------///
  final GlobalKey<AppTextFieldState> nameKey = GlobalKey(debugLabel: "name");
  final GlobalKey<AppTextFieldState> ibanORaccountORmobileORaliasKey =
      GlobalKey(debugLabel: "ibanORaccountORmobileORalias");

  final GlobalKey<AppTextFieldState> purposeKey = GlobalKey(debugLabel: "purpose");
  final GlobalKey<AppTextFieldState> purposeDetailKey = GlobalKey(debugLabel: "purposeDetails");

  ///--------------------------textEditing-controllers-------------------------------------///
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ibanOrMobileController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();

  ///--------------------------send money request-------------------------------------///
  PublishSubject<CheckSendMoneyUseCaseParams> _checkSendMoneyRequest = PublishSubject();
  PublishSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse = PublishSubject();

  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneyStream => _checkSendMoneyResponse.stream;

  ///--------------------------request money request-------------------------------------///
  PublishSubject<GetAccountByAliasUseCaseParams> _getAccountByAliasRequest = PublishSubject();
  BehaviorSubject<Resource<GetAccountByAliasContentResponse>> _getAccountByAliasResponse = BehaviorSubject();

  Stream<Resource<GetAccountByAliasContentResponse>> get getAccountByAliasResponseStream =>
      _getAccountByAliasResponse.stream;

  ///--------------------------formField-subject-------------------------------------///

  BehaviorSubject<String> formFieldSubject = BehaviorSubject.seeded("");

  ///--------------------------animated-button-subject-------------------------------------///
  ///
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  ///--------------------------addContact-subject-------------------------------------///

  PublishSubject<AddContactIBANuseCaseParams> addcontactIBANuseCaseRequest = PublishSubject();
  PublishSubject<Resource<bool>> addcontactIBANuseCaseResponse = PublishSubject();

  Stream<Resource<bool>> get addcontactIBANStream => addcontactIBANuseCaseResponse.stream;

  ///---------------------------get-purpose---------------------------///
  PublishSubject<GetPurposeUseCaseParams> _getPurposeRequest = PublishSubject();
  PublishSubject<Resource<PurposeResponse>> _getPurposeResponse = PublishSubject();

  Stream<Resource<PurposeResponse>> get getPurposeResponseStream => _getPurposeResponse.stream;

  ///--------------------------public-other-methods-------------------------------------///

  PublishSubject<bool> _showNameVisibilityRequest = PublishSubject();

  Stream<bool> get showNameVisibilityStream => _showNameVisibilityRequest.stream;

  void showNameVisibility(bool value) {
    _showNameVisibilityRequest.safeAdd(value);
  }

  void getPurpose(String toAccount, String transferType, String detCustomerType, String type) {
    _getPurposeRequest.safeAdd(GetPurposeUseCaseParams(
        toAccount: toAccount, transferType: transferType, type: type, detCustomerType: detCustomerType));
  }

  validate(String data) {
    if (nameController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(false);
    }
    if (ibanOrMobileController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(false);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  validationUserInput() {
    addcontactIBANuseCaseRequest.safeAdd(AddContactIBANuseCaseParams(
        IBANAccountNoMobileNoAlias: ibanOrMobileController.text,
        purpose: purposeController.text,
        beneficiaryType: '',
        purposeDetail: purposeDetailController.text,
        name: nameController.text,
        fullName: ''));
  }

  void getError(Resource<bool> event) {
    switch (event.appError?.type) {
      case ErrorType.PLEASE_ENTER_CONTACT_NAME:
        nameKey.currentState!.isValid = false;
        break;

      case ErrorType.INVALID_IBAN:
        ibanORaccountORmobileORaliasKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  void checkSendMoney({required String iban}) {
    _checkSendMoneyRequest.safeAdd(CheckSendMoneyUseCaseParams(toAccount: iban, toAmount: 0));
  }

  void getAccountByAlias(String value, String currency) {
    _getAccountByAliasRequest.safeAdd(GetAccountByAliasUseCaseParams(value: value, currency: currency));
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

  void updatePurposeDetaiList(List<PurposeDetail> list) {
    purposeDetailController.clear();
    purposeDetailList.clear();
    purposeDetailList.addAll(list);
  }

  ///--------------------------public-constructor-------------------------------------///

  AddBeneficiaryFormPageViewModel(this.addContactIBANuseCase, this.getPurposeUseCase,
      this._checkSendMoneyUseCase, this._getAccountByAliasUseCase) {
    addcontactIBANuseCaseRequest.listen(
      (value) {
        RequestManager(value, createCall: () => addContactIBANuseCase.execute(params: value)).asFlow().listen(
          (event) {
            addcontactIBANuseCaseResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              getError(event);
              showErrorState();
              showToastWithError(event.appError!);

              log("error......");
            }
          },
        );
      },
    );

    _getPurposeRequest.listen((value) {
      RequestManager(value, createCall: () => getPurposeUseCase.execute(params: value))
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
        }
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
          getPurpose(event.data!.checkSendMoneyContent!.transferResponse!.toAccount!, "TransferI", '', '');
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
        } else if (event.status == Status.SUCCESS) {
          getPurpose(
              event.data?.getAccountByAliasContent?.acciban ?? '',
              "RTP",
              event.data?.getAccountByAliasContent?.detCustomerType ?? '',
              event.data?.getAccountByAliasContent?.type ?? '');
        }
      });
    });
  }
}
