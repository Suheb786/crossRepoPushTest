import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_account_selection/qr_scan_account_selection_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import '../../../payment/account_swiching/payment_account_switcher.dart';

class QRScanAccountSelectionPageView extends BasePageViewWidget<QRScanAccountSelectionPageViewModel> {
  QRScanAccountSelectionPageView(ProviderBase model) : super(model);

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
                    stream: model.generateOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(qrScanOTPViewModelProvider)
                            .otpController
                            .clear();

                        ProviderScope.containerOf(context)
                            .read(sendMoneyQrScanningViewModelProvider)
                            .nextPage();
                      }
                    },
                    dataBuilder: (context, otpGenerateResponse) {
                      return Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  Text(
                                    S.of(context).amount,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.t,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          num.parse(ProviderScope.containerOf(context)
                                                      .read(sendMoneyQrScanningViewModelProvider)
                                                      .arguments
                                                      ?.amount ??
                                                  '')
                                              .toStringAsFixed(3),
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.t,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: 4.0.w, top: 2.h),
                                          child: Text(
                                            S.of(context).JOD,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.t,
                                                color: AppColor.verLightGray4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 32.h, start: 24.w, end: 24.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.of(context).nameOfBeneficiary,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.t,
                                              color: AppColor.dark_gray_1),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: 4.0.w),
                                          child: Text(
                                            ProviderScope.containerOf(context)
                                                    .read(sendMoneyQrScanningViewModelProvider)
                                                    .arguments
                                                    ?.accountHolderName ??
                                                '',
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.t,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 32.h, start: 24.w, end: 24.w),
                                    child: PaymentAccountSwitcher(
                                      title: S.of(context).payFrom,
                                      onDefaultSelectedAccount: (Account account) {
                                        model.selectedAccount = account;
                                        model.validate();
                                      },
                                      onSelectAccount: (Account account) {
                                        model.selectedAccount = account;
                                        model.validate();
                                      },
                                      isSingleLineView: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                AppStreamBuilder<bool>(
                                    stream: model.showButtonStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 24.w, top: 26.0.h, end: 24.w, bottom: 24.h),
                                        child: AppPrimaryButton(
                                          text: S.of(context).next,
                                          isDisabled: !isValid!,
                                          onPressed: () {
                                            if (double.parse(model.selectedAccount.availableBalance ?? '-1') <
                                                double.parse(ProviderScope.containerOf(context)
                                                        .read(sendMoneyQrScanningViewModelProvider)
                                                        .arguments
                                                        ?.amount ??
                                                    '')) {
                                              model.showErrorState();
                                              model.showToastWithError(AppError(
                                                  cause: Exception(),
                                                  error: ErrorInfo(message: ''),
                                                  type: ErrorType.INSUFFICIENT_BALANCE_TRANSFER));
                                            } else {
                                              model.generateOtp();
                                            }
                                          },
                                        ),
                                      );
                                    }),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              );
            }));
  }
}
