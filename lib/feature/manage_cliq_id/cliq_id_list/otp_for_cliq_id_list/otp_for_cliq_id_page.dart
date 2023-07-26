import 'package:domain/constants/enum/cliq_list_action_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'otp_for_cliq_id_page_view.dart';
import 'otp_for_cliq_id_page_view_model.dart';

class OtpForCliqIdListPage extends BasePage<OtpForCliqIdListPageViewModel> {
  final OtpForCliqIdListPageArguments _arguments;

  OtpForCliqIdListPage(this._arguments);

  @override
  OtpForCliqIdListPageState createState() => OtpForCliqIdListPageState();
}

class OtpForCliqIdListPageState extends BaseStatefulPage<OtpForCliqIdListPageViewModel, OtpForCliqIdListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  OtpForCliqIdListPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return otpForCliqIdListPageViewModelProvider.call(widget._arguments);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(OtpForCliqIdListPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, OtpForCliqIdListPageViewModel model) {
    return OtpForCliqIdListPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    listenForCode();
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

class OtpForCliqIdListPageArguments {
  final CliqListActionTypeEnum cliqListActionTypeEnum;
  final String aliasId;
  final String accountId;
  final String aliasName;
  final bool isAlias;
  final String linkType;
  final String mobileCode;
  final String mobileNumber;

  OtpForCliqIdListPageArguments(
      {required this.cliqListActionTypeEnum,
      required this.aliasId,
      required this.accountId,
      required this.aliasName,
      required this.mobileCode,
      required this.mobileNumber,
      this.isAlias = false,
      this.linkType = ''});
}
