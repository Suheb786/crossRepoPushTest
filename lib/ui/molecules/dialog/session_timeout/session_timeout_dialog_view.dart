import 'package:data/di/local_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/session_timeout/session_timeout_dialog_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../di/dashboard/dashboard_modules.dart';
import '../../../../main/app_viewmodel.dart';
import '../../button/app_primary_button.dart';

class SessionTimeoutDialogView extends StatelessWidget {
  final Function? onSelected;
  final String title;

  const SessionTimeoutDialogView({
    this.onSelected,
    required this.title,
  });

  ProviderBase providerBase() {
    return sessionTimeoutDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BaseWidget<SessionTimeoutDialogViewModel>(
          onModelReady: (model) {
            print(
                "time ---  ${ProviderScope.containerOf(appLevelKey.currentState!.context).read(localSessionService).getTimeoutRemainTime.inSeconds}");
            model.remainTime = DateTime.now().millisecondsSinceEpoch +
                1000 *
                    (60 -
                        ProviderScope.containerOf(appLevelKey.currentState!.context)
                            .read(localSessionService)
                            .getTimeoutRemainTime
                            .inSeconds);
            model.countDownController = CountdownTimerController(endTime: model.remainTime);
          },
          providerBase: providerBase(),
          builder: (context, model, child) {
            return Container(
              padding: EdgeInsets.zero,
              alignment: AlignmentDirectional.bottomCenter,
              child: Dialog(
                  insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 350.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 32.h),
                          AppSvg.asset(
                            AssetUtils.logout,
                            height: 40.h,
                            width: 40.w,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            S.of(context).sessionTimeout,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 20.t,
                                fontWeight: FontWeight.w600,
                                color: AppColor.very_dark_gray),
                          ),
                          SizedBox(height: 26.h),
                          CountdownTimer(
                            key: ValueKey("timer"),
                            controller: model!.countDownController,
                            // endTime: model.remainTime,
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).indicatorColor,
                            ),
                            onEnd: () {},
                            widgetBuilder: (context, currentTimeRemaining) {
                              return currentTimeRemaining == null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Center(
                                        child: Text(
                                          "${S.of(context).timeOutText1} 00:00 seconds. ${S.of(context).pleaseContinueToStayLoggedIn}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context).indicatorColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.t,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Center(
                                        child: Text.rich(
                                          TextSpan(
                                              text: S.of(appLevelKey.currentState!.context).timeOutText1,
                                              style: TextStyle(
                                                color: Theme.of(context).indicatorColor,
                                                fontSize: 14.t,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}. "
                                                          "",
                                                  style: TextStyle(
                                                    color: Theme.of(context).indicatorColor,
                                                    fontSize: 14.t,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: S.of(context).pleaseContinueToStayLoggedIn,
                                                  style: TextStyle(
                                                    color: Theme.of(context).indicatorColor,
                                                    fontSize: 14.t,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ]),
                                          textAlign: TextAlign.left,
                                        ),
                                      ));
                            },
                          ),
                          SizedBox(height: 32.h),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
                            child: AppPrimaryButton(
                              onPressed: () {
                                onSelected!.call();
                              },
                              text: S.of(context).continueText,
                            ),
                          ),
                        ],
                      ))),
            );
          }),
    );
  }
}
