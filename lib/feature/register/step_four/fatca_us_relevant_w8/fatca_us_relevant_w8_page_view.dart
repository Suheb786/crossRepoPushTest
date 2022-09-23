import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8/fatca_us_relevant_w8_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class FatcaUSRelevantW8PageView extends BasePageViewWidget<FatcaUSRelevantW8PageViewModel> {
  FatcaUSRelevantW8PageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Expanded(
          child: AppStreamBuilder<bool>(
            stream: model.errorDetectorStream,
            initialData: false,
            dataBuilder: (context, error) {
              return ShakeAnimatedWidget(
                enabled: error ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<bool>>(
                  stream: model.fatcaUSRelevantW8Stream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.updateData(context);
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope.containerOf(context).read(registerStepFourViewModelProvider).nextPage();
                        // .next();
                      });
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (ProviderScope.containerOf(context)
                                .read(registerStepFourViewModelProvider)
                                .appSwiperController
                                .page ==
                            1.0) {
                          FocusScope.of(context).unfocus();
                          if (StringUtils.isDirectionRTL(context)) {
                            if (!details.primaryVelocity!.isNegative) {
                              model.validateFatcaUSRelevantW8Details();
                            }
                          } else {
                            if (details.primaryVelocity!.isNegative) {
                              model.validateFatcaUSRelevantW8Details();
                            } else {
                              ///Don't allow user to go back
                              // Future.delayed(Duration(milliseconds: 500), () {
                              //   ProviderScope.containerOf(context)
                              //       .read(registerStepFourViewModelProvider)
                              //       .previousPage();
                              //   // .previous();
                              // });
                            }
                          }
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                        shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          labelText: S.of(context).nameAsPerIncomeTaxReturn,
                                          hintText: S.of(context).pleaseEnter,
                                          controller: model.nameAsPerTaxReturnController,
                                          key: model.nameAsPerTaxReturnKey,
                                          inputAction: TextInputAction.go,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        AppTextField(
                                          labelText: S.of(context).dateOfBirth,
                                          hintText: S.of(context).pleaseEnter,
                                          controller: model.dateOfBirthController,
                                          inputType: TextInputType.datetime,
                                          inputAction: TextInputAction.go,
                                          key: model.dateOfBirthKey,
                                          readOnly: true,
                                          onPressed: () {
                                            DatePicker.show(context, initialDate: model.initialDate,
                                                onSelected: (date) {
                                              model.initialDate = date;
                                              model.dateOfBirthController.text =
                                                  TimeUtils.getFormattedDate(date.toString());
                                              model.isValid();
                                            }, onCancelled: () {
                                              Navigator.pop(context);
                                            }, title: S.of(context).dateOfBirth);
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16.h,
                                                width: 16.w,
                                                padding: EdgeInsetsDirectional.only(end: 7.w),
                                                child: AppSvg.asset(AssetUtils.calendar,
                                                    color: Theme.of(context).primaryColorDark));
                                          },
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        AppTextField(
                                          labelText: S.of(context).countryOfCitizenship,
                                          hintText: S.of(context).pleaseEnter,
                                          controller: model.countryOfCitizenshipController,
                                          inputType: TextInputType.text,
                                          inputAction: TextInputAction.go,
                                          key: model.countryOfCitizenshipKey,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 32.h),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.allFieldValidatorStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return (isValid!)
                                              ? AnimatedButton(
                                                  buttonText: S.of(context).swipeToProceed,
                                                  buttonHeight: 50,
                                                )
                                              : Container();
                                        }),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
