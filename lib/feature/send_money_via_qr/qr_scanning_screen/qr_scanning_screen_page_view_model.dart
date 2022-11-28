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

  void extractResult(BuildContext context, Barcode result) async {
    if (result.code != null && (result.code ?? '').isNotEmpty) {
      List<String> data = result.code!.split('%');
      if (data.length == 4) {
        DateTime qrDate = DateTime.parse(data[3]);
        debugPrint('QR Date ---->$qrDate');
        final currentDate = DateTime.now();
        final difference = currentDate.difference(qrDate).inMinutes;
        debugPrint('QR Date difference ---->$difference');
        debugPrint('current date ---->$currentDate');
        if (difference >= 30) {
          showToastWithError(
              AppError(type: ErrorType.QR_EXPIRED, error: ErrorInfo(message: ''), cause: Exception()));
          await Future.delayed(const Duration(milliseconds: 300));
          controller?.resumeCamera();
          Navigator.pop(context);
        } else {
          Navigator.pushReplacementNamed(context, RoutePaths.SendMoneyQrScanning,
              arguments: SendMoneyQRScanningArguments(
                  amount: data[2], accountHolderName: data[0], accountNo: data[1]));
        }
      } else {
        showToastWithError(
            AppError(type: ErrorType.QR_INVALID, error: ErrorInfo(message: ''), cause: Exception()));
        await Future.delayed(const Duration(milliseconds: 300));
        controller?.resumeCamera();
        Navigator.pop(context);
      }
    }
  }
}
