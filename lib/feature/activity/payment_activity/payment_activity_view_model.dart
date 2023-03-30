import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PaymentActivityViewModel extends BasePageViewModel {
  Color getColor(RequestMoneyActivityStatusEnum? value) {
    switch (value) {
      case RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case RequestMoneyActivityStatusEnum.CATEGORY_REJECTED:
        return AppColor.dark_brown;
      case RequestMoneyActivityStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }

  // PaymentActivityTransactionUseCase _useCase;
  //
  // PublishSubject<PaymentActivityTransactionUseCaseParams>
  // _paymentActivityTransactionRequest = PublishSubject();
  //
  // PublishSubject<Resource<PaymentActivityResponse>>
  // _paymentActivityTransactionResponse = PublishSubject();
  //
  // Stream<Resource<PaymentActivityResponse>>
  // get paymentActivityTransactionResponse =>
  //     _paymentActivityTransactionResponse.stream;
  //
  // PaymentActivityViewModel(this._useCase){
  //   _paymentActivityTransactionRequest.listen((value) {
  //     RequestManager(value, createCall: () => _useCase.execute(params: value))
  //         .asFlow()
  //         .listen((event) {
  //       updateLoader();
  //       _paymentActivityTransactionResponse.safeAdd(event);
  //       if (event.status == Status.ERROR) {
  //         showErrorState();
  //       }
  //     });
  //   });
  //   getPaymentActivity();
  // }
  //
  //
  // void getPaymentActivity() {
  //   _paymentActivityTransactionRequest.safeAdd(PaymentActivityTransactionUseCaseParams());
  // }
  //
  // @override
  // void dispose() {
  //   _paymentActivityTransactionRequest.close();
  //   _paymentActivityTransactionResponse.close();
  //   super.dispose();
  // }
}
