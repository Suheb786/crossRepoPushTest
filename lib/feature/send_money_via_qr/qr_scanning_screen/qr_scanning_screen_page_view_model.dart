import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanningScreenPageViewModel extends BasePageViewModel {
  Barcode? result;

  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
