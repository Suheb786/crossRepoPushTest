import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:domain/model/e_voucher/place_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/molecules/button/app_primary_button.dart';
import '../../purchase_voucher_success/purchase_voucher_success_page.dart';
import 'otp_purchase_evoucher_without_region_page_view_model.dart';

class OtpPurchaseEvoucherWithoutRegionPageView
    extends BasePageViewWidget<OtpPurchaseEvoucherWithoutRegionPageViewModel> {
  OtpPurchaseEvoucherWithoutRegionPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<PlaceOrder>>(
                initialData: Resource.none(),
                stream: model.placeOrderStream,
                onData: (value) {
                  if (value.status == Status.SUCCESS) {
                    Navigator.pushNamed(context, RoutePaths.EVouchersPurchaseSuccess,
                        arguments: PurchaseVoucherSuccessArgument(
                            selectedItem: model.argument.selectedItem,
                            placeOrder: value.data,
                            settlementAmount: (model.argument.settlementAmount).toString()));
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.enterOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        model.placeOrder(
                            sourceAccount: ProviderScope.containerOf(context)
                                    .read(settlementAccountViewModelProvider(model.argument))
                                    .selectedAccount
                                    ?.iban ??
                                '',
                            sourceCurrency: "JOD",
                            cardItemId: model.argument.selectedItem.id,
                            exchangeRate: double.parse(model.argument.selectedItem.exchangeRate),
                            voucherCurrency: model.argument.selectedItem.currency,
                            reconciliationCurrency: model.argument.selectedItem.reconciliationCurrency,
                            equivalentAmount: (model.argument.selectedItem.fromValue.toDouble() *
                                    double.parse(model.argument.selectedItem.exchangeRate))
                                .toString(),
                            denomination: model.argument.selectedItem.fromValue.toInt(),
                            discount: model.argument.selectedItem.discount.replaceAll('%', ''),
                            categories: model.argument.selectedItem.categories.join(','),
                            voucherName: model.argument.selectedItem.name,
                            productId: model.argument.selectedItem.productId.toString(),
                            productName: "",
                            otpCode: model.otpController.text,
                            getToken: true);
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return Card(
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
                                    AppStreamBuilder<Resource<EVoucherOTP>>(
                                        stream: model.evoucherOtpStream,
                                        initialData: Resource.none(),
                                        dataBuilder: (context, otpSnapshot) {
                                          return CountdownTimer(
                                            controller: model.countDownController,
                                            onEnd: () {},
                                            endTime: model.endTime,
                                            textStyle: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 16.t,
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
                                                            color: Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .color!),
                                                      ))
                                                  : Text(
                                                      S.of(context).resendIn(
                                                          '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color:
                                                              Theme.of(context).textTheme.bodyLarge!.color!),
                                                    );
                                            },
                                          );
                                        }),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return AppPrimaryButton(
                                              text: S.of(context).next,
                                              isDisabled: !isValid!,
                                              onPressed: () {
                                                model.validateOtp();
                                              },
                                            );
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ProviderScope.containerOf(context)
                                            .read(purchaseEVoucherWithoutRegionPageViewModel(model.argument))
                                            .previousPage();
                                      },
                                      child: Text(
                                        S.of(context).back,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
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
