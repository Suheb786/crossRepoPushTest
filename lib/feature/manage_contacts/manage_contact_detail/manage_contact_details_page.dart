import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ManageContactDetailsPage
    extends BasePage<ManageContactDetailsPageViewModel> {
  final ContactsListModel _contactsListModel;

  ManageContactDetailsPage(this._contactsListModel);

  @override
  ManageContactDetailsPageState createState() =>
      ManageContactDetailsPageState();
}

class ManageContactDetailsPageState extends BaseStatefulPage<
    ManageContactDetailsPageViewModel, ManageContactDetailsPage> {
  @override
  ProviderBase provideBase() {
    return manageContactDetailsViewModelProvider
        .call(widget._contactsListModel);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: AppSvg.asset(AssetUtils.leftArrow,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ));
  }

  @override
  void onModelReady(ManageContactDetailsPageViewModel model) {
    getViewModel().setData();
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, ManageContactDetailsPageViewModel model) {
    return ManageContactDetailsPageView(provideBase());
  }
}
