import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contacts_IBAN_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contacts_IBAN_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class AddContactsIBANManageContactsPage extends BasePage<AddContactsIBANManageContactsPageViewModel> {
  @override
  State<StatefulWidget> createState() {
    return AddContactsIBANManageContactsPageState();
  }
}

class AddContactsIBANManageContactsPageState
    extends BaseStatefulPage<AddContactsIBANManageContactsPageViewModel, AddContactsIBANManageContactsPage> {
  @override
  Widget buildView(BuildContext context, AddContactsIBANManageContactsPageViewModel model) {
    return AddContactsIBANManageContactsPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return addContactIBANViewModelProvideer;
  }
}
