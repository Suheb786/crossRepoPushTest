import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

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
                    Future.delayed(Duration(milliseconds: 500), () {
                      ProviderScope
                          .containerOf(context)
                          .read(registerStepFiveViewModelProvider)
                          .registrationStepFivePageController
                          .next();
                    });
                  } else {
                    Future.delayed(Duration(milliseconds: 500), () {
                      ProviderScope
                          .containerOf(context)
                          .read(registerStepFiveViewModelProvider)
                          .registrationStepFivePageController
                          .previous();
                    });
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
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 35.0, bottom: 24),
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
                                          color: Theme
                                              .of(context)
                                              .primaryColorDark),
                                    ),
                                  ),
                                  Text(
                                    S
                                        .of(context)
                                        .videoCallInfoDescription,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color:
                                        Theme
                                            .of(context)
                                            .primaryColorDark),
                                  ),
                                  SizedBox(
                                    height: 43,
                                  ),
                                  // InformationText(
                                  //     image: AssetUtils.sun,
                                  //     title: S.of(context).brightPlace),
                                  // SizedBox(
                                  //   height: 32,
                                  // ),
                                  // InformationText(
                                  //     image: AssetUtils.mic,
                                  //     title: S.of(context).quietSurrounding,
                                  //     iconColor:
                                  //         Theme.of(context).primaryColorDark),
                                  // SizedBox(
                                  //   height: 32,
                                  // ),
                                  // InformationText(
                                  //     image: AssetUtils.headPhone,
                                  //     title: S.of(context).preferredAgent,
                                  //     iconColor:
                                  //         Theme.of(context).primaryColorDark),
                                  // SizedBox(
                                  //   height: 56,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        ProviderScope
                                            .containerOf(context)
                                            .read(
                                            registerStepFiveViewModelProvider)
                                            .registrationStepFivePageController
                                            .move(3);
                                      });
                                    },
                                    child: Text(S
                                        .of(context)
                                        .scheduleLater,
                                        style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .accentTextTheme
                                                .bodyText1!
                                                .color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
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
