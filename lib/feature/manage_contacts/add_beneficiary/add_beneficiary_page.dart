import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:riverpod/src/framework.dart';

import 'add_beneficiary_page_view.dart';
import 'add_beneficiary_page_view_model.dart';

class AddBeneficiaryPage extends BasePage<AddBeneficiaryPageViewModel> {
  @override
  State<StatefulWidget> createState() {
    return AddBeneficiaryPageState();
  }
}

class AddBeneficiaryPageState extends BaseStatefulPage<AddBeneficiaryPageViewModel, AddBeneficiaryPage>
    with AutomaticKeepAliveClientMixin {
  AddBeneficiaryPageState() : super(subscribeVisibilityEvents: true);

  @override
  Widget buildView(BuildContext context, AddBeneficiaryPageViewModel model) {
    return AddBeneficiaryPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return addBeneficiaryViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;

}
