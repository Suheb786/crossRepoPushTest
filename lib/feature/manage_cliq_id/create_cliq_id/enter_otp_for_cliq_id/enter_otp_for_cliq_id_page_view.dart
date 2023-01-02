import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/enter_otp_for_cliq_id/enter_otp_for_cliq_id_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EnterOtpForCliqIdPageView extends BasePageViewWidget<EnterOtpForCliqIdPageViewModel> {
  EnterOtpForCliqIdPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<ConfirmCreateCliqId>>(
                initialData: Resource.none(),
                stream: model.createCliqIdStream,
                onData: (data) {
                  if (data.status == Status.SUCCESS)
                    Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);
                },
                dataBuilder: (context, createCliqIdResponse) {
                  return AppStreamBuilder<Resource<bool>>(
                      stream: model.enterOtpForCliqIdValidationStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          if (data.data!) {
                            //  Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);

                            model.makeCreateCliqIDRequest(
                                accountNumber: ProviderScope.containerOf(context)
                                        .read(appHomeViewModelProvider)
                                        .dashboardDataContent
                                        .account
                                        ?.accountNo ??
                                    '',
                                isAlias: ProviderScope.containerOf(context)
                                        .read(cliqIdTypeSelectionViewModelProvider)
                                        .cliqIdTypeController
                                        .text ==
                                    S.of(context).alias,
                                aliasValue: (ProviderScope.containerOf(context)
                                            .read(cliqIdTypeSelectionViewModelProvider)
                                            .cliqIdTypeController
                                            .text ==
                                        S.of(context).alias)
                                    ? ProviderScope.containerOf(context)
                                        .read(cliqIdTypeSelectionViewModelProvider)
                                        .aliasController
                                        .text
                                    : ProviderScope.containerOf(context)
                                        .read(cliqIdTypeSelectionViewModelProvider)
                                        .mobileNumberController
                                        .text,
                                getToken: true,
                                otpCode: model.otpController.text);
                          }
                        }
                      },
                      dataBuilder: (context, enterOtpForCliqResponse) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(createCliqIdViewModelProvider)
                                    .appSwiperController
                                    .page ==
                                2.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.validateOtp();
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(createCliqIdViewModelProvider)
                                      .previousPage();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.validateOtp();
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(createCliqIdViewModelProvider)
                                      .previousPage();
                                }
                              }
                            }
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SingleChildScrollView(
                                      physics: ClampingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          AppOtpFields(
                                            length: 6,
                                            controller: model.otpController,
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
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 16.t,
                                              color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                          widgetBuilder: (context, currentTimeRemaining) {
                                            return currentTimeRemaining == null
                                                ? TextButton(
                                                    onPressed: () {
                                                      model.makeOtpRequest(
                                                        accountNumber: ProviderScope.containerOf(context)
                                                                .read(appHomeViewModelProvider)
                                                                .dashboardDataContent
                                                                .account
                                                                ?.accountNo ??
                                                            '',
                                                        isAlias: ProviderScope.containerOf(context)
                                                                .read(cliqIdTypeSelectionViewModelProvider)
                                                                .cliqIdTypeController
                                                                .text ==
                                                            S.of(context).alias,
                                                        aliasValue: (ProviderScope.containerOf(context)
                                                                    .read(
                                                                        cliqIdTypeSelectionViewModelProvider)
                                                                    .cliqIdTypeController
                                                                    .text ==
                                                                S.of(context).alias)
                                                            ? ProviderScope.containerOf(context)
                                                                .read(cliqIdTypeSelectionViewModelProvider)
                                                                .aliasController
                                                                .text
                                                            : ProviderScope.containerOf(context)
                                                                .read(cliqIdTypeSelectionViewModelProvider)
                                                                .mobileNumberController
                                                                .text,
                                                        getToken: true,
                                                      );

                                                      //
                                                      model.updateTime();
                                                    },
                                                    child: Text(
                                                      S.of(context).resendCode,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14.t,
                                                          fontWeight: FontWeight.w600,
                                                          color: Theme.of(context)
                                                              .accentTextTheme
                                                              .bodyText1!
                                                              .color!),
                                                    ))
                                                : Text(
                                                    S.of(context).resendIn(
                                                        '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .accentTextTheme
                                                            .bodyText1!
                                                            .color!),
                                                  );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 16.0.h),
                                          child: AppStreamBuilder<bool>(
                                              stream: model.showButtonStream,
                                              initialData: false,
                                              dataBuilder: (context, isValid) {
                                                return Visibility(
                                                  visible: isValid!,
                                                  child: AnimatedButton(
                                                    buttonHeight: 50.h,
                                                    buttonText: S.of(context).swipeToProceed,
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      });
                }),
          );
        },
      ),
    );
  }
}
