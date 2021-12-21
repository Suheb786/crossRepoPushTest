import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/download_card_transaction/download_transaction_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/download_card_transaction/download_transaction_view_model.dart';

class DownloadTransactionPage extends BasePage<DownloadTransactionViewModel> {
  String? type;
  String? transactionDate;

  DownloadTransactionPage(this.type, this.transactionDate);

  @override
  DownloadTransactionPageState createState() => DownloadTransactionPageState();
}

class DownloadTransactionPageState extends BaseStatefulPage<
    DownloadTransactionViewModel, DownloadTransactionPage> {
  @override
  ProviderBase provideBase() {
    return downloadTransactionViewModelProvider
        .call([widget.type!, widget.transactionDate!]);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return widget.type == "Card"
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, DownloadTransactionViewModel model) {
    return DownloadTransactionPageView(provideBase());
  }
}
