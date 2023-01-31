import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contact_IBAN_otp/add_contact_IBAN_otp_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class AddContactIBANotpPageView extends BasePageViewWidget<AddContactIBANotpPageViewModel> {
  AddContactIBANotpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AddContactIBANotpPageViewModel model) {
    return Card();
  }
}
