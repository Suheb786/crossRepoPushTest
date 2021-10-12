import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/steptwo/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ConfirmDetailView extends BasePageViewWidget<ConfirmDetailViewModel> {
  ConfirmDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ConfirmDetailViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).personalDetails,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, bottom: 32),
            child: Text(
              S.of(context).confirmDetailsHeader,
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
                    ProviderScope.containerOf(context)
                        .read(registerStepOneViewModelProvider)
                        .pageController
                        .nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                  } else {
                    ProviderScope.containerOf(context)
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
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              AppTextField(
                                labelText: S.of(context).name,
                                hintText: S.of(context).nameHint,
                                inputType: TextInputType.text,
                                controller: model.nameController,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppTextField(
                                labelText: S.of(context).idNumber,
                                hintText: S.of(context).idHint,
                                inputType: TextInputType.text,
                                controller: model.idNumberController,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppTextField(
                                labelText: S.of(context).dob,
                                hintText: S.of(context).dobHint,
                                inputType: TextInputType.text,
                                controller: model.dobController,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppTextField(
                                labelText: S.of(context).nationality,
                                hintText: S.of(context).nationalityHint,
                                inputType: TextInputType.text,
                                controller: model.nameController,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppTextField(
                                labelText: S.of(context).expiryDate,
                                hintText: S.of(context).expiryDateHint,
                                inputType: TextInputType.text,
                                controller: model.nameController,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppTextField(
                                labelText: S.of(context).gender,
                                hintText: S.of(context).genderHint,
                                inputType: TextInputType.text,
                                controller: model.nameController,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 45,
                          left: 45,
                          child: AnimatedButton(buttonText: "Swipe to proceed"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
