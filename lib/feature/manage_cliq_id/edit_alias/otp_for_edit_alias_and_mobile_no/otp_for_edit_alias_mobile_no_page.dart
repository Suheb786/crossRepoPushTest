import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'otp_for_edit_alias_mobile_no_page_view.dart';
import 'otp_for_edit_alias_mobile_no_page_view_model.dart';

class OtpForEditAliasAndMobileNoPage extends BasePage<OtpForEditAliasAndMobileNoPageViewModel> {
  final OtpForEditAliasAndMobileNoPageArguments _arguments;

  OtpForEditAliasAndMobileNoPage(this._arguments);

  @override
  OtpForEditAliasAndMobileNoPageState createState() => OtpForEditAliasAndMobileNoPageState();
}

class OtpForEditAliasAndMobileNoPageState
    extends BaseStatefulPage<OtpForEditAliasAndMobileNoPageViewModel, OtpForEditAliasAndMobileNoPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  OtpForEditAliasAndMobileNoPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return otpForEditAliasAndMobileNoPageViewModelProvider.call(widget._arguments);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(OtpForEditAliasAndMobileNoPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, OtpForEditAliasAndMobileNoPageViewModel model) {
    return OtpForEditAliasAndMobileNoPageView(provideBase());
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

class OtpForEditAliasAndMobileNoPageArguments {
  final EditCliqOtp data;
  final String aliasId;
  final String aliasValue;
  final String mobileNumber;
  final String mobileCode;
  final bool isAlias;

  OtpForEditAliasAndMobileNoPageArguments({
    required this.mobileNumber,
    required this.mobileCode,
    required this.data,
    required this.aliasId,
    required this.aliasValue,
    required this.isAlias,
  });
}
