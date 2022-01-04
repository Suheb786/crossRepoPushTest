import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EnterOtpPageView extends BasePageViewWidget<EnterOtpViewModel> {
  EnterOtpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
        stream: model.errorDetectorStream,
        initialData: false,
        dataBuilder: (context, isValid) {
          return ShakeAnimatedWidget(
            enabled: isValid ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: AppStreamBuilder<Resource<TransferSuccessResponse>>(
                stream: model.transferStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    print('success');
                    Navigator.pushNamed(
                        context, RoutePaths.SendAmountToContactSuccess,
                        arguments: data.data!.transferSuccessContent);
                  } else if (data.status == Status.ERROR) {
                    print('error');
                    Navigator.pushNamed(context, RoutePaths.SendMoneyFailure);
                  }
                },
                dataBuilder: (context, transferResponse) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.enterOtpResponseStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        model.transfer(
                          ProviderScope.containerOf(context)
                              .read(sendToNewRecipientViewModelProvider)
                              .transferResponse,
                          ProviderScope.containerOf(context)
                              .read(sendToNewRecipientViewModelProvider)
                              .purposeDetail!
                              .strCode!,
                          ProviderScope.containerOf(context)
                              .read(sendToNewRecipientViewModelProvider)
                              .isFriend,
                          ProviderScope.containerOf(context)
                              .read(sendToNewRecipientViewModelProvider)
                              .selectedProfile,
                        );
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            model.enterOtp();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(paymentToNewRecipientViewModelProvider)
                                .pageController
                                .previous(animation: true);
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 32, horizontal: 24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppOtpFields(
                                          length: 6,
                                          onChanged: (val) {
                                            model.validate(val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      CountdownTimer(
                                        controller: model.countDownController,
                                        onEnd: () {},
                                        endTime: model.endTime,
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .accentTextTheme
                                                .bodyText1!
                                                .color!),
                                        widgetBuilder:
                                            (context, currentTimeRemaining) {
                                          return currentTimeRemaining == null
                                              ? TextButton(
                                                  onPressed: () {
                                                    model.updateTime();
                                                  },
                                                  child: Text(
                                                    'Resend Code',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .accentTextTheme
                                                            .bodyText1!
                                                            .color!),
                                                  ))
                                              : Text(
                                                  S.of(context).resendIn(
                                                      '${currentTimeRemaining.min ?? 00}:${currentTimeRemaining.sec ?? 00}'),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1!
                                                          .color!),
                                                );
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16.0),
                                        child: AppStreamBuilder<bool>(
                                            stream: model.showButtonStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return Visibility(
                                                visible: isValid!,
                                                child: AnimatedButton(
                                                  buttonHeight: 50,
                                                  buttonText: S
                                                      .of(context)
                                                      .swipeToProceed,
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}
