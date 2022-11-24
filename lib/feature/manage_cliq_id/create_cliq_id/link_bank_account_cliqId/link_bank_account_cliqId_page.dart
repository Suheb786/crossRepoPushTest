import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view_model.dart';

class LinkBankAccountCliqIdPage extends BasePage<LinkBankAccountCliqIdPageViewModel> {
  @override
  LinkBankAccountCliqIdPageState createState() => LinkBankAccountCliqIdPageState();
}

class LinkBankAccountCliqIdPageState
    extends BaseStatefulPage<LinkBankAccountCliqIdPageViewModel, LinkBankAccountCliqIdPage>
    with AutomaticKeepAliveClientMixin {
  LinkBankAccountCliqIdPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return linkBankAccountCliqIdViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, LinkBankAccountCliqIdPageViewModel model) {
    return LinkBankAccountCliqIdPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
