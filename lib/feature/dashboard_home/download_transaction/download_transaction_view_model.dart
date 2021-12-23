import 'package:domain/usecase/dashboard/download_card_transaction_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class DownloadTransactionViewModel extends BasePageViewModel {
  DownloadCardTransactionUseCase _useCase;

  String? type;

  String? transactionDate;

  DownloadTransactionViewModel(this._useCase, arguments) {
    this.type = arguments[0];
    this.transactionDate = arguments[1];
  }
}
