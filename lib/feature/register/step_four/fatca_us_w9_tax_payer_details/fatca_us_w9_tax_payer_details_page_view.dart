import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FatcaUSW9TaxPayersDetailsPageView extends BasePageViewWidget<FatcaUSW9TaxPayersDetailsPageViewModel> {
  FatcaUSW9TaxPayersDetailsPageView(ProviderBase model) : super(model);

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
                  stream: model.fatcaUSW9taxPayerDetailsStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.updateData(context);
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope.containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .moveToPage(7);
                        // .move(7, animation: false);
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
                            6.0) {
                          FocusScope.of(context).unfocus();
                          if (StringUtils.isDirectionRTL(context)) {
                            if (!details.primaryVelocity!.isNegative) {
                              model.validateFatcaUSW9TaxPayersDetails();
                            } else {
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .previousPage();
                                // .previous();
                              });
                            }
                          } else {
                            if (details.primaryVelocity!.isNegative) {
                              model.validateFatcaUSW9TaxPayersDetails();
                            } else {
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .previousPage();
                                // .previous();
                              });
                            }
                          }
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                        margin: EdgeInsets.zero,
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
                                          labelText: S.of(context).whichTaxPayerAreYou,
                                          hintText: S.of(context).pleaseSelect,
                                          controller: model.taxPayerTypeController,
                                          key: model.taxPayerTypeKey,
                                          readOnly: true,
                                          onPressed: () {
                                            TaxPayerDialog.show(context,
                                                taxPayerTypeEnum: TaxPayerTypeEnum.W9, onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: (value, englishValue) {
                                              Navigator.pop(context);
                                              model.updateTaxVisibilityValue(true);
                                              model.updateTaxPayerTypeField(value, englishValue);
                                              model.socialSecurityNumberController.clear();
                                              model.employerIdNumberController.clear();
                                              model.isValid();
                                            });
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16.h,
                                                width: 16.w,
                                                padding: EdgeInsetsDirectional.only(end: 8.w),
                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                    color: AppColor.dark_gray_1));
                                          },
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        AppStreamBuilder<bool>(
                                            stream: model.taxVisibilityStream,
                                            initialData: false,
                                            dataBuilder: (context, isVisible) {
                                              return Visibility(
                                                visible: isVisible!,
                                                child: AppStreamBuilder<bool>(
                                                  stream: model.socialSecurityVisibilityStream,
                                                  initialData: false,
                                                  dataBuilder: (context, isVisible) {
                                                    return isVisible!
                                                        ? AppTextField(
                                                            labelText: S.of(context).socialSecurityNUmber,
                                                            hintText: S.of(context).socialSecurityHintText,
                                                            controller: model.socialSecurityNumberController,
                                                            inputType: TextInputType.number,
                                                            key: model.socialSecurityNumberKey,
                                                            inputAction: TextInputAction.go,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(
                                                                  RegExp(r'[0-9]')),
                                                              MaskTextInputFormatter(
                                                                  mask: '###-##-####',
                                                                  filter: {'#': RegExp(r'[0-9]')})
                                                            ],
                                                            onChanged: (value) {
                                                              model.isValid();
                                                            },
                                                          )
                                                        : AppTextField(
                                                            labelText: S.of(context).employerIdNumber,
                                                            hintText: S.of(context).pleaseEnter,
                                                            controller: model.employerIdNumberController,
                                                            key: model.employerIdNumberKey,
                                                            inputAction: TextInputAction.go,
                                                            onChanged: (value) {
                                                              model.isValid();
                                                            },
                                                          );
                                                  },
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                          height: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 26.h),
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
                                ),
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
