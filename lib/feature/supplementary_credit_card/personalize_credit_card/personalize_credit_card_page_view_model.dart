import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/card_delivery/personalize_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/supplementary_credit_card_request_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

class PersonalizeCreditCardPageViewModel extends BasePageViewModel {
  final PersonalizeCreditCardUseCase _personalizeCreditCardUseCase;
  final SupplementaryCreditCardRequestUseCase
      _supplementaryCreditCardRequestUseCase;

  TextEditingController creditLimitSettingsController = TextEditingController();
  TextEditingController minimumSettlementController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  final GlobalKey<AppTextFieldState> creditLimitSettingsKey =
      GlobalKey(debugLabel: "creditLimitSettings");

  final GlobalKey<AppTextFieldState> minimumSettlementKey =
      GlobalKey(debugLabel: "minimumSettlement");

  final GlobalKey<AppTextFieldState> nickNameKey =
      GlobalKey(debugLabel: "nickName");

  List<String> creditLimitsSettings = [
    "Shared limit with primary",
    "Set up sub limit within primary"
  ];

  List<String> minimumSettlements = ["5 %", "25 %", "50 %", "100 %"];

  /// personalize credit card request subject holder
  PublishSubject<PersonalizeCreditCardUseCaseParams>
      _personalizeCreditCardRequest = PublishSubject();

  /// personalize credit card response subject holder
  PublishSubject<Resource<bool>> _personalizeCreditCardResponse =
      PublishSubject();

  Stream<Resource<bool>> get personalizeCreditCardResponseStream =>
      _personalizeCreditCardResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  /// minimum pay back visibility Subject holder
  BehaviorSubject<bool> _minimumPayBackSubject = BehaviorSubject.seeded(true);

  Stream<bool> get minimumPayBackStream => _minimumPayBackSubject.stream;

  /// supplementary credit card request subject holder
  PublishSubject<SupplementaryCreditCardRequestUseCaseParams>
      _supplementaryCreditCardRequest = PublishSubject();

  /// supplementary credit card response subject holder
  PublishSubject<Resource<SupplementaryCreditCardResponse>>
      _supplementaryCreditCardResponse = PublishSubject();

  Stream<Resource<SupplementaryCreditCardResponse>>
      get supplementaryCreditCardResponseStream =>
          _supplementaryCreditCardResponse.stream;

  PersonalizeCreditCardPageViewModel(this._personalizeCreditCardUseCase,
      this._supplementaryCreditCardRequestUseCase) {
    _personalizeCreditCardRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _personalizeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _personalizeCreditCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _supplementaryCreditCardRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _supplementaryCreditCardRequestUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _supplementaryCreditCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void personalizeCreditCard() {
    _personalizeCreditCardRequest.safeAdd(PersonalizeCreditCardUseCaseParams(
        creditLimitSettings: creditLimitSettingsController.text,
        minimumSettlement: minimumSettlementController.text,
        readOnly: _minimumPayBackSubject.value,
        nickname: nickNameController.text));
  }

  void updateCreditLimitSettingValue(String value, BuildContext context) {
    creditLimitSettingsController.text = value;
    if (value == creditLimitsSettings[0]) {
      updateMinimumPayBack(true);
      minimumSettlementController.text =
          '${ProviderScope.containerOf(context).read(supplementaryCreditCardViewModelProvider).creditCard.minimumSettlement} %';
    } else if (value == creditLimitsSettings[1]) {
      updateMinimumPayBack(false);
    }
  }

  void validate() {
    bool isValid = false;
    if (_minimumPayBackSubject.value &&
        creditLimitSettingsController.text.isNotEmpty &&
        minimumSettlementController.text.isNotEmpty) {
      isValid = true;
    } else if (creditLimitSettingsController.text.isNotEmpty) {
      isValid = true;
    }
    _showButtonSubject.safeAdd(isValid);
  }

  void updateMinimumPayBack(bool value) {
    _minimumPayBackSubject.safeAdd(value);
  }

  void supplementaryCreditCardRequest(
      {required String primaryId,
      required String relationShip,
      required ScannedDocumentInformation scannedDocumentInformation}) {
    _supplementaryCreditCardRequest
        .safeAdd(SupplementaryCreditCardRequestUseCaseParams(
      primaryCard: primaryId,
      relationship: relationShip,
      nickName: nickNameController.text,
      sameLimit: _minimumPayBackSubject.value,
      limit: num.parse(minimumSettlementController.text.replaceAll('%', '')),
      scannedDocumentInformation: scannedDocumentInformation,
      doe: scannedDocumentInformation.doe != null
          ? TimeUtils.getFormattedDateForCheckPassword(
              scannedDocumentInformation.doe.toString())
          : "",
      dob: scannedDocumentInformation.dob != null
          ? TimeUtils.getFormattedDateForCheckPassword(
              scannedDocumentInformation.dob.toString())
          : "",
      doi: scannedDocumentInformation.issuingDate != null
          ? TimeUtils.getFormattedDateForCheckPassword(
              scannedDocumentInformation.issuingDate.toString())
          : "",
    ));
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _personalizeCreditCardRequest.close();
    _personalizeCreditCardResponse.close();
    super.dispose();
  }
}
