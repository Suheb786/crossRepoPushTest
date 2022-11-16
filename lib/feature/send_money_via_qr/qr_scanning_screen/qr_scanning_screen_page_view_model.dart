import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
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

  void extractResult(BuildContext context, Barcode result) {
    if (result.code != null && (result.code ?? '').isNotEmpty) {
      List<String> data = result.code!.split('%');
      if (data.length == 4) {
        DateTime qrDate = DateTime.parse(data[3]);
        debugPrint('QR Date ---->$qrDate');
        final currentDate = DateTime.now();
        final difference = currentDate.difference(qrDate).inHours;
        if (difference > 1) {
          showToastWithError(
              AppError(type: ErrorType.QR_EXPIRED, error: ErrorInfo(message: ''), cause: Exception()));
          controller?.resumeCamera();
        } else {
          Navigator.pushReplacementNamed(context, RoutePaths.SendMoneyQrScanning,
              arguments: SendMoneyQRScanningArguments(
                  amount: data[2], accountHolderName: data[0], accountNo: data[1]));
        }
      } else {
        showToastWithError(
            AppError(type: ErrorType.QR_INVALID, error: ErrorInfo(message: ''), cause: Exception()));
        controller?.resumeCamera();
      }
    }
  }
}
