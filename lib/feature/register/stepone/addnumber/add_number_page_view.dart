import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class AddNumberPageView extends BasePageViewWidget<AddNumberViewModel> {
  AddNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<bool>>(
                stream: model.registerNumberStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    ProviderScope.containerOf(context)
                        .read(registerStepOneViewModelProvider)
                        .pageController
                        .nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                  }
                },
                dataBuilder: (context, data) {
                  return GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.primaryDelta!.isNegative) {
                        model.validateNumber(
                            dialCode: ProviderScope.containerOf(context)
                                    .read(countrySelectionViewModelProvider)
                                    .selectedCountry!
                                    .countryCallingCode ??
                                "");
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
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
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
                              Column(
                                children: [
                                  AppTextField(
                                    labelText: S.of(context).emailAddress,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.emailController,
                                    key: model.emailKey,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: data!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    inputAction: TextInputAction.go,
                                    inputType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      model.validate();
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText: S.of(context).mobileNumber,
                                    hintText: S.of(context).mobileNumberHint,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    controller: model.mobileNumberController,
                                    key: model.mobileNumberKey,
                                    onChanged: (value) => model.validate(),
                                    prefixIcon: () {
                                      Country? country = ProviderScope
                                              .containerOf(context)
                                          .read(
                                              countrySelectionViewModelProvider)
                                          .selectedCountry;
                                      return Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            country!.countryFlag ??
                                                                "",
                                                            package:
                                                                "country_calling_code_picker"),
                                                        fit: BoxFit.cover))),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                country.countryCallingCode ??
                                                    "",
                                                style: TextStyle(
                                                  color:
                                                      AppColor.very_light_gray,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            ErrorParser.getLocalisedStringError(
                                                error: data!.appError,
                                                localisedHelper: S.of(context)),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.vivid_red),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                ],
                              ),
                              AppStreamBuilder<bool>(
                                  stream: model.showButtonStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return Visibility(
                                      visible: isValid!,
                                      child: Positioned(
                                        bottom: 0,
                                        left: 45,
                                        right: 45,
                                        child: AnimatedButton(
                                          buttonText:
                                              S.of(context).swipeToProceed,
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          )),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
