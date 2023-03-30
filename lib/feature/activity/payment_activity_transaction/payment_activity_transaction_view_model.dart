// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityTransactionViewModel extends BasePageViewModel {
  ///---------------------------------------------------------------------------///
  /// payment activity subject holder
  PublishSubject<PaymentActivityTransactionUseCaseParams> _paymentActivityTransactionRequest =
      PublishSubject();

  PublishSubject<Resource<PaymentActivityResponse>> _paymentActivityTransactionResponse = PublishSubject();

  ///payment period
  BehaviorSubject<String> _paymentPeriodResponse = BehaviorSubject();

  ///*--------------------[request-money-activity]---------------------->>>>>>>

  BehaviorSubject<RequestMoneyActivityParams> _requestMoneyActivityRequest = BehaviorSubject();

  BehaviorSubject<Resource<PaymentActivityResponse>> _requestMoneyActivityResponse = BehaviorSubject();

  RequestMoneyActivityUseCase _requestMoneyActivityUseCase;
  BehaviorSubject<String> _requestPeriodResponse = BehaviorSubject();

  ///transaction type
  BehaviorSubject<String> _transactionTypeResponse = BehaviorSubject();

  PaymentActivityTransactionUseCase _useCase;

  PaymentActivityTransactionViewModel(
    this._useCase,
    this._requestMoneyActivityUseCase,
  ) {
    _requestMoneyActivityRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _requestMoneyActivityUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _requestMoneyActivityResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              if (event.appError!.type == ErrorType.ERROR_WHILE_REQUESTING_MONEY_ACTIVITY) {
              } else {
                showToastWithError(event.appError!);
              }
            }
          },
        );
      },
    );

    _paymentActivityTransactionRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _paymentActivityTransactionResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    getRequestMoneyActivity(true, 30, "All");
  }

  @override
  void dispose() {
    _paymentActivityTransactionResponse.close();
    _paymentActivityTransactionRequest.close();
    super.dispose();
  }

  Stream<Resource<PaymentActivityResponse>> get paymentActivityTransactionResponse =>
      _paymentActivityTransactionResponse.stream;

  Stream<String> get transactionTypeResponseStream => _transactionTypeResponse.stream;

  Stream<String> get paymentPeriodResponseStream => _paymentPeriodResponse.stream;

  Stream<String> get requestMoneyPeriodResponse => _requestPeriodResponse.stream;

  Stream<Resource<PaymentActivityResponse>> get requestMoneyActivity => _requestMoneyActivityResponse.stream;

  void getRequestMoneyActivity(bool getToken, int FilterDays, String TransactionType) {
    _requestMoneyActivityRequest.safeAdd(RequestMoneyActivityParams(
        getToken: getToken, FilterDays: FilterDays, TransactionType: TransactionType));
  }

  void getPaymentActivity(int filterDays) {
    _paymentActivityTransactionRequest
        .safeAdd(PaymentActivityTransactionUseCaseParams(filterDays: filterDays));
  }

  int filterDays = 30;

  String transactionType = 'All';

  void updateTransactionType(String value) {
    _transactionTypeResponse.safeAdd(value);
    transactionType = getTransactionType(value);

    getRequestMoneyActivity(true, filterDays, transactionType);
  }

  void updatePaymentPeriod(String value) {
    _paymentPeriodResponse.safeAdd(value);
    filterDays = getFilterDays(value);
    getRequestMoneyActivity(true, filterDays, transactionType);
  }

  int getFilterDays(String value) {
    switch (value) {
      case "Last 30 days":
        return 30;
      case "Last 3 months":
        return 90;
      case "Last 6 months":
        return 180;
      case "آخر 30 يوم":
        return 30;
      case "آخر 3 اشهر":
        return 90;
      case "آخر 6 اشهر":
        return 180;
      default:
        return 180;
    }
  }

  String getTransactionType(String value) {
    switch (value) {
      case "All Transactions":
        return 'All';
      case "From Me":
        return 'O';
      case "From Others":
        return 'I';
      case "كل الحركات":
        return 'All';
      case "لي":
        return 'O';
      case "من الآخرين":
        return 'I';
      default:
        return 'All';
    }
  }
}
