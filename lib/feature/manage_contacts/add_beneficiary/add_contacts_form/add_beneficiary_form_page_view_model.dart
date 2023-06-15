import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/subjects.dart';

import '../../../../di/manage_contacts/manage_contacts_modules.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import '../../../../utils/navgition_type.dart';
import '../../../../utils/string_utils.dart';

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

  PublishSubject<AddBeneficiaryOTPUseCaseParams> addcontactIBANuseCaseRequest = PublishSubject();
  BehaviorSubject<Resource<SendOtpAddBeneficiaryResponse>> addcontactIBANuseCaseResponse = BehaviorSubject();

  Stream<Resource<SendOtpAddBeneficiaryResponse>> get addcontactIBANStream =>
      addcontactIBANuseCaseResponse.stream;

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

  validationUserInput(BuildContext buildContext) {
    addcontactIBANuseCaseRequest.safeAdd(AddBeneficiaryOTPUseCaseParams(
        IBANAccountNoMobileNoAlias: ibanOrMobileController.text,
        purpose: '',
        beneficiaryType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM',
        purposeDetail: purposeDetail?.strCode ?? '',
        name: nameController.text,
        fullName: navigationType == NavigationType.REQUEST_MONEY
            ? getAccountByAliasContentResponse.getAccountByAliasContent?.name ?? ''
            : transferResponse.name ?? ''));
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
    addcontactIBANuseCaseRequest.listen(
      (value) {
        RequestManager(value, createCall: () => addBeneficiaryOTPUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            addcontactIBANuseCaseResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              showErrorState();
              showToastWithError(event.appError!);
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
          purposeList.addAll(event.data!.content!.transferPurposeResponse!.purposes!);

          if (navigationType == NavigationType.REQUEST_MONEY) {
            showNameVisibility(getAccountByAliasContentResponse.getAccountByAliasContent!.name ?? '');
          } else {
            if (transferResponse.messageEnum == CheckSendMoneyMessageEnum.IBAN_FROM_CliQ) {
              showNameVisibility('');
            } else {
              showNameVisibility(transferResponse.name!);
            }
          }
        }
      });
    });

    _checkSendMoneyRequest.listen((value) {
      RequestManager(value, createCall: () => _checkSendMoneyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          showNameVisibility('');
        } else if (event.status == Status.SUCCESS) {
          transferResponse = event.data!.checkSendMoneyContent!.transferResponse!;
          getPurpose(event.data!.checkSendMoneyContent!.transferResponse!.toAccount!, "TransferI", '', '');

          purposeController.clear();
          purposeDetailController.clear();

          checkSendMoneyMessageEnum = event.data?.checkSendMoneyContent?.transferResponse?.messageEnum ??
              CheckSendMoneyMessageEnum.NONE;

          if (event.data?.checkSendMoneyContent?.transferResponse?.messageEnum ==
              CheckSendMoneyMessageEnum.Mobile_NUMBER_BANKSMART) {
            InformationDialog.show(appLevelKey.currentContext!,
                isSwipeToCancel: false,
                title: S.current.mobileNoRegisteredWithBlink,
                descriptionWidget: Text(
                  S.current.mobileNoRegisteredWithBlinkDesc,
                  style:
                      TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w400),
                ),
                onDismissed: () {}, onSelected: () {
              Navigator.pop(appLevelKey.currentContext!);
            });
          }
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
          showNameVisibility('');
        } else if (event.status == Status.SUCCESS) {
          getAccountByAliasContentResponse = event.data!;
          getPurpose(
              event.data?.getAccountByAliasContent?.acciban ?? '',
              "RTP",
              event.data?.getAccountByAliasContent?.detCustomerType ?? '',
              event.data?.getAccountByAliasContent?.type ?? '');

          purposeController.clear();
          purposeDetailController.clear();
        }
      });
    });

    final provider = ProviderScope.containerOf(appLevelKey.currentContext!).read(
      addBeneficiaryViewModelProvider,
    );
    navigationType = provider.navigationType;
  }
}
