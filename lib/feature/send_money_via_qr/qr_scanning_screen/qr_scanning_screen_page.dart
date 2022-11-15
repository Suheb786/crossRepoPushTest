import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/qr_scanning_screen/qr_scanning_screen_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/qr_scanning_screen/qr_scanning_screen_page_view_model.dart';

class QrScanningScreenPage extends BasePage<QrScanningScreenPageViewModel> {
  @override
  QrScanningScreenPageState createState() => QrScanningScreenPageState();
}

class QrScanningScreenPageState extends BaseStatefulPage<
    QrScanningScreenPageViewModel, QrScanningScreenPage> {
  @override
  ProviderBase provideBase() {
    return qrScanningScreenViewModelProvider;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      getViewModel().controller!.pauseCamera();
    }
    getViewModel().controller!.resumeCamera();
  }

  @override
  Widget buildView(BuildContext context, QrScanningScreenPageViewModel model) {
    return QrScanningScreenPageView(provideBase());
  }
}
