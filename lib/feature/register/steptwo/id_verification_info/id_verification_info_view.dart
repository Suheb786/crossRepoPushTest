import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/steptwo/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/id_verification/id_verification_info_text.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class IdVerificationInfoView
    extends BasePageViewWidget<IdVerificationInfoViewModel> {
  IdVerificationInfoView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, IdVerificationInfoViewModel model) {
    bool? isChecked = ProviderScope
        .containerOf(context)
        .read(idVerificationInfoViewModelProvider)
        .isChecked;
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S
                .of(context)
                .personalDetails,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, bottom: 32),
            child: Text(
              S
                  .of(context)
                  .idVerificationInfoHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ShakeAnimatedWidget(
              enabled: false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.primaryDelta!.isNegative) {
                    ProviderScope
                        .containerOf(context)
                        .read(registerStepOneViewModelProvider)
                        .pageController
                        .nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  } else {
                    ProviderScope
                        .containerOf(context)
                        .read(registerStepOneViewModelProvider)
                        .pageController
                        .previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                      decoration: BoxDecoration(
                        color: AppColor.very_soft_violet,
                        gradient: LinearGradient(
                            colors: [
                              AppColor.dark_violet,
                              AppColor.dark_moderate_blue
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            IdVerificationInfoText(image: AssetUtils.sunny,
                                title: S
                                    .of(context)
                                    .idVerificationPlaceInfo),
                            SizedBox(
                              height: 32,
                            ),
                            IdVerificationInfoText(image: AssetUtils.scan,
                                title: S
                                    .of(context)
                                    .idScanInfo),
                            SizedBox(
                              height: 32,
                            ),
                            IdVerificationInfoText(image: AssetUtils.correct,
                                title: S
                                    .of(context)
                                    .onIdFit),
                            SizedBox(
                              height: 144,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    bool value = ProviderScope
                                        .containerOf(
                                        context)
                                        .read(
                                        idVerificationInfoViewModelProvider)
                                        .isChecked!;
                                    if (value == false) {
                                      model.changeValue(true);
                                      ProviderScope.containerOf(context)
                                          .read(
                                          idVerificationInfoViewModelProvider)
                                          .notify();
                                    } else {
                                      model.changeValue(false);
                                      ProviderScope.containerOf(context)
                                          .read(
                                          idVerificationInfoViewModelProvider)
                                          .notify();
                                    }
                                  },
                                  child: isChecked! == false
                                      ? AppSvg.asset(AssetUtils.ellipse)
                                      : AppSvg.asset(AssetUtils.checkBox),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    S
                                        .of(context)
                                        .termsAndConditions,
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
