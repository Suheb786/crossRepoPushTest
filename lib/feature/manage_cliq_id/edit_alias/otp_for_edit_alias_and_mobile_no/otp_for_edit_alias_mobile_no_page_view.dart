import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
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

import 'otp_for_edit_alias_mobile_no_page_view_model.dart';

class OtpForEditAliasAndMobileNoPageView extends BasePageViewWidget<OtpForEditAliasAndMobileNoPageViewModel> {
  OtpForEditAliasAndMobileNoPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 96.0.h, start: 24.w, end: 24.w, bottom: 36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).editCliqId,
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "${S.of(context).enterOtpHeader} \n ${model.arguments.data.mobileNumber ?? ''}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 20.t, color: Theme.of(context).accentColor,),
            ),
            SizedBox(
              height: 32.h,
            ),
            Expanded(
              child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isValid) {
                  return ShakeAnimatedWidget(
                    enabled: isValid ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<EditCliq>>(
                        initialData: Resource.none(),
                        stream: model.editCliqIdStream,
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            if (model.arguments.isAlias) {
                              model.showSuccessToast(S.of(context).cliqAliasUpdate);
                            } else {
                              model.showSuccessToast(S.of(context).cliqMobileNumberUpdate);
                            }

                            ProviderScope.containerOf(context).read(cliqIdListViewModelProvider).getAlias(true);
                            Navigator.popUntil(context, ModalRoute.withName(RoutePaths.CliqIdList));
                          }
                        },
                        dataBuilder: (context, editCliqIdResponse) {
                          return AppStreamBuilder<Resource<bool>>(
                              stream: model.enterOtpForCliqIdValidationStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  if (data.data!) {
                                    model.makeEditCliqIdRequest(
                                        getToken: true,
                                        aliasId: model.arguments.aliasId,
                                        isAlias: model.arguments.isAlias,
                                        aliasValue: model.arguments.aliasValue,
                                        otpCode: model.otpController.text);

                                    //    Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);
                                  }
                                }
                              },
                              dataBuilder: (context, enterOtpForCliqResponse) {
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (details.primaryVelocity!.isNegative) {
                                      model.validateOtp();
                                      //  Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
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
                                                                      .read(linkBankAccountCliqIdViewModelProvider)
                                                                      .linkBankAccountCliqIdList
                                                                      .first
                                                                      .accountNumber ??
                                                                  '',
                                                              isAlias: model.arguments.isAlias,
                                                              aliasValue: model.arguments.aliasValue,
                                                              aliasId: model.arguments.aliasId,
                                                            );

                                                            model.updateTime();
                                                          },
                                                          child: Text(
                                                            S.of(context).resendCode,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontSize: 14.t,
                                                                fontWeight: FontWeight.w600,
                                                                color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                                          ))
                                                      : Text(
                                                          S.of(context).resendIn(
                                                              '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 14.t,
                                                              fontWeight: FontWeight.w600,
                                                              color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                                        );
                                                },
                                              ),
                                              AppStreamBuilder<bool>(
                                                stream: model.showButtonStream,
                                                initialData: false,
                                                dataBuilder: (BuildContext context, isValid) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 26.0.h,
                                                    ),
                                                    child: Visibility(
                                                      visible: isValid!,
                                                      child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
