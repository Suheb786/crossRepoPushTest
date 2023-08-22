import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/resource.dart';
import '../../../utils/status.dart';

class PurchaseNowDetailViewModel extends BasePageViewModel {
  final PurchaseNowArgument argument;

  final GetSettlementAmountUseCase getSettlementAmountUseCase;

  ///get settlement amount
  PublishSubject<GetSettlementAmountUseCaseParams> _getSettlementAmountRequest = PublishSubject();
  PublishSubject<Resource<GetSettlementAmount>> _getSettlementAmountResponse = PublishSubject();

  Stream<Resource<GetSettlementAmount>> get getSettlementAmountStream => _getSettlementAmountResponse.stream;

  PurchaseNowDetailViewModel(
    this.getSettlementAmountUseCase,
    this.argument,
  ) {
    _getSettlementAmountRequest.listen((value) {
      RequestManager(value, createCall: () => getSettlementAmountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getSettlementAmountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          settlementAmount = event.data?.content ?? 0.0;
        }
      });
    });
  }

  double settlementAmount = 0;

  void getSettlementAmmount({
    required String? Amount,
    required String? FromCurrency,
    required String? ToCurrency,
  }) {
    _getSettlementAmountRequest.safeAdd(GetSettlementAmountUseCaseParams(
        Amount: Amount, FromCurrency: FromCurrency, ToCurrency: ToCurrency, GetToken: true));
  }
}
