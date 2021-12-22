import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';

class ManageContactListPage extends BasePage<ManageContactListPageViewModel> {
  @override
  ManageContactListPageState createState() => ManageContactListPageState();
}

class ManageContactListPageState extends BaseStatefulPage<
    ManageContactListPageViewModel,
    ManageContactListPage> {
  @override
  ProviderBase provideBase() {
    return manageContactsListViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85),
      child: Center(
        child: Text(
          S
              .of(context)
              .manageContacts,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme
                  .of(context)
                  .accentColor),
        ),
      ),
    );
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme
        .of(context)
        .primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ManageContactListPageViewModel model) {
    return ManageContactListPageView(provideBase());
  }
}
