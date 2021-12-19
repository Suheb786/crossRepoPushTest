import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/payment_activity_item.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityTransactionViewModel extends BasePageViewModel {
  PaymentActivityTransactionUseCase _useCase;

  BehaviorSubject<List<PaymentActivityItem>> _transactionListSubject =
      BehaviorSubject();

  Stream<List<PaymentActivityItem>> get transactionListStream =>
      _transactionListSubject.stream;

  List<PaymentActivityItem> transactionList = [
    PaymentActivityItem(
        createdAt: "12 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Sent"),
    PaymentActivityItem(
        createdAt: "11 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Request"),
    PaymentActivityItem(
        createdAt: "12 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Sent"),
    PaymentActivityItem(
        createdAt: "11 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Request"),
  ];

  PaymentActivityTransactionViewModel(this._useCase);
}
