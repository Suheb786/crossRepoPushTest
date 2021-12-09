import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';

class PaymentHomePageView extends BasePageViewWidget<PaymentHomeViewModel> {
  PaymentHomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Container(),
    );
  }
}
