import 'package:domain/constants/enum/statement_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_view_model.dart';

class DownloadTransactionPage extends BasePage<DownloadTransactionViewModel> {
  final DownloadStatementArguments _arguments;

  DownloadTransactionPage(this._arguments);

  @override
  DownloadTransactionPageState createState() => DownloadTransactionPageState();
}

class DownloadTransactionPageState
    extends BaseStatefulPage<DownloadTransactionViewModel, DownloadTransactionPage> {
  @override
  ProviderBase provideBase() {
    return downloadTransactionViewModelProvider.call(widget._arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return widget._arguments.statementType == StatementType.Credit
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, DownloadTransactionViewModel model) {
    return DownloadTransactionPageView(provideBase());
  }
}

class DownloadStatementArguments {
  final StatementType statementType;
  final String transactionDate;
  final String cardId;

  DownloadStatementArguments({required this.statementType, required this.transactionDate, this.cardId: ''});
}
