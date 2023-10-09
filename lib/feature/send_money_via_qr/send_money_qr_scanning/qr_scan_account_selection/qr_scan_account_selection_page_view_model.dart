import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/usecase/payment/qr_scan_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class QRScanAccountSelectionPageViewModel extends BasePageViewModel {
  final QRScanOTPUseCase _qrScanOTPUseCase;
  Account selectedAccount = Account();

  ///-----------------------------------------generate otp----------------------------------------------///
  PublishSubject<QRScanOTPUseCaseParams> _generateOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _generateOtpResponse = PublishSubject();

  Stream<Resource<bool>> get generateOtpStream => _generateOtpResponse.stream;

  void generateOtp() {
    _generateOtpRequest.safeAdd(QRScanOTPUseCaseParams());
  }

  ///-----------------------------------------generate otp----------------------------------------------///

  ///controllers and keys
  final TextEditingController payFromController = TextEditingController();
  final GlobalKey<AppTextFieldState> payFromKey = GlobalKey(debugLabel: "payFrom");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  QRScanAccountSelectionPageViewModel(this._qrScanOTPUseCase) {
    _generateOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _qrScanOTPUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _generateOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate() {
    if (selectedAccount.accountNo?.isNotEmpty == true) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}
