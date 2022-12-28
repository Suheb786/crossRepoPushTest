// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class PaymentActivityTransactionViewModel extends BasePageViewModel {
  List<RequestMoneyActivityList> dummyList = [
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "98435905349805845894538904539804532890",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_PENDING,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Faiz",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "09-0890-8-09",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_PENDING,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Mohammad Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_EXPIRED,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Mohammad Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_REJECTED,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
  ];

  //*--------------------[accept-request-money-activity]---------------------->>>>>>>

  PublishSubject<ApproveRTPRequestUseCaseParam> _approveRTPRequest =
      PublishSubject();

  ApproveRTPRequestUseCase _approveRTPRequestUseCase;
  PublishSubject<Resource<bool>> _approveRTPResponse = PublishSubject();

  /// payment activity subject holder
  PublishSubject<PaymentActivityTransactionUseCaseParams>
      _paymentActivityTransactionRequest = PublishSubject();

  PublishSubject<Resource<PaymentActivityResponse>>
      _paymentActivityTransactionResponse = PublishSubject();

  ///payment period
  BehaviorSubject<String> _paymentPeriodResponse = BehaviorSubject();

//*--------------------[request-money-activity]---------------------->>>>>>>

  BehaviorSubject<RequestMoneyActivityParams> _requestMoneyActivityRequest =
      BehaviorSubject();

  BehaviorSubject<Resource<RequestMoneyActivity>>
      _requestMoneyActivityResponse = BehaviorSubject();

  RequestMoneyActivityUseCase _requestMoneyActivityUseCase;
  BehaviorSubject<String> _requestPeriodResponse = BehaviorSubject();

  ///transaction type
  BehaviorSubject<String> _transactionTypeResponse = BehaviorSubject();

  PaymentActivityTransactionUseCase _useCase;

  PaymentActivityTransactionViewModel(
    this._useCase,
    this._requestMoneyActivityUseCase,
    this._approveRTPRequestUseCase,
  ) {
    _requestMoneyActivityRequest.listen(
      (value) {
        RequestManager(value,
                createCall: () =>
                    _requestMoneyActivityUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _requestMoneyActivityResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              // _requestMoneyActivityResponse.safeAdd(Resource.success(
              //     data: RequestMoneyActivity(
              //         dummyList))); //Todo : - dummy List remove on error
              showToastWithError(event.appError!);
            }
          },
        );
      },
    );
    _approveRTPRequest.listen(
      (value) {
        RequestManager(value,
                createCall: () =>
                    _approveRTPRequestUseCase.execute(params: value))
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

    _paymentActivityTransactionRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _paymentActivityTransactionResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    getRequestMoneyActivity(true);
    // getPaymentActivity(30);
  }

  @override
  void dispose() {
    _paymentActivityTransactionResponse.close();
    _paymentActivityTransactionRequest.close();
    super.dispose();
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

  Stream<Resource<bool>> get approveRTPRequestStream =>
      _approveRTPResponse.stream;

  Stream<Resource<PaymentActivityResponse>>
      get paymentActivityTransactionResponse =>
          _paymentActivityTransactionResponse.stream;

  Stream<String> get transactionTypeResponseStream =>
      _transactionTypeResponse.stream;

  Stream<String> get paymentPeriodResponseStream =>
      _paymentPeriodResponse.stream;

  Stream<String> get requestMoneyPeriodResponse =>
      _requestPeriodResponse.stream;

  Stream<Resource<RequestMoneyActivity>> get requestMoneyActivity =>
      _requestMoneyActivityResponse.stream;

  void getRequestMoneyActivity(bool getToken) {
    _requestMoneyActivityRequest.safeAdd(RequestMoneyActivityParams(getToken));
  }

  void getPaymentActivity(int filterDays) {
    _paymentActivityTransactionRequest.safeAdd(
        PaymentActivityTransactionUseCaseParams(filterDays: filterDays));
  }

  void updateTransactionType(String value) {
    _transactionTypeResponse.safeAdd(value);
  }

  void updatePaymentPeriod(String value) {
    _paymentPeriodResponse.safeAdd(value);
    getPaymentActivity(getFilterDays(value));
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

  Color getColor(RequestMoneyActivityStatusEnum? value) {
    switch (value) {
      case RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case RequestMoneyActivityStatusEnum.CATEGORY_REJECTED:
        return AppColor.vividRed;
      case RequestMoneyActivityStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;
      case RequestMoneyActivityStatusEnum.CATEGORY_EXPIRED:
        return AppColor.vividRed;
      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
