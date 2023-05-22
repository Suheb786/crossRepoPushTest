import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/user_contact_details/user_contact_details_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/user_contact_details/user_contact_details_page_view_model.dart';

import 'package:riverpod/src/framework.dart';

class UserContactDetailsPage extends BasePage<UserContactDetailsPageViewModel> {
  @override
  State<StatefulWidget> createState() => UserContactDetailsPageState();
}

class UserContactDetailsPageState
    extends BaseStatefulPage<UserContactDetailsPageViewModel, UserContactDetailsPage> {
  @override
  Widget buildView(BuildContext context, UserContactDetailsPageViewModel model) =>
      UserContactDetailsPageView(provideBase());

  @override
  ProviderBase provideBase() => editContactAddedPageViewModelProvider;

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
