import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/confirm_pin/confirm_replacement_pin_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../ui/molecules/button/app_primary_button.dart';
import '../../../utils/color_utils.dart';

class ConfirmReplacementPinPageView extends BasePageViewWidget<ConfirmReplacementPinPageViewModel> {
  ConfirmReplacementPinPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<bool>>(
              stream: model.confirmPinStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pushReplacementNamed(context, RoutePaths.DebitCardReplacementSuccess,
                      arguments: DebitCardReplacementSuccessPageArgs(
                          type: ProviderScope.containerOf(context)
                              .read(debitCardReplacementViewModelProvider)
                              .debitCardReplacementArguments
                              .type));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: AppOtpFields(
                                length: 4,
                                fieldWidth: MediaQuery.of(context).size.width / 6.4,
                                fieldHeight: 52.h,
                                onChanged: (val) {
                                  model.validate(val);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.0.h,bottom: 16.0.h),
                            child: AppStreamBuilder<bool>(
                                stream: model.showButtonStream,
                                initialData: false,
                                dataBuilder: (context, isValid) {
                                  return AppPrimaryButton(
                                    isDisabled: !isValid!,
                                    text: S.of(context).next,
                                    onPressed: () {
                                      model.validatePin(
                                          ProviderScope.containerOf(context)
                                              .read(createReplacementPinViewModelProvider)
                                              .currentPin,
                                          ProviderScope.containerOf(context)
                                              .read(replacementVisaCardViewModelProvider)
                                              .cardNumber!);
                                    },
                                  );
                                }),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                ProviderScope.containerOf(context)
                                    .read(debitCardReplacementViewModelProvider)
                                    .previousPage();
                              },
                              child: Text(
                                S.of(context).back,
                                style: TextStyle(
                                  color: AppColor.brightBlue,
                                  fontSize: 14.t,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
