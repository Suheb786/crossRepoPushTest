import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/usecase/payment/verify_qr_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rxdart/rxdart.dart';

class QrScanningScreenPageViewModel extends BasePageViewModel {
  final VerifyQRUseCase _verifyQRUseCase;
  Barcode? result;

  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  ///---------------Verify QR----------------------///
  PublishSubject<VerifyQRUseCaseParams> _verifyQRRequest = PublishSubject();

  PublishSubject<Resource<VerifyQrResponse>> _verifyQRResponse = PublishSubject();

  Stream<Resource<VerifyQrResponse>> get verifyQRStream => _verifyQRResponse.stream;

  void verifyQR({required String requestId}) {
    _verifyQRRequest.safeAdd(VerifyQRUseCaseParams(requestId: requestId, source: 'Q'));
  }

  ///---------------Verify QR----------------------///

  QrScanningScreenPageViewModel(this._verifyQRUseCase) {
    _verifyQRRequest.listen((value) {
      RequestManager(value, createCall: () => _verifyQRUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyQRResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void extractResult(BuildContext context, Barcode result) async {
    if (result.code != null && (result.code ?? '').isNotEmpty) {
      ///API CALL(VERIFY QR)
      verifyQR(requestId: result.code ?? '');
    }
  }
}
