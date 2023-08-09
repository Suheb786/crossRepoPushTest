import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_content.dart';
import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_response.dart';
import 'package:domain/usecase/apple_pay/push_antelop_cards_usecase.dart';
import 'package:domain/usecase/card_delivery/cancel_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/get_supplementary_credit_card_application_usecase.dart';
import 'package:domain/usecase/card_delivery/report_lost_stolen_cc_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_credit_card_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardSettingsViewModel extends BasePageViewModel {
  final CreditCardSettingsArguments creditCardSettingsArguments;
  final FreezeCreditCardUseCase _freezeCreditCardUseCase;
  final UnFreezeCreditCardUseCase _unFreezeCreditCardUseCase;
  final CancelCreditCardUseCase _cancelCreditCardUseCase;
  final GetSupplementaryCreditCardApplicationUseCase _getSupplementaryCreditCardApplicationUseCase;
  final ReportLostStolenCCUseCase _reportLostStolenCCUseCase;
  final PushAntelopCardsUseCase _pushAntelopCardsUseCase;
  final ScrollController controller = ScrollController();

  PublishSubject<bool> _toggleFreezeCardSubject = PublishSubject();

  Stream<bool> get freezeCardStream => _toggleFreezeCardSubject.stream;

  PublishSubject<FreezeCreditCardUseCaseParams> _freezeCardRequestSubject = PublishSubject();
  PublishSubject<Resource<bool>> _toggleFreezeCardSubjectResponse = PublishSubject();

  Stream<Resource<bool>> get toggleFreezeCardStream => _toggleFreezeCardSubjectResponse.stream;

  PublishSubject<UnFreezeCreditCardUseCaseParams> _unFreezeCardRequestSubject = PublishSubject();

  ///cancel credit card
  PublishSubject<CancelCreditCardUseCaseParams> _cancelCreditCardRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _cancelCreditCardResponseSubject = PublishSubject();

  Stream<Resource<bool>> get cancelCreditCardStream => _cancelCreditCardResponseSubject.stream;

  bool isFreezed = false;
  bool isUnFreezed = false;
  bool isCancelled = false;

  ///show dialog
  PublishSubject<bool> _showDialogRequestSubject = PublishSubject();

  Stream<bool> get showDialogStream => _showDialogRequestSubject.stream;

  ///get supplementary credit card application use case
  PublishSubject<GetSupplementaryCreditCardApplicationUseCaseParams>
      _getSupplementaryCreditCardApplicationRequestSubject = PublishSubject();

  PublishSubject<Resource<SupplementaryCreditCardApplicationResponse>>
      _getSupplementaryCreditCardApplicationResponseSubject = PublishSubject();

  Stream<Resource<SupplementaryCreditCardApplicationResponse>>
      get getSupplementaryCreditCardApplicationStream =>
          _getSupplementaryCreditCardApplicationResponseSubject.stream;

  ///report Lost stolen cc use case
  PublishSubject<ReportLostStolenCCUseCaseParams> _reportLostStolenCCRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _reportLostStolenCCResponseSubject = PublishSubject();

  Stream<Resource<bool>> get reportLostStolenCCStream => _reportLostStolenCCResponseSubject.stream;

  ///report damaged cc use case
  PublishSubject<ReportLostStolenCCUseCaseParams> _reportDamagedCCRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _reportDamagedCCResponseSubject = PublishSubject();

  Stream<Resource<bool>> get reportDamagedCCStream => _reportDamagedCCResponseSubject.stream;

  List<String> creditCardCancellationReasonEn = [
    "I don’t need my card anymore.",
    "High interest, fees & charges.",
    "I feel the credit limit is low.",
    "High FX rates.",
    "I’m trying to control my expenses.",
    "I’m dissatisfied with service.",
    "There are too many declined trx’s"
  ];
  List<String> creditCardCancellationReasonAr = [
    " عدم الحاجة الى البطاقة",
    "ارتفاع العمولات و الفوائد",
    " سقف البطاقة منخفض",
    "رتفاع سعر الصرف",
    "حاول التحكم بمصاريفي",
    "غير راضي عن الخدمة المقدمة",
    "ثرة الحركات المرفوضة"
  ];

  ///---------------push antelop cards-----------------------///

  PublishSubject<PushAntelopCardsUseCaseParams> _pushAntelopCardsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _pushAntelopCardsResponse = PublishSubject();

  Stream<Resource<bool>> get pushAntelopCardsStream => _pushAntelopCardsResponse.stream;

  void pushCardToAntelop({required String cardCode}) {
    _pushAntelopCardsRequest.safeAdd(PushAntelopCardsUseCaseParams(cardId: cardCode));
  }

  ///---------------push antelop cards-----------------------///

  CreditCardSettingsViewModel(
      this._freezeCreditCardUseCase,
      this._unFreezeCreditCardUseCase,
      this._cancelCreditCardUseCase,
      this.creditCardSettingsArguments,
      this._getSupplementaryCreditCardApplicationUseCase,
      this._reportLostStolenCCUseCase,
      this._pushAntelopCardsUseCase) {
    _freezeCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _freezeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _toggleFreezeCardSubjectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _toggleFreezeCardSubject.safeAdd(false);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _toggleFreezeCardSubject.safeAdd(true);
          isFreezed = true;
        }
      });
    });

    _unFreezeCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _unFreezeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _toggleFreezeCardSubjectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _toggleFreezeCardSubject.safeAdd(true);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _toggleFreezeCardSubject.safeAdd(false);
          isUnFreezed = true;
        }
      });
    });

    _cancelCreditCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _cancelCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cancelCreditCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          isCancelled = true;
        }
      });
    });

    _getSupplementaryCreditCardApplicationRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () => _getSupplementaryCreditCardApplicationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getSupplementaryCreditCardApplicationResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          checkStepIncomplete(event.data!.cardApplicationContent);
        }
      });
    });

    _reportLostStolenCCRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _reportLostStolenCCUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reportLostStolenCCResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _reportDamagedCCRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _reportLostStolenCCUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reportDamagedCCResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _pushAntelopCardsRequest.listen((value) {
      RequestManager(value, createCall: () {
        return _pushAntelopCardsUseCase.execute(params: value);
      }).asFlow().listen((event) {
        // updateLoader();
        _pushAntelopCardsResponse.safeAdd(event);
      });
    });
  }

  void toggleFreezeCardStatus(bool value) {
    _toggleFreezeCardSubject.safeAdd(value);
  }

  void freezeCardStatus(bool value) {
    _toggleFreezeCardSubject.safeAdd(value);
  }

  void freezeCard(String cardID) {
    _freezeCardRequestSubject.safeAdd(FreezeCreditCardUseCaseParams(cardId: cardID));
  }

  void unFreezeCard(String cardID) {
    _unFreezeCardRequestSubject.safeAdd(UnFreezeCreditCardUseCaseParams(cardId: cardID));
  }

  void cancelCard(String reason) {
    _cancelCreditCardRequestSubject.safeAdd(CancelCreditCardUseCaseParams(reason: reason));
  }

  bool willPop() {
    bool pop = false;
    if (isFreezed || isUnFreezed || isCancelled) {
      pop = true;
    }
    return pop;
  }

  void updateShowDialog(bool value) {
    _showDialogRequestSubject.safeAdd(value);
  }

  void getSupplementaryCreditCardApplication() {
    _getSupplementaryCreditCardApplicationRequestSubject.safeAdd(
        GetSupplementaryCreditCardApplicationUseCaseParams(
            primaryCard: creditCardSettingsArguments.creditCard.cardId));
  }

  void reportLostStolenCC() {
    _reportLostStolenCCRequestSubject.safeAdd(ReportLostStolenCCUseCaseParams(
        cardCode: creditCardSettingsArguments.creditCard.cardCode ?? '',
        panGenerationMode: "N",
        replacementReason: "0003"));
  }

  void reportDamagedCC() {
    _reportDamagedCCRequestSubject.safeAdd(ReportLostStolenCCUseCaseParams(
        cardCode: creditCardSettingsArguments.creditCard.cardCode ?? '',
        panGenerationMode: "N",
        replacementReason: "0001"));
  }

  PublishSubject<bool> _routeSupplementarySubject = PublishSubject();

  Stream<bool> get routeSupplementaryStream => _routeSupplementarySubject.stream;

  void checkStepIncomplete(List<SupplementaryCreditCardApplicationContent>? cardApplicationContent) {
    bool isIncomplete = false;
    if (cardApplicationContent!.isEmpty) {
      isIncomplete = false;
    } else {
      cardApplicationContent.firstWhere((element) {
        if (!((element.step1 ?? false) && (element.step2 ?? false) && (element.step3 ?? false))) {
          isIncomplete = true;
          return false;
        } else {
          isIncomplete = false;
          return true;
        }
      });
    }
    _routeSupplementarySubject.safeAdd(isIncomplete);
  }

  @override
  void dispose() {
    _toggleFreezeCardSubject.close();
    _freezeCardRequestSubject.close();
    _unFreezeCardRequestSubject.close();
    _toggleFreezeCardSubjectResponse.close();
    _cancelCreditCardResponseSubject.close();
    super.dispose();
  }
}
