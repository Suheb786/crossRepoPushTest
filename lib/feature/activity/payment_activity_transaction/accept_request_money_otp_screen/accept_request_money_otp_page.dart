import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'accept_request_money_otp_page_view.dart';
import 'accept_request_money_otp_page_view_model.dart';

class AcceptRequestMoneyOtpPage extends BasePage<AcceptRequestMoneyOtpPageViewModel> {
  final AcceptRequestMoneyOtpPageArgument argument;

  AcceptRequestMoneyOtpPage(this.argument);

  @override
  AcceptRequestMoneyOtpPageState createState() => AcceptRequestMoneyOtpPageState();
}

class AcceptRequestMoneyOtpPageState
    extends BaseStatefulPage<AcceptRequestMoneyOtpPageViewModel, AcceptRequestMoneyOtpPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  AcceptRequestMoneyOtpPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return acceptRequestMoneyOtpPageViewModelProvider.call(widget.argument);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(AcceptRequestMoneyOtpPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, AcceptRequestMoneyOtpPageViewModel model) {
    return AcceptRequestMoneyOtpPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      debugPrint('inside signature---->$signature');
    });
  }

  @override
  void codeUpdated() {
    getViewModel().otpController.text = code!;
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }
}

class AcceptRequestMoneyOtpPageArgument {
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
  final String OrgnlMsgId;
  final String CtgyPurp;
  final String rejectReason;
  final String rtpStatus;
  final String rejectADdInfo;

  AcceptRequestMoneyOtpPageArgument({
    required this.amount,
    required this.name,
    required this.statusInfo,
    required this.iban,
    required this.custID,
    required this.dbtrAcct,
    required this.dbtrName,
    required this.dbtrPstlAdr,
    required this.dbtrRecordID,
    required this.currency,
    required this.dbtrAlias,
    required this.cdtrBic,
    required this.cdtrName,
    required this.cdtrAcct,
    required this.cdtrPstlAdr,
    required this.cdtrRecordID,
    required this.cdtrAlias,
    required this.rgltryRptg,
    required this.payRefNo,
    required this.OrgnlMsgId,
    required this.CtgyPurp,
    required this.rejectReason,
    required this.rtpStatus,
    required this.rejectADdInfo,
  });
}
