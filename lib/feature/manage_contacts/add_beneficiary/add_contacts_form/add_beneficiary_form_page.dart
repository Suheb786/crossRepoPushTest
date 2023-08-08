import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:riverpod/src/framework.dart';

import 'add_beneficiary_form_page_view.dart';
import 'add_beneficiary_form_page_view_model.dart';

class AddBeneficiaryFormPage extends BasePage<AddBeneficiaryFormPageViewModel> {
  @override
  State<StatefulWidget> createState() {
    return AddBeneficiaryFormPageState();
  }
}

class AddBeneficiaryFormPageState
    extends BaseStatefulPage<AddBeneficiaryFormPageViewModel, AddBeneficiaryFormPage> {
  @override
  ProviderBase provideBase() {
    return addBeneficiaryFormPageViewModel;
  }

  @override
  Widget buildView(BuildContext context, AddBeneficiaryFormPageViewModel model) {
    return AddBeneficiaryFormPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }
}
