import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_page_view.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';

class RjBookingPurchasePage extends BasePage<RjBookingPurchasePageViewModel> {
  final RjBookingPurchasePageArgument arguments;

  RjBookingPurchasePage({required this.arguments});

  @override
  RjBookingPurchasePageState createState() => RjBookingPurchasePageState();
}

class RjBookingPurchasePageState
    extends BaseStatefulPage<RjBookingPurchasePageViewModel, RjBookingPurchasePage> {
  @override
  ProviderBase provideBase() {
    return rjBookingPurchasePageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, RjBookingPurchasePageViewModel model) {
    return RjBookingPurchasePageView(provideBase());
  }
}

class RjBookingPurchasePageArgument {
  String amount;
  RjBookingPurchasePageArgument(this.amount);
}
