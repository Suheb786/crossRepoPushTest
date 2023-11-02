import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page_view.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page_view_model.dart';

import '../../../../base/base_page.dart';
import '../../../../di/dashboard/dashboard_modules.dart';
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

  @override
  Future<bool> onBackPressed(TransferSuccessPageViewModel model, {param}) {
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).closeSubAccountDialogAndRefreshPage();
    return super.onBackPressed(model);
  }
}

class TransferSuccessPageArgument {
  final double amount;
  final String accountNo;
  final String accountName;

  TransferSuccessPageArgument({
    required this.amount,
    required this.accountNo,
    required this.accountName,
  });
}
