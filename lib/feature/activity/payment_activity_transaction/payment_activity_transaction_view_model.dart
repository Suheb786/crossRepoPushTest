// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_to_pay_result_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityTransactionViewModel extends BasePageViewModel {
  ///*--------------------[accept-request-money-activity]---------------------->>>>>>>

  PublishSubject<ApproveRTPRequestUseCaseParam> _approveRTPRequest = PublishSubject();

  ApproveRTPRequestUseCase _approveRTPRequestUseCase;
  PublishSubject<Resource<bool>> _approveRTPResponse = PublishSubject();

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

  ///[reject-request-money-activity]

  PublishSubject<RequestToPayResultUsecaseParams> _requestToPayResultRequest = PublishSubject();

  PublishSubject<Resource<bool>> _requestToPayResultResponse = PublishSubject();
  RequestToPayResultUseCase _requestToPayResultUseCase;

  ///transaction type
  BehaviorSubject<String> _transactionTypeResponse = BehaviorSubject();

  PaymentActivityTransactionUseCase _useCase;

  PaymentActivityTransactionViewModel(this._useCase, this._requestMoneyActivityUseCase,
      this._approveRTPRequestUseCase, this._requestToPayResultUseCase) {
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
    _approveRTPRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _approveRTPRequestUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _approveRTPResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            }
          },
        );
      },
    );

    _requestToPayResultRequest.listen((value) {
      RequestManager(value, createCall: () {
        return _requestToPayResultUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _requestToPayResultResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

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

  Stream<Resource<bool>> get requestToPayResultStream => _requestToPayResultResponse.stream;

  void requestToPayResult({
    required final String CustID,
    required final String OrgnlMsgId,
    required final String RTPStatus,
    required final String RejectReason,
    required final String RejectADdInfo,
  }) {
    _requestToPayResultRequest.safeAdd(RequestToPayResultUsecaseParams(
        CustID: CustID,
        OrgnlMsgId: OrgnlMsgId,
        RTPStatus: RTPStatus,
        RejectReason: RejectReason,
        RejectADdInfo: RejectADdInfo));
  }

  void approveRTPRequest({
    required final String custID,
    required final String dbtrAcct,
    required final String dbtrName,
    required final String dbtrPstlAdr,
    required final String dbtrRecordID,
    required final String currency,
    required final String amount,
    required final String dbtrAlias,
    required final String cdtrBic,
    required final String cdtrName,
    required final String cdtrAcct,
    required final String cdtrPstlAdr,
    required final String cdtrRecordID,
    required final String cdtrAlias,
    required final String rgltryRptg,
    required final String payRefNo,
    required final String rejectReason,
    required final String rtpStatus,
    required final String rejectADdInfo,
    required final bool getToken,
  }) {
    _approveRTPRequest.safeAdd(
      ApproveRTPRequestUseCaseParam(
          custID: custID,
          dbtrAcct: dbtrAcct,
          dbtrName: dbtrName,
          dbtrPstlAdr: dbtrPstlAdr,
          dbtrRecordID: dbtrRecordID,
          dbtrAlias: dbtrAlias,
          currency: currency,
          amount: amount,
          cdtrBic: cdtrBic,
          cdtrName: cdtrName,
          cdtrAcct: cdtrAcct,
          cdtrPstlAdr: cdtrPstlAdr,
          cdtrRecordID: cdtrRecordID,
          cdtrAlias: cdtrAlias,
          rgltryRptg: rgltryRptg,
          payRefNo: payRefNo,
          rejectReason: rejectReason,
          rtpStatus: rtpStatus,
          rejectADdInfo: rejectADdInfo,
          GetToken: getToken),
    );
  }

  Stream<Resource<bool>> get approveRTPRequestStream => _approveRTPResponse.stream;

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
