import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:riverpod/src/framework.dart';

class AgentSelectionView extends BasePageViewWidget<AgentSelectionViewModel> {
  AgentSelectionView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AgentSelectionViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: ShakeAnimatedWidget(
              enabled: false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.primaryDelta!.isNegative) {
                    ProviderScope.containerOf(context)
                        .read(registerStepFiveViewModelProvider)
                        .registrationStepFivePageController
                        .jumpToPage(4);
                  } else {
                    ProviderScope.containerOf(context)
                        .read(registerStepFiveViewModelProvider)
                        .registrationStepFivePageController
                        .previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme.of(context)
                      .cardTheme
                      .copyWith(color: AppColor.white)
                      .color,
                  margin: EdgeInsets.zero,
                  shadowColor: AppColor.black.withOpacity(0.32),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 59.0, bottom: 32),
                                child: Container(
                                  height: 78,
                                  width: 78,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.07, vertical: 22.29),
                                  decoration: BoxDecoration(
                                    color: AppColor.vividYellow,
                                    shape: BoxShape.circle,
                                  ),
                                  child: AppSvg.asset(AssetUtils.maleAgent,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ),
                              Text(
                                S.of(context).lookingForAvailableAgent,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: CountdownTimer(
                                  controller: model.countDownController,
                                  onEnd: () {},
                                  endTime: model.endTime,
                                  widgetBuilder:
                                      (context, currentTimeRemaining) {
                                    return currentTimeRemaining == null
                                        ? TextButton(
                                            onPressed: () {
                                              model.updateTime();
                                            },
                                            child: Text(
                                              'Search Again',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .accentTextTheme
                                                      .bodyText1!
                                                      .color),
                                            ))
                                        : Text(
                                            S.of(context).estimatedTime(
                                                '${currentTimeRemaining.min ?? 00}:${currentTimeRemaining.sec ?? 00}'),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .accentTextTheme
                                                    .bodyText1!
                                                    .color),
                                            textAlign: TextAlign.center,
                                          );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text(
                            S
                                .of(context)
                                .thankYouForWaitingCallWillStartAutomatically,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
