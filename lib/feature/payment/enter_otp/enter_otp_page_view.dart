import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EnterOtpPageView extends BasePageViewWidget<EnterOtpViewModel> {
  EnterOtpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.enterOtpResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            // model.ibanOrMobileKey.currentState!.isValid =
                            //     true;
                            // ProviderScope.containerOf(context)
                            //     .read(registerStepOneViewModelProvider)
                            //     .read(registerStepOneViewModelProvider)
                            //     .read(registerStepOneViewModelProvider)
                            //     .pageController
                            //     .next();
                          } else if (data.status == Status.ERROR) {
                            // if (data.appError!.type ==
                            //     ErrorType.EMPTY_RESIDENT_COUNTRY) {
                            //   model.residentCountryKey.currentState!.isValid =
                            //       false;
                            // }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity!.isNegative) {
                                ProviderScope.containerOf(context)
                                    .read(
                                        paymentToNewRecipientViewModelProvider)
                                    .pageController
                                    .previous();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(
                                        paymentToNewRecipientViewModelProvider)
                                    .pageController
                                    .previous();
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
                              shadowColor: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.32),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 32, left: 24, right: 24, bottom: 32),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppOtpFields(
                                              length: 6,
                                              // controller: model.otpController,
                                              onChanged: (val) {
                                                if (val.length == 6)
                                                  model.validate(val);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 16,
                                      ),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: true,
                                          dataBuilder: (context, isValid) {
                                            return Visibility(
                                              visible: isValid!,
                                              child: AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed,
                                              ),
                                            );
                                          }),
                                    ),
                                    // Column(
                                    //   children: [
                                    //     CountdownTimer(
                                    //       controller: model.countDownController,
                                    //       onEnd: () {},
                                    //       endTime: model.endTime,
                                    //       textStyle: TextStyle(
                                    //           fontSize: 16,
                                    //           color: Theme.of(context)
                                    //               .accentTextTheme
                                    //               .bodyText1!
                                    //               .color!),
                                    //       widgetBuilder:
                                    //           (context, currentTimeRemaining) {
                                    //         return currentTimeRemaining == null
                                    //             ? TextButton(
                                    //             onPressed: () {
                                    //               model.updateTime();
                                    //             },
                                    //             child: Text(
                                    //               'Resend Code',
                                    //               style: TextStyle(
                                    //                   fontSize: 14,
                                    //                   color: Theme.of(context)
                                    //                       .accentTextTheme
                                    //                       .bodyText1!
                                    //                       .color!),
                                    //             ))
                                    //             : Text(
                                    //           S.of(context).resendIn(
                                    //               '${currentTimeRemaining.min ?? 00}:${currentTimeRemaining.sec ?? 00}'),
                                    //           style: TextStyle(
                                    //               fontSize: 14,
                                    //               color: Theme.of(context)
                                    //                   .accentTextTheme
                                    //                   .bodyText1!
                                    //                   .color!),
                                    //         );
                                    //       },
                                    //     ),
                                    //     Padding(
                                    //       padding: EdgeInsets.only(top: 16.0),
                                    //       child: AppStreamBuilder<bool>(
                                    //           stream: model.showButtonStream,
                                    //           initialData: false,
                                    //           dataBuilder: (context, isValid) {
                                    //             return Visibility(
                                    //               visible: isValid!,
                                    //               child: AnimatedButton(
                                    //                 buttonHeight: 50,
                                    //                 buttonText:
                                    //                 S.of(context).swipeToProceed,
                                    //               ),
                                    //             );
                                    //           }),
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
