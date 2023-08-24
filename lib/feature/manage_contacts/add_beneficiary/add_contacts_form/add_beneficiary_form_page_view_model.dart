import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_OTP_usecase.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/get_account_by_alias_usecase.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/subjects.dart';

import '../../../../di/manage_contacts/manage_contacts_modules.dart';
import '../../../../utils/navgition_type.dart';

class AddBeneficiaryFormPageViewModel extends BasePageViewModel {
  final CheckSendMoneyUseCase _checkSendMoneyUseCase;
  final AddBeneficiaryOTPUseCase addBeneficiaryOTPUseCase;
  final GetPurposeUseCase getPurposeUseCase;
  final GetAccountByAliasUseCase _getAccountByAliasUseCase;

  List<Purpose> purposeList = [];

  List<PurposeDetail> purposeDetailList = [];

  TransferResponse transferResponse = TransferResponse();
  GetAccountByAliasContentResponse getAccountByAliasContentResponse = GetAccountByAliasContentResponse();

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
  BehaviorSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse = BehaviorSubject();

  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneySteam => _checkSendMoneyResponse.stream;

  ///--------------------------request money request-------------------------------------///
  PublishSubject<GetAccountByAliasUseCaseParams> _getAccountByAliasRequest = PublishSubject();
  BehaviorSubject<Resource<GetAccountByAliasContentResponse>> _getAccountByAliasResponse = BehaviorSubject();

  ///--------------------------formField-subject-------------------------------------///

  BehaviorSubject<String> formFieldSubject = BehaviorSubject.seeded("");

  ///--------------------------animated-button-subject-------------------------------------///
  ///
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  ///--------------------------addContact-subject-------------------------------------///

  PublishSubject<AddBeneficiaryOTPUseCaseParams> _addcontactIBANuseCaseRequest = PublishSubject();
  BehaviorSubject<Resource<SendOtpAddBeneficiaryResponse>> _addcontactIBANuseCaseResponse = BehaviorSubject();

  Stream<Resource<SendOtpAddBeneficiaryResponse>> get addcontactIBANStream =>
      _addcontactIBANuseCaseResponse.stream;

  ///---------------------------get-purpose---------------------------///
  PublishSubject<GetPurposeUseCaseParams> _getPurposeRequest = PublishSubject();
  PublishSubject<Resource<PurposeResponse>> _getPurposeResponse = PublishSubject();

  Stream<Resource<PurposeResponse>> get getPurposeResponseStream => _getPurposeResponse.stream;

  ///--------------------------public-other-methods-------------------------------------///

  String mobileNumber = '';
  String mobileCode = '';

  BehaviorSubject<String> _showNameVisibilityRequest = BehaviorSubject.seeded('');

  Stream<String> get showNameVisibilityStream => _showNameVisibilityRequest.stream;

  late NavigationType navigationType;

  void showNameVisibility(String value) {
    _showNameVisibilityRequest.safeAdd(value);
  }

  bool ibanFieldValidated = false;

  void getPurpose(String toAccount, String transferType, String detCustomerType, String type) {
    _getPurposeRequest.safeAdd(GetPurposeUseCaseParams(
        toAccount: toAccount, transferType: transferType, type: type, detCustomerType: detCustomerType));
  }

  validate() {
    if (nameController.text.isNotEmpty &&
        ibanOrMobileController.text.isNotEmpty &&
        purposeDetail?.strCode != null &&
        ibanFieldValidated) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  validationUserInput(BuildContext buildContext) {
    _addcontactIBANuseCaseRequest.safeAdd(AddBeneficiaryOTPUseCaseParams(
        IBANAccountNoMobileNoAlias: ibanOrMobileController.text,
        purpose: purpose?.code ?? '',
        beneficiaryType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM',
        purposeDetail: purposeDetail?.strCode ?? '',
        name: nameController.text,
        fullName: navigationType == NavigationType.REQUEST_MONEY
            ? getAccountByAliasContentResponse.getAccountByAliasContent?.name ?? ''
            : transferResponse.name ?? ''));
  }

  void getError(Resource<SendOtpAddBeneficiaryResponse> event) {
    switch (event.appError?.type) {
      case ErrorType.EMPTY_NICKNAME_VALUE:
        nameKey.currentState!.isValid = false;
        break;

      case ErrorType.NICKNAME_LENGTH_SHOULD_NOT_BE_GREATER_THAN_50:
        nameKey.currentState!.isValid = false;
        break;

      case ErrorType.PLEASE_ENTER_IBAN_ACCOUNT_MOBILE_ALIAS:
        ibanORaccountORmobileORaliasKey.currentState!.isValid = false;
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

  void checkSendMoney({required String iban}) {
    _checkSendMoneyRequest
        .safeAdd(CheckSendMoneyUseCaseParams(toAccount: iban, toAmount: 0, beneficiaryId: ''));
  }

  void getAccountByAlias(String value, String currency) {
    _getAccountByAliasRequest
        .safeAdd(GetAccountByAliasUseCaseParams(value: value, currency: currency, beneficiaryId: ''));
  }

  void updatePurpose(Purpose value) {
    purposeController.text = value.labelEn!;
    purpose = value;
    purposeDetail = null;
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

  void callAPIforRequestAndSendMoney() {
    if (navigationType == NavigationType.REQUEST_MONEY) {
      if (ibanOrMobileController.text.isNotEmpty) {
        getAccountByAlias(ibanOrMobileController.text, 'JOD');
      }
    } else {
      if (ibanOrMobileController.text.isNotEmpty) {
        checkSendMoney(iban: ibanOrMobileController.text);
      }
    }
  }

  ///--------------------------public-constructor-------------------------------------///

  AddBeneficiaryFormPageViewModel(this.addBeneficiaryOTPUseCase, this.getPurposeUseCase,
      this._checkSendMoneyUseCase, this._getAccountByAliasUseCase) {
    _addcontactIBANuseCaseRequest.listen(
      (value) {
        RequestManager(value, createCall: () => addBeneficiaryOTPUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _addcontactIBANuseCaseResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              showErrorState();
              showToastWithError(event.appError!);
              getError(event);
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
          showNameVisibility('');
        } else if (event.status == Status.SUCCESS) {
          purposeList.clear();
          purposeList.addAll(event.data?.content?.transferPurposeResponse?.purposes ?? []);

          if (navigationType == NavigationType.REQUEST_MONEY) {
            showNameVisibility(getAccountByAliasContentResponse.getAccountByAliasContent?.name ?? '');
          } else {
            showNameVisibility(transferResponse.name ?? '');
          }
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
          purpose = null;
          purposeDetail = null;
          showErrorState();
          showToastWithError(event.appError!);
          showNameVisibility('');
          ibanFieldValidated = false;
          validate();
        } else if (event.status == Status.SUCCESS) {
          purpose = null;
          purposeDetail = null;
          ibanFieldValidated = true;
          transferResponse = event.data!.checkSendMoneyContent!.transferResponse!;
          getPurpose(event.data!.checkSendMoneyContent!.transferResponse!.toAccount!, "TransferI", '', '');

          purposeController.clear();
          purposeDetailController.clear();

          checkSendMoneyMessageEnum = event.data?.checkSendMoneyContent?.transferResponse?.messageEnum ??
              CheckSendMoneyMessageEnum.NONE;
          validate();
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
          purpose = null;
          purposeDetail = null;
          showErrorState();
          showToastWithError(event.appError!);
          purposeList = [];
          purposeDetailList = [];
          purposeController.clear();
          purposeDetailController.clear();
          showNameVisibility('');
          ibanFieldValidated = false;
          validate();
        } else if (event.status == Status.SUCCESS) {
          purpose = null;
          purposeDetail = null;
          ibanFieldValidated = true;
          getAccountByAliasContentResponse = event.data!;
          getPurpose(
              event.data?.getAccountByAliasContent?.acciban ?? '',
              "RTP",
              event.data?.getAccountByAliasContent?.detCustomerType ?? '',
              event.data?.getAccountByAliasContent?.type ?? '');

          purposeController.clear();
          purposeDetailController.clear();
          validate();
        }
      });
    });

    final provider = ProviderScope.containerOf(appLevelKey.currentContext!).read(
      addBeneficiaryViewModelProvider,
    );
    navigationType = provider.arguments.navigationType;
  }

  @override
  void dispose() {
    _checkSendMoneyRequest.close();
    _checkSendMoneyResponse.close();
    _getAccountByAliasRequest.close();
    _getAccountByAliasResponse.close();
    formFieldSubject.close();
    _showButtonSubject.close();
    _addcontactIBANuseCaseRequest.close();
    _addcontactIBANuseCaseResponse.close();
    _getPurposeRequest.close();
    _getPurposeResponse.close();
    _showNameVisibilityRequest.close();
    super.dispose();
  }
}
