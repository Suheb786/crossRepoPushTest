import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:domain/usecase/card_delivery/credit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limit_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limits_update_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
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

  bool isAtmWithdrawal = false;
  bool isMerchantPayments = false;
  bool isOnlinePurchase = false;
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
      {required int atmWithdrawalValue,
      required int merchantPayment,
      required int onlinePurchase,
      required int contactlessPayments}) {
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
          contactlessPayments: contactlessPayments);
    }
  }

  void updateCreditCardLimits(
      {required int atmWithdrawalValue,
      required int merchantPayment,
      required int onlinePurchase,
      required int contactlessPayments}) {
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
      {required int atmWithdrawalValue,
      required int merchantPayment,
      required int onlinePurchase,
      required int contactlessPayments}) {
    _updateDebitCardLimitsRequestSubject.safeAdd(
        DebitCardLimitsUpdateUseCaseParams(
            onlinePurchase: onlinePurchase,
            merchantsPayments: merchantPayment,
            isOnlinePurchase: isOnlinePurchase,
            isMerchantsPayments: isMerchantPayments,
            isContactLessPayments: isContactLessPayments,
            isAtmWithdrawal: isAtmWithdrawal,
            contactLessPayments: contactlessPayments,
            atmWithdrawal: atmWithdrawalValue));
  }

  @override
  void dispose() {
    _updateCardLimitsResponseSubject.close();
    _updateCreditCardLimitsRequestSubject.close();
    _updateDebitCardLimitsRequestSubject.close();

    super.dispose();
  }
}
