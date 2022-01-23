import 'package:domain/usecase/card_delivery/personalize_credit_card_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PersonalizeCreditCardPageViewModel extends BasePageViewModel {
  final PersonalizeCreditCardUseCase _personalizeCreditCardUseCase;

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

  List<String> minimumSettlements = [
    "3%",
    "5%",
    "7%",
    "10%",
    "12%",
    "15%",
    "18%"
  ];

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

  PersonalizeCreditCardPageViewModel(this._personalizeCreditCardUseCase) {
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
  }

  void personalizeCreditCard() {
    _personalizeCreditCardRequest.safeAdd(PersonalizeCreditCardUseCaseParams(
        creditLimitSettings: creditLimitSettingsController.text,
        //minimumSettlement: minimumSettlementController.text,
        nickname: nickNameController.text));
  }

  void validate() {
    bool isValid = false;
    if (creditLimitSettingsController.text.isNotEmpty
        // &&
        // minimumSettlementController.text.isNotEmpty
        ) {
      isValid = true;
    }
    _showButtonSubject.safeAdd(isValid);
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _personalizeCreditCardRequest.close();
    _personalizeCreditCardResponse.close();
    super.dispose();
  }
}
