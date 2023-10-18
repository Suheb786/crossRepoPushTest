import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_account_selection/qr_scan_account_selection_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_account_selection/qr_scan_account_selection_page_view_model.dart';

class QRScanAccountSelectionPage extends BasePage<QRScanAccountSelectionPageViewModel> {
  @override
  QRScanAccountSelectionPageState createState() => QRScanAccountSelectionPageState();
}

class QRScanAccountSelectionPageState
    extends BaseStatefulPage<QRScanAccountSelectionPageViewModel, QRScanAccountSelectionPage> {
  @override
  ProviderBase provideBase() {
    return qrScanAccountSelectionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, QRScanAccountSelectionPageViewModel model) {
    return QRScanAccountSelectionPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(QRScanAccountSelectionPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(sendMoneyQrScanningViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
