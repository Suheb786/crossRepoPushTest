import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/new_contact_added/new_contact_added_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/new_contact_added/new_contact_added_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class NewContactAddedPage extends BasePage<NewContactAddedPageViewModel> {
  @override
  State<StatefulWidget> createState() => NewContactAddedPageState();
}

class NewContactAddedPageState extends BaseStatefulPage<NewContactAddedPageViewModel, NewContactAddedPage> {
  @override
  Widget buildView(BuildContext context, NewContactAddedPageViewModel model) =>
      NewContactAddedPageView(provideBase());

  @override
  ProviderBase provideBase() => newContactAddedPageViewModelProvider;
}
