import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/e_voucher/place_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

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
            child: AppStreamBuilder<Resource<PlaceOrder>>(
                initialData: Resource.none(),
                stream: model.placeOrderStream,
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    Navigator.pushNamed(context, RoutePaths.EVouchersPurchaseSuccess,
                        arguments: PurchaseVoucherSuccessArgument(
                            placeOrder: data.data,
                            settlementAmount: ProviderScope.containerOf(context)
                                .read(selectAmountRegionViewModelProvider)
                                .settlementAmount
                                .toString(),
                            selectedItem: ProviderScope.containerOf(context)
                                .read(selectAmountRegionViewModelProvider)
                                .selectedItem));
                  }
                },
                dataBuilder: (context, placeOrderData) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.enterOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        var item = ProviderScope.containerOf(context)
                            .read(selectAmountRegionViewModelProvider)
                            .selectedItem;
                        model.placeOrder(
                            sourceAccount: ProviderScope.containerOf(context)
                                .read(appHomeViewModelProvider)
                                .dashboardDataContent
                                .account
                                ?.iban,
                            sourceCurrency: "JOD",
                            cardItemId: item.id,
                            exchangeRate: double.parse(item.exchangeRate),
                            voucherCurrency: item.currency,
                            reconciliationCurrency: item.reconciliationCurrency,
                            equivalentAmount: ProviderScope.containerOf(context)
                                .read(selectAmountRegionViewModelProvider)
                                .settlementAmount
                                .toString(),
                            denomination: item.fromValue.toInt(),
                            discount: item.discount.replaceAll('%', ''),
                            categories: item.categories.join(','),
                            voucherName: item.name,
                            productId: item.productId.toString(),
                            productName: "",
                            otpCode: model.otpController.text,
                            getToken: true);
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
                                    CountdownTimer(
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
                                                  model.makeOTPRequest(
                                                      voucherName: ProviderScope.containerOf(context)
                                                          .read(selectAmountRegionViewModelProvider)
                                                          .selectedItem
                                                          .name);
                                                },
                                                child: Text(
                                                  S.of(context).resendCode,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14.t,
                                                      fontWeight: FontWeight.w600,
                                                      color: Theme.of(context).textTheme.bodyLarge!.color!),
                                                ))
                                            : Text(
                                                S.of(context).resendIn(
                                                    '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 14.t,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context).textTheme.bodyLarge!.color!),
                                              );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0.h,bottom: 16.h),
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
                                            .read(purchaseEVouchersViewModelProvider)
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
