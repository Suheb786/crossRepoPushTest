import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page_view.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

import '../../../../base/base_page.dart';
import '../../../../di/sub_account/sub_account_module.dart';

class TransferSuccessPage extends BasePage<TransferSuccessPageViewModel> {
  final TransferSuccessPageArgument argument;

  TransferSuccessPage(this.argument);
  @override
  State<StatefulWidget> createState() => TransferSuccessPageState();
}

class TransferSuccessPageState extends BaseStatefulPage<TransferSuccessPageViewModel, TransferSuccessPage> {
  @override
  Widget buildView(BuildContext context, TransferSuccessPageViewModel model) {
    return TransferSuccessPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return transferSuccessPageViewModelProvider.call(widget.argument);
  }
}

class TransferSuccessPageArgument {
  final String amount;
  final Account account;

  TransferSuccessPageArgument({
    required this.amount,
    required this.account,
  });
}
