import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_create_pin/dc_setting_create_pin_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/color_utils.dart';

class DcSettingCreatePinPageView extends BasePageViewWidget<DcSettingCreatePinPageViewModel> {
  DcSettingCreatePinPageView(ProviderBase model) : super(model);

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
              stream: model.createPinStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  ProviderScope.containerOf(context).read(dcSettingCardDeliveryViewModelProvider).nextPage();
                  // .next(animation: true);
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(dcSettingCardDeliveryViewModelProvider)
                            .appSwiperController
                            .page ==
                        1.0) {
                      FocusScope.of(context).unfocus();
                      if (StringUtils.isDirectionRTL(context)) {
                        if (!details.primaryVelocity!.isNegative) {
                          model.validatePin();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(dcSettingCardDeliveryViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          model.validatePin();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(dcSettingCardDeliveryViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
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
                              padding: EdgeInsets.only(top: 16.0.h),
                              child: AppStreamBuilder<bool>(
                                  stream: model.showButtonStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return AppPrimaryButton(
                                      text: S.of(context).swipeToProceed,
                                      isDisabled: !isValid!,
                                      onPressed: () {
                                        model.validatePin();
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    ProviderScope.containerOf(context)
                                        .read(dcSettingCardDeliveryViewModelProvider)
                                        .previousPage();
                                  },
                                  child: Text(
                                    S.of(context).back,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.brightBlue,
                                        fontSize: 14.t,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
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
    );
  }
}
