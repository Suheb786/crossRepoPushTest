import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_ready_header.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../../utils/app_constants.dart';

class AccountHoldView extends BasePageViewWidget<AccountHoldViewModel> {
  AccountHoldView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AccountHoldViewModel model) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AppStreamBuilder<Resource<LogoutResponse>>(
                stream: model.logoutStream,
                initialData: Resource.none(),
                onData: (response) {
                  if (response.status == Status.SUCCESS) {
                    SecureStorageHelper.instance.clearToken();
                    AppConstantsUtils.resetCacheLists();
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
                  }
                },
                dataBuilder: (context, data) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(top: 43.h, end: 30.w),
                    child: InkWell(
                      onTap: () {
                        model.logOutUser();
                      },
                      child: AppSvg.asset(AssetUtils.logout, matchTextDirection: true),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetUtils.line),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.vividYellow,
                      ),
                      child: Center(child: AppSvg.asset(AssetUtils.right)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            AccountReadyHeader(
                descriptionVisibility: true,
                title: S.of(context).oneFinalStop,
                subTitle: S.of(context).yourApplicationInReviewNote),
            SizedBox(
              height: 40.h,
            ),
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: AccountDetails(title: S.of(context).refNo, value: model.arguments.applicationId ?? "-"),
            ),
          ],
        ));
  }
}
