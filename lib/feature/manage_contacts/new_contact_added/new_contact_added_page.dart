import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';

import 'package:riverpod/src/framework.dart';

import 'new_contact_added_page_view.dart';
import 'new_contact_added_page_view_model.dart';

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

  // @override
  // Color? scaffoldBackgroundColor() {
  //   return Colors.transparent;
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }
}
