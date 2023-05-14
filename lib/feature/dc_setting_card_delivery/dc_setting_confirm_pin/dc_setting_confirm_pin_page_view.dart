import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_confirm_pin/dc_setting_confirm_pin_page_view_model.dart';
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

class DcSettingConfirmPinPageView extends BasePageViewWidget<DcSettingConfirmPinPageViewModel> {
  DcSettingConfirmPinPageView(ProviderBase model) : super(model);

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
                  Navigator.pushReplacementNamed(context, RoutePaths.DcSettingCardReady);
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
                        2.0) {
                      FocusScope.of(context).unfocus();
                      if (StringUtils.isDirectionRTL(context)) {
                        if (!details.primaryVelocity!.isNegative) {
                          model.validatePin(
                              ProviderScope.containerOf(context)
                                  .read(dcSettingCreatePinViewModelProvider)
                                  .currentPin,
                              context);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(dcSettingCardDeliveryViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          print(
                              'currentPin--->${ProviderScope.containerOf(context).read(dcSettingCreatePinViewModelProvider).currentPin}');
                          model.validatePin(
                              ProviderScope.containerOf(context)
                                  .read(dcSettingCreatePinViewModelProvider)
                                  .currentPin,
                              context);
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
                                    return Visibility(
                                      visible: isValid!,
                                      child: AnimatedButton(
                                        buttonHeight: 50,
                                        buttonText: S.of(context).swipeToProceed,
                                      ),
                                    );
                                  }),
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
    );
  }
}
