import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_page_view.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../main/navigation/route_paths.dart';

class SendAmountToContactSuccessPage extends BasePage<SendAmountToContactSuccessViewModel> {
  final TransferSuccessContent arguments;

  SendAmountToContactSuccessPage({required this.arguments});

  @override
  SendAmountToContactSuccessPageState createState() => SendAmountToContactSuccessPageState();
}

class SendAmountToContactSuccessPageState
    extends BaseStatefulPage<SendAmountToContactSuccessViewModel, SendAmountToContactSuccessPage> {
  @override
  ProviderBase provideBase() {
    return sendAmountToContactSuccessViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, SendAmountToContactSuccessViewModel model) {
    return SendAmountToContactSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(SendAmountToContactSuccessViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}

// class SendAmountToSuccessPageArguments {
//   final TransferResponse transferResponse;
//   final String otpCode;
//   final String beneficiaryImage;
//   final bool isFriend;
//   final String memo;
//
//   SendAmountToSuccessPageArguments(
//       {required this.transferResponse,
//       required this.otpCode,
//       required this.beneficiaryImage,
//       required this.isFriend,
//       required this.memo});
// }
