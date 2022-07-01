import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ManageContactListPage extends BasePage<ManageContactListPageViewModel> {
  @override
  ManageContactListPageState createState() => ManageContactListPageState();
}

class ManageContactListPageState extends BaseStatefulPage<
    ManageContactListPageViewModel, ManageContactListPage> {
  @override
  ProviderBase provideBase() {
    return manageContactsListViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85),
      child: GestureDetector(
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: AppSvg.asset(AssetUtils.leftArrow,
                      matchTextDirection: true,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Text(
                S.of(context).manageContacts,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 18.0),
                child: Container(
                  width: 28,
                ),
              )
            ],
          )),
    );
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
  Widget buildView(BuildContext context, ManageContactListPageViewModel model) {
    return ManageContactListPageView(provideBase());
  }
}
