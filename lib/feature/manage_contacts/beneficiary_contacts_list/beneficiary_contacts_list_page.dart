import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'beneficiary_contacts_list_page_view.dart';
import 'beneficiary_contacts_list_page_view_model.dart';

class BeneficiaryContactListPage extends BasePage<BeneficiaryContactListPageViewModel> {
  @override
  BeneficiaryContactListPageState createState() => BeneficiaryContactListPageState();
}

class BeneficiaryContactListPageState
    extends BaseStatefulPage<BeneficiaryContactListPageViewModel, BeneficiaryContactListPage> {
  @override
  ProviderBase provideBase() {
    return beneficiaryContactListPageViewModelProvider;
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
                        matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                Text(
                  S.of(context).manageContacts,
                  style: TextStyle(
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 24.0.w),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, RoutePaths.AddContactsIBANManageContactsPage);
                      },
                      child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary)),
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
  Widget buildView(BuildContext context, BeneficiaryContactListPageViewModel model) {
    return BeneficiaryContactListPageView(provideBase());
  }
}
