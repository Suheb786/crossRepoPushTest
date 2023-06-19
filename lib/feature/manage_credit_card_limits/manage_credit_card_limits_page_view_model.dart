import 'package:domain/model/credit_card/get_credit_card_limit_response.dart';
import 'package:domain/usecase/card_delivery/credit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_limit_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageCreditCardLimitsPageViewModel extends BasePageViewModel {
  final ManageCreditCardLimitsArguments cardLimitsArguments;
  final GetCreditCardLimitUseCase _creditCardLimitUseCase;
  final CreditCardLimitsUpdateUseCase _creditCardLimitsUpdateUseCase;

  ///credit card limits update request
  PublishSubject<CreditCardLimitsUpdateUseCaseParams> _updateCreditCardLimitsRequestSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _updateCreditCardLimitsResponseSubject = PublishSubject();

  Stream<Resource<bool>> get updateCreditCardLimitsStream => _updateCreditCardLimitsResponseSubject.stream;

  ///credit card get limits request
  PublishSubject<GetCreditCardLimitUseCaseParams> _getCreditCardLimitRequest = PublishSubject();

  PublishSubject<Resource<GetCreditCardLimitResponse>> _getCreditCardLimitResponseSubject = PublishSubject();

  Stream<Resource<GetCreditCardLimitResponse>> get getCreditCardLimitResponseStream =>
      _getCreditCardLimitResponseSubject.stream;

  /// show save button visibility
  BehaviorSubject<bool> _showSaveButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showSaveButtonStream => _showSaveButtonSubject.stream;

  num atmWithdrawalValue = 0;
  num merchantPaymentValue = 0;
  num onlinePurchaseValue = 0;
  num contactlessPaymentsValue = 0;

  num atmWithdrawalInitialValue = 0;
  num merchantPaymentInitialValue = 0;
  num onlinePurchaseInitialValue = 0;
  num contactlessPaymentsInitialValue = 0;

  bool isAtmWithdrawal = false;
  bool isMerchantPayments = false;
  bool isOnlinePurchase = false;
  bool isContactLessPayments = false;

  bool isAtmWithdrawalInitialValue = false;
  bool isMerchantPaymentsInitialValue = false;
  bool isOnlinePurchaseInitialValue = false;
  bool isContactLessPaymentsInitialValue = false;

  ManageCreditCardLimitsPageViewModel(
      this.cardLimitsArguments, this._creditCardLimitUseCase, this._creditCardLimitsUpdateUseCase) {
    _getCreditCardLimitRequest.listen((value) {
      RequestManager(value, createCall: () => _creditCardLimitUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getCreditCardLimitResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _updateCreditCardLimitsRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _creditCardLimitsUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateCreditCardLimitsResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    getCreditCardLimit();
  }

  void getCreditCardLimit() {
    _getCreditCardLimitRequest
        .safeAdd(GetCreditCardLimitUseCaseParams(secureCode: cardLimitsArguments.secureCode));
  }

  void updateCreditCardLimits(
      {required num atmWithdrawalPayment,
      required num merchantPayment,
      required num onlinePurchase,
      required num contactlessPayments}) {
    _updateCreditCardLimitsRequestSubject.safeAdd(CreditCardLimitsUpdateUseCaseParams(
      ///online purchase
      isOnlinePurchase: (onlinePurchase == 0 || onlinePurchase == 0.001) ? false : isOnlinePurchase,
      onlinePurchase: (onlinePurchase == 0 || onlinePurchase == 0.001)
          ? 0.001
          : isOnlinePurchase
              ? onlinePurchase
              : 0.001,

      ///merchant payment
      isMerchantsPayments: (merchantPayment == 0 || merchantPayment == 0.001) ? false : isMerchantPayments,
      merchantsPayments: (merchantPayment == 0 || merchantPayment == 0.001)
          ? 0.001
          : isMerchantPayments
              ? merchantPayment
              : 0.001,

      ///atm withdrawal
      isAtmWithdrawal: (atmWithdrawalPayment == 0 || atmWithdrawalPayment == 0.001) ? false : isAtmWithdrawal,
      atmWithdrawal: (atmWithdrawalPayment == 0 || atmWithdrawalPayment == 0.001)
          ? 0.001
          : isAtmWithdrawal
              ? atmWithdrawalPayment
              : 0.001,

      ///contactless payment
      isContactLessPayments:
          (contactlessPayments == 0 || contactlessPayments == 0.001) ? false : isContactLessPayments,
      contactlessPaymentLimit: (contactlessPayments == 0 || contactlessPayments == 0.001)
          ? 0.001
          : isContactLessPayments
              ? contactlessPayments
              : 0.001,

      secureCode: cardLimitsArguments.secureCode,
    ));
  }

  void showSaveButton() {
    bool show = false;
    if (atmWithdrawalValue != atmWithdrawalInitialValue ||
        merchantPaymentValue != merchantPaymentInitialValue ||
        onlinePurchaseValue != onlinePurchaseInitialValue ||
        contactlessPaymentsValue != contactlessPaymentsInitialValue ||
        isAtmWithdrawal != isAtmWithdrawalInitialValue ||
        isMerchantPayments != isMerchantPaymentsInitialValue ||
        isOnlinePurchase != isOnlinePurchaseInitialValue ||
        isContactLessPayments != isContactLessPaymentsInitialValue) {
      show = true;
    }
    updateShowSaveButtonValue(show);
  }

  void updateShowSaveButtonValue(bool value) {
    _showSaveButtonSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _getCreditCardLimitRequest.close();
    _getCreditCardLimitResponseSubject.close();
    _updateCreditCardLimitsRequestSubject.close();
    _updateCreditCardLimitsResponseSubject.close();

    super.dispose();
  }
}
