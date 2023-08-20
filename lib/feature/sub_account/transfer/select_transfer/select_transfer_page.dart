import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page_view.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

import '../../../../base/base_page.dart';
import '../../../../di/sub_account/sub_account_module.dart';

class SelectTransferPage extends BasePage<SelectTransferPageViewModel> {
  final SelectTranferPageArgument argument;

  SelectTransferPage({required this.argument});
  @override
  State<StatefulWidget> createState() {
    return SelectTransferPageState();
  }
}

class SelectTransferPageState extends BaseStatefulPage<SelectTransferPageViewModel, SelectTransferPage> {
  @override
  Widget buildView(BuildContext context, SelectTransferPageViewModel model) {
    return SelectTransferPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return selectTransferPageViewModelProivder.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

@override
void onModelReady(SelectTransferPageViewModel model) {}

class SelectTranferPageArgument {
  final Account account;

  SelectTranferPageArgument({required this.account});
}
