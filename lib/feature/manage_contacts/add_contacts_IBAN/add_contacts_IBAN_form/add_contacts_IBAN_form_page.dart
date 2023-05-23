import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:riverpod/src/framework.dart';

import 'add_contacts_IBAN_form_page_view.dart';
import 'add_contacts_IBAN_form_page_view_model.dart';

class AddContactsIBANFormPage extends BasePage<AddContactsIBANformPageViewModel> {
  @override
  State<StatefulWidget> createState() {
    return AddContactIBANformPageState();
  }
}

class AddContactIBANformPageState
    extends BaseStatefulPage<AddContactsIBANformPageViewModel, AddContactsIBANFormPage> {
  // AddContactIBANformPageState() : super(subscribeVisibilityEvents: true);
  @override
  ProviderBase provideBase() {
    return addContactIBANformPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, AddContactsIBANformPageViewModel model) {
    return AddContactsIBANformPageView(provideBase());
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
