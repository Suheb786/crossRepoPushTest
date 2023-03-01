import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page_view.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page_view_model.dart';

class QrScreenPage extends BasePage<QrScreenPageViewModel> {
  final QrScreenPageArguments arguments;

  QrScreenPage(this.arguments);

  @override
  QrScreenPageState createState() => QrScreenPageState();
}

class QrScreenPageState extends BaseStatefulPage<QrScreenPageViewModel, QrScreenPage> {
  @override
  ProviderBase provideBase() {
    return qrScreenViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, QrScreenPageViewModel model) {
    return QrScreenPageView(provideBase());
  }
}

class QrScreenPageArguments {
  final Account account;
  final String requestAmt;
  final String requestId;

  QrScreenPageArguments(this.account, this.requestAmt, this.requestId);
}
