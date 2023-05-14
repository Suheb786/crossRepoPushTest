import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:domain/usecase/payment/transfer_qr_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SendMoneyQrScanningPageViewModel extends BasePageViewModel {
  final TransferQRUseCase _transferQRUseCase;

  final SendMoneyQRScanningArguments arguments;

  ///controllers and keys
  final TextEditingController payFromController = TextEditingController();
  final GlobalKey<AppTextFieldState> payFromKey = GlobalKey(debugLabel: "payFrom");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  ///----------------Transfer QR Usecase---------------///

  PublishSubject<TransferQRUseCaseParams> _transferQRRequest = PublishSubject();

  PublishSubject<Resource<QRTransferResponse>> _transferQRResponse = PublishSubject();

  Stream<Resource<QRTransferResponse>> get transferQRStream => _transferQRResponse.stream;

  void transferQR() {
    _transferQRRequest.safeAdd(TransferQRUseCaseParams(
        toAccount: arguments.accountNo, toAmount: arguments.amount, requestId: arguments.requestId));
  }

  ///----------------Transfer QR Usecase---------------///

  SendMoneyQrScanningPageViewModel(this.arguments, this._transferQRUseCase) {
    _transferQRRequest.listen((value) {
      RequestManager(value, createCall: () => _transferQRUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferQRResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate() {
    if (payFromController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}
