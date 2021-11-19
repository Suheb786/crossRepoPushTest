import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:riverpod/src/framework.dart';

class VideoCallInfoView extends BasePageViewWidget<VideoCallInfoViewModel> {
  VideoCallInfoView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoCallInfoViewModel model) {
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
                        .nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InformationText(
                                    image: AssetUtils.sun,
                                    title: S.of(context).brightPlace),
                                SizedBox(
                                  height: 32,
                                ),
                                InformationText(
                                    image: AssetUtils.mic,
                                    title: S.of(context).quietSurrounding,
                                    iconColor:
                                        Theme.of(context).primaryColorDark),
                                SizedBox(
                                  height: 32,
                                ),
                                InformationText(
                                    image: AssetUtils.headPhone,
                                    title: S.of(context).preferredAgent,
                                    iconColor:
                                        Theme.of(context).primaryColorDark),
                                SizedBox(
                                  height: 56,
                                ),
                                InkWell(
                                  onTap: () {
                                    ProviderScope.containerOf(context)
                                        .read(registerStepFiveViewModelProvider)
                                        .registrationStepFivePageController
                                        .jumpToPage(3);
                                  },
                                  child: Text(S.of(context).scheduleLater,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AnimatedButton(
                              buttonText: S.of(context).swipeToProceed,
                            ),
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
