import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../main/navigation/route_paths.dart';

class EnterOtpForEVoucherCategoryPurchasePageView
    extends BasePageViewWidget<EnterOtpForEVoucherCategoryPurchasePageViewModel> {
  EnterOtpForEVoucherCategoryPurchasePageView(ProviderBase model) : super(model);

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
              stream: model.enterOtpStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  model.placeOrder(
                      exchangeRate: "exchangeRate",
                      Denomination: "Denomination",
                      reconcilationCurrency: "reconcilationCurrency",
                      Discount: "Discount",
                      VoucherName: "VoucherName",
                      VoucherCategory: "VoucherCategory",
                      AccountNo: "AccountNo");

                  Navigator.pushNamed(context, RoutePaths.EVouchersPurchaseSuccess,
                      arguments: PurchaseVoucherSuccessArgument(selectedItem: model.argument.selectedItem));

                  print("Go to Placce Order");
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(purchaseEVouchersViewModelProvider(model.argument))
                            .appSwiperController
                            .page ==
                        2.0) {
                      FocusScope.of(context).unfocus();
                      if (StringUtils.isDirectionRTL(context)) {
                        if (!details.primaryVelocity!.isNegative) {
                          model.validateOtp();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(purchaseEVouchersViewModelProvider(model.argument))
                              .previousPage();
                          // .previous(animation: true);
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          model.validateOtp();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(purchaseEVouchersViewModelProvider(model.argument))
                              .previousPage();
                          // .previous(animation: true);
                        }
                      }
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                      fontSize: 16,
                                      color: Theme.of(context).textTheme.bodyMedium!.color!),
                                  widgetBuilder: (context, currentTimeRemaining) {
                                    return currentTimeRemaining == null
                                        ? TextButton(
                                            onPressed: () {
                                              model.makeOTPRequest();
                                            },
                                            child: Text(
                                              S.of(context).resendCode,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context).textTheme.bodyLarge!.color!),
                                            ))
                                        : Text(
                                            S.of(context).resendIn(
                                                '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).textTheme.bodyLarge!.color!),
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
              },
            ),
          );
        },
      ),
    );
  }
}
