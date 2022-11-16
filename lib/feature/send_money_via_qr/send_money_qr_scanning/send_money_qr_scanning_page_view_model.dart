import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/transfer_usecase.dart';
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
  final CheckSendMoneyUseCase _checkSendMoneyUseCase;
  final TransferUseCase _transferUseCase;

  final SendMoneyQRScanningArguments arguments;

  ///controllers and keys
  final TextEditingController payFromController = TextEditingController();
  final GlobalKey<AppTextFieldState> payFromKey = GlobalKey(debugLabel: "payFrom");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  ///----------------Check send money---------------///

  PublishSubject<CheckSendMoneyUseCaseParams> _checkSendMoneyRequest = PublishSubject();

  PublishSubject<Resource<CheckSendMoneyResponse>> _checkSendMoneyResponse = PublishSubject();

  Stream<Resource<CheckSendMoneyResponse>> get checkSendMoneyStream => _checkSendMoneyResponse.stream;

  void checkSendMoney() {
    _checkSendMoneyRequest.safeAdd(CheckSendMoneyUseCaseParams(
        toAccount: arguments.accountNo, toAmount: double.parse(arguments.amount)));
  }

  ///----------------Check send money---------------///

  ///----------------Transfer money---------------///

  PublishSubject<TransferUseCaseParams> _transferRequest = PublishSubject();

  PublishSubject<Resource<TransferSuccessResponse>> _transferResponse = PublishSubject();

  Stream<Resource<TransferSuccessResponse>> get transferStream => _transferResponse.stream;

  void transfer(TransferResponse transferResponse) {
    _transferRequest.safeAdd(TransferUseCaseParams(
        otpCode: '576824',
        toAmount: transferResponse.toAmount,
        toAccount: transferResponse.toAccount,
        limit: 2000,
        memo: '111311110',
        //Friend or family
        isFriend: false,
        nickName: "",
        transferType: transferResponse.transferType,
        localEq: transferResponse.localEq,
        beneficiaryId: transferResponse.beneficiaryId,
        beneficiaryImage: "",
        type: "",
        detCustomerType: ""));
  }

  ///----------------Transfer money---------------///
  SendMoneyQrScanningPageViewModel(this.arguments, this._checkSendMoneyUseCase, this._transferUseCase) {
    _checkSendMoneyRequest.listen((value) {
      RequestManager(value, createCall: () => _checkSendMoneyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkSendMoneyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _transferRequest.listen((value) {
      RequestManager(value, createCall: () => _transferUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferResponse.safeAdd(event);
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
