import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contact_IBAN_otp/add_contact_IBAN_otp_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contact_IBAN_otp/add_contact_IBAN_otp_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class AddContactIBANotpPage extends BasePage<AddContactIBANotpPageViewModel> {
  @override
  State<StatefulWidget> createState() => AddContactIBANotpPageState();
}

class AddContactIBANotpPageState
    extends BaseStatefulPage<AddContactIBANotpPageViewModel, AddContactIBANotpPage>
    with AutomaticKeepAliveClientMixin {
  AddContactIBANotpPageState() : super(subscribeVisibilityEvents: true);
  @override
  Widget buildView(BuildContext context, AddContactIBANotpPageViewModel model) =>
      AddContactIBANotpPageView(provideBase());

  @override
  ProviderBase provideBase() => addcontactIBANotpPageViewModelProvider;
  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
