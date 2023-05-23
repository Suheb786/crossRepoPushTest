import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/user_contact_details/user_contact_details_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/user_contact_details/user_contact_details_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:riverpod/src/framework.dart';

class UserContactDetailsPage extends BasePage<UserContactDetailsPageViewModel> {
  final UserInformation _userInformation;

  UserContactDetailsPage(this._userInformation);

  @override
  State<StatefulWidget> createState() => UserContactDetailsPageState();
}

class UserContactDetailsPageState
    extends BaseStatefulPage<UserContactDetailsPageViewModel, UserContactDetailsPage> {
  @override
  Widget buildView(BuildContext context, UserContactDetailsPageViewModel model) =>
      UserContactDetailsPageView(provideBase());

  @override
  ProviderBase provideBase() => editContactAddedPageViewModelProvider.call(widget._userInformation);

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.0.h),
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h, top: 50.h),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutePaths.ManageContactsList);
              },
              child: AppSvg.asset(AssetUtils.back,
                  height: 24.h,
                  width: 24.w,
                  matchTextDirection: true,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }
}
