import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/new_contact_added/new_contact_added_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class NewContactAddedPageView extends BasePageViewWidget<NewContactAddedPageViewModel> {
  NewContactAddedPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, NewContactAddedPageViewModel model) {
    return Card();
  }
}
