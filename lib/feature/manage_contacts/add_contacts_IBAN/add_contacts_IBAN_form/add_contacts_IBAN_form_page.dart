import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
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
}
