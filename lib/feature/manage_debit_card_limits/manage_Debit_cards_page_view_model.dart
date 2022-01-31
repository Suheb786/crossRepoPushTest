import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:domain/usecase/card_delivery/credit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limit_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limits_update_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_debit_card_limits_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageDebitCardLimitsPageViewModel extends BasePageViewModel {
  final ManageCardLimitsArguments cardLimitsArguments;
  final DebitCardLimitsUpdateUseCase _debitCardLimitsUpdateUseCase;
  final DebitCardLimitUseCase _debitCardLimitUseCase;
  final CreditCardLimitsUpdateUseCase _creditCardLimitsUpdateUseCase;

  ///debit card limits update request
  PublishSubject<DebitCardLimitsUpdateUseCaseParams>
      _updateDebitCardLimitsRequestSubject = PublishSubject();

  ///debit card get limits request
  PublishSubject<DebitCardLimitUseCaseParams> _debitCardLimitRequest =
      PublishSubject();

  ///credit card limits update request
  PublishSubject<CreditCardLimitsUpdateUseCaseParams>
      _updateCreditCardLimitsRequestSubject = PublishSubject();

  ///card limits update response
  PublishSubject<Resource<bool>> _updateCardLimitsResponseSubject =
      PublishSubject();

  ///card limits update response stream
  Stream<Resource<bool>> get updateCardLimitsStream =>
      _updateCardLimitsResponseSubject.stream;

  ///debit card limits response
  PublishSubject<Resource<DebitCardLimitResponse>>
      _debitCardLimitResponseSubject = PublishSubject();

  ///debit card limits response stream
  Stream<Resource<DebitCardLimitResponse>> get debitCardLimitResponseStream =>
      _debitCardLimitResponseSubject.stream;

  num atmWithdrawalValue = 0;
  num merchantPayment = 0;
  num onlinePurchase = 0;
  num contactlessPayments = 0;

  bool isAtmWithdrawal = true;
  bool isMerchantPayments = true;
  bool isOnlinePurchase = true;
  bool isContactLessPayments = false;

  ManageDebitCardLimitsPageViewModel(
      this.cardLimitsArguments,
      this._debitCardLimitsUpdateUseCase,
      this._creditCardLimitsUpdateUseCase,
      this._debitCardLimitUseCase) {
    _debitCardLimitRequest.listen((value) {
      RequestManager(value,
              createCall: () => _debitCardLimitUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _debitCardLimitResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getDebitCardLimit();

    _updateCreditCardLimitsRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _creditCardLimitsUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateCardLimitsResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _updateDebitCardLimitsRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _debitCardLimitsUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateCardLimitsResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void getDebitCardLimit() {
    _debitCardLimitRequest.safeAdd(DebitCardLimitUseCaseParams());
  }

  void updateCardLimits(
      {required num atmWithdrawalValue,
      required num merchantPayment,
      required num onlinePurchase,
      required BuildContext context,
      required num contactlessPayments}) {
    if (cardLimitsArguments.cardType == CardType.CREDIT) {
      updateCreditCardLimits(
          atmWithdrawalValue: atmWithdrawalValue,
          merchantPayment: merchantPayment,
          onlinePurchase: onlinePurchase,
          contactlessPayments: contactlessPayments);
    } else if (cardLimitsArguments.cardType == CardType.DEBIT) {
      updateDebitCardLimits(
          atmWithdrawalValue: atmWithdrawalValue,
          merchantPayment: merchantPayment,
          onlinePurchase: onlinePurchase,
          contactlessPayments: contactlessPayments,
          context: context);
    }
  }

  void updateCreditCardLimits(
      {required num atmWithdrawalValue,
      required num merchantPayment,
      required num onlinePurchase,
      required num contactlessPayments}) {
    _updateCreditCardLimitsRequestSubject.safeAdd(
        CreditCardLimitsUpdateUseCaseParams(
            onlinePurchase: onlinePurchase,
            merchantsPayments: merchantPayment,
            isOnlinePurchase: isOnlinePurchase,
            isMerchantsPayments: isMerchantPayments,
            isContactLessPayments: isContactLessPayments,
            isAtmWithdrawal: isAtmWithdrawal,
            contactLessPayments: contactlessPayments,
            atmWithdrawal: atmWithdrawalValue));
  }

  void updateDebitCardLimits(
      {required num atmWithdrawalValue,
      required num merchantPayment,
      required num onlinePurchase,
      required num contactlessPayments,
      required BuildContext context}) {
    _updateDebitCardLimitsRequestSubject.safeAdd(
        DebitCardLimitsUpdateUseCaseParams(
            onlinePurchase: onlinePurchase,
            merchantsPayments: merchantPayment,
            isOnlinePurchase: isOnlinePurchase,
            isMerchantsPayments: isMerchantPayments,
            isContactLessPayments: isContactLessPayments,
            isAtmWithdrawal: isAtmWithdrawal,
            contactLessPayments: contactlessPayments,
            atmWithdrawal: atmWithdrawalValue,
            tokenizedPan: ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .debitCard!
                .first
                .code!));
  }

  @override
  void dispose() {
    _updateCardLimitsResponseSubject.close();
    _updateCreditCardLimitsRequestSubject.close();
    _updateDebitCardLimitsRequestSubject.close();

    super.dispose();
  }
}
