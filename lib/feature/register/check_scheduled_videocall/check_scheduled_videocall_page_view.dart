import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/app_constants.dart';

class CheckScheduledVideoCallPageView extends BasePageViewWidget<CheckScheduledVideoCallPageViewModel> {
  CheckScheduledVideoCallPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: AppSvg.asset(AssetUtils.swiggleHello, height: 241.h),
                  ),
                  AppStreamBuilder<Resource<LogoutResponse>>(
                      stream: model.logoutStream,
                      initialData: Resource.none(),
                      onData: (response) {
                        if (response.status == Status.SUCCESS) {
                          SecureStorageHelper.instance.clearToken();
                          AppConstantsUtils.resetCacheLists();
                          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.OnBoarding));
                        }
                      },
                      dataBuilder: (context, data) {
                        return Padding(
                          padding: EdgeInsets.only(top: 62.0.h),
                          child: InkWell(
                            onTap: () {
                              model.logOutUser();
                            },
                            child: AppSvg.asset(AssetUtils.logout),
                          ),
                        );
                      }),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  S.of(context).videoCallDueNow,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 20.t,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Visibility(
                visible: true,
                child: Center(
                  child: AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              InkWell(
                onTap: () {
                  ///TODO:take to reschedule call
                },
                child: Text(
                  S.of(context).rescheduleTheCall,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
