import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/button/app_secondary_button.dart';
import 'help_center_error_page_view_model.dart';

class HelpCenterErrorPageView extends BasePageViewWidget<HelpCenterErrorPageViewModel> {
  HelpCenterErrorPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 72.0.h, bottom: 24.h, left: 0),
      child: Column(
        children: [
          Stack(
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
                  child: Center(child: AppSvg.asset(AssetUtils.cancel, color: Colors.black)),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 56.h, left: 40.w, right: 40.w),
            child: Text(
              model.status == InfobipCallStatusEnum.ON_HANGUP_REQUEST_TIMEOUT
                  ? S.of(context).ourAgentsAreOccupied
                  : S.of(context).lostConnection,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.t,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 16.h,
              start: 40.w,
              end: 40.w,
            ),
            child: Text(
                model.status == InfobipCallStatusEnum.ON_HANGUP_REQUEST_TIMEOUT
                    ? S.of(context).ourAgentsAreOccupiedDescription
                    : S.of(context).lostConnectionDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600)),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w),
            child: AppSecondaryButton(
              text: S.of(context).backToDashboard,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
              },
            ),
          ),
        ],
      ),
    );
  }
}
