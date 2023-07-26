// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/cliq/approve_rtp_otp/approve_rtp_otp.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/manage_cliq/approve_rtp_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_page.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityTransactionViewModel extends BasePageViewModel {
  final PaymentActivityTransactionPageArgument paymentActivityTransactionPageArgument;

  ///---------------------------------------------------------------------------///

  ///payment period
  BehaviorSubject<String> _paymentPeriodResponse = BehaviorSubject();

  ///*--------------------[request-money-activity]---------------------->>>>>>>

  BehaviorSubject<RequestMoneyActivityParams> _requestMoneyActivityRequest = BehaviorSubject();

  BehaviorSubject<Resource<PaymentActivityResponse>> _requestMoneyActivityResponse = BehaviorSubject();

  RequestMoneyActivityUseCase _requestMoneyActivityUseCase;
  BehaviorSubject<String> _requestPeriodResponse = BehaviorSubject();

  ///transaction type
  BehaviorSubject<String> _transactionTypeResponse = BehaviorSubject();

  final ApproveRTPOtpUseCase _approveRTPOtpUseCase;

  PaymentActivityTransactionViewModel(this.paymentActivityTransactionPageArgument,
      this._requestMoneyActivityUseCase, this._approveRTPOtpUseCase) {
    _requestMoneyActivityRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _requestMoneyActivityUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _requestMoneyActivityResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            }

            // if (event.status == Status.ERROR) {
            //   if (event.appError!.type == ErrorType.ERROR_WHILE_REQUESTING_MONEY_ACTIVITY) {
            //   } else {
            //     showToastWithError(event.appError!);
            //   }
            // }
          },
        );
      },
    );

    getRequestMoneyActivity(true, 30, "All");

    _approveRTPOtpRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _approveRTPOtpUseCase.execute(params: value)).asFlow().listen(
          (event) {
            updateLoader();
            _approveRTPOtpResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<String> get transactionTypeResponseStream => _transactionTypeResponse.stream;

  Stream<String> get paymentPeriodResponseStream => _paymentPeriodResponse.stream;

  Stream<String> get requestMoneyPeriodResponse => _requestPeriodResponse.stream;

  Stream<Resource<PaymentActivityResponse>> get requestMoneyActivity => _requestMoneyActivityResponse.stream;

  void getRequestMoneyActivity(bool getToken, int FilterDays, String TransactionType) {
    _requestMoneyActivityRequest.safeAdd(RequestMoneyActivityParams(
        getToken: getToken, FilterDays: FilterDays, TransactionType: TransactionType));
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

  ///*--------------------[approve-otp]---------------------->>>>>>>
  ApproveRtpData approveRtpData = ApproveRtpData();

  PublishSubject<ApproveRTPOtpUseCaseParams> _approveRTPOtpRequest = PublishSubject();

  Stream<Resource<ApproveRTPOtp>> get approveRTPOtpStream => _approveRTPOtpResponse.stream;

  PublishSubject<Resource<ApproveRTPOtp>> _approveRTPOtpResponse = PublishSubject();

  void makeApproveRTPOtpRequest() {
    _approveRTPOtpRequest.safeAdd(ApproveRTPOtpUseCaseParams());
  }

  Color getColor(RequestMoneyActivityStatusEnum? value) {
    switch (value) {
      case RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case RequestMoneyActivityStatusEnum.CATEGORY_REJECTED:
        return AppColor.dark_brown;
      case RequestMoneyActivityStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;
      case RequestMoneyActivityStatusEnum.CATEGORY_EXPIRED:
        return AppColor.gray5;
      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}

class ApproveRtpData {
  final String amount;
  final String name;
  final String iban;
  final String statusInfo;
  final String custID;
  final String dbtrAcct;
  final String dbtrName;
  final String dbtrPstlAdr;
  final String dbtrRecordID;
  final String currency;

  final String dbtrAlias;
  final String cdtrBic;
  final String cdtrName;
  final String cdtrAcct;
  final String cdtrPstlAdr;
  final String cdtrRecordID;
  final String cdtrAlias;
  final String rgltryRptg;
  final String payRefNo;
  final String orgnlMsgId;
  final String ctgyPurp;
  final String rejectReason;
  final String rtpStatus;
  final String rejectADdInfo;

  ApproveRtpData({
    this.amount = '',
    this.name = '',
    this.iban = '',
    this.statusInfo = '',
    this.custID = '',
    this.dbtrAcct = '',
    this.dbtrName = '',
    this.dbtrPstlAdr = '',
    this.dbtrRecordID = '',
    this.currency = '',
    this.dbtrAlias = '',
    this.cdtrBic = '',
    this.cdtrName = '',
    this.cdtrAcct = '',
    this.cdtrPstlAdr = '',
    this.cdtrRecordID = '',
    this.cdtrAlias = '',
    this.rgltryRptg = '',
    this.payRefNo = '',
    this.orgnlMsgId = '',
    this.ctgyPurp = '',
    this.rejectReason = '',
    this.rtpStatus = '',
    this.rejectADdInfo = '',
  });
}
