import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/feature/sub_account/open_sub_account/open_sub_account_success/open_sub_account_success_page_view.dart';
import 'package:riverpod/src/framework.dart';

import '../../../../base/base_page.dart';
import '../../../../di/sub_account/sub_account_module.dart';
import 'open_sub_account_success_page_view_model.dart';

class OpenSubAccountSuccessPage extends BasePage<OpenSubAccountSuccessPageViewModel> {
  final OpenSubAccountSuccessPageArgument argument;

  OpenSubAccountSuccessPage(this.argument);

  @override
  State<StatefulWidget> createState() => OpenSubAccountSuccessPageState();
}

class OpenSubAccountSuccessPageState
    extends BaseStatefulPage<OpenSubAccountSuccessPageViewModel, OpenSubAccountSuccessPage> {
  @override
  Widget buildView(BuildContext context, OpenSubAccountSuccessPageViewModel model) =>
      OpenSubAccountSuccessPageView(provideBase());

  @override
  ProviderBase provideBase() => openSubAccountSuccessPageViewModelProvider.call(widget.argument);
}

class OpenSubAccountSuccessPageArgument {
  final String? accountNo;
  final String? iban;

  OpenSubAccountSuccessPageArgument({this.accountNo, this.iban});
}
