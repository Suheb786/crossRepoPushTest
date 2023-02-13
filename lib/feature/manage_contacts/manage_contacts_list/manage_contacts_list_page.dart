import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class ManageContactListPage extends BasePage<ManageContactListPageViewModel> {
  @override
  ManageContactListPageState createState() => ManageContactListPageState();
}

class ManageContactListPageState
    extends BaseStatefulPage<ManageContactListPageViewModel, ManageContactListPage> {
  @override
  ProviderBase provideBase() {
    return manageContactsListViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.0.h),
      child: GestureDetector(
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.h, top: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 24.0.w),
                    child: AppSvg.asset(AssetUtils.leftArrow,
                        matchTextDirection: true, color: Theme.of(context).accentColor),
                  ),
                ),
                Text(
                  S.of(context).manageContacts,
                  style: TextStyle(
                      fontSize: 14.t, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 24.0.w),
                  child: Icon(Icons.add, color: Theme.of(context).accentColor),
                )
              ],
            ),
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
