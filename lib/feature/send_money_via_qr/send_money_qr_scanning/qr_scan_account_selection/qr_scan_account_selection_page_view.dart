import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_account_selection/qr_scan_account_selection_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(sendMoneyQrScanningViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              0.0) {
                            if (StringUtils.isDirectionRTL(context)) {
                              if (!details.primaryVelocity!.isNegative) {
                                if (model.payFromController.text.isEmpty) {
                                  model.showErrorState();
                                  model.showToastWithError(AppError(
                                      cause: Exception(),
                                      error: ErrorInfo(message: ''),
                                      type: ErrorType.SELECT_ACCOUNT));
                                } else if (double.parse(ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .dashboardDataContent
                                            .account
                                            ?.availableBalance ??
                                        '-1') <
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
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                if (model.payFromController.text.isEmpty) {
                                  model.payFromKey.currentState?.isValid = false;
                                  model.showToastWithError(AppError(
                                      cause: Exception(),
                                      error: ErrorInfo(message: ''),
                                      type: ErrorType.SELECT_ACCOUNT));
                                } else if (double.parse(ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .dashboardDataContent
                                            .account
                                            ?.availableBalance ??
                                        '-1') <
                                    double.parse(ProviderScope.containerOf(context)
                                            .read(sendMoneyQrScanningViewModelProvider)
                                            .arguments
                                            ?.amount ??
                                        '')) {
                                  model.showToastWithError(AppError(
                                      cause: Exception(),
                                      error: ErrorInfo(message: ''),
                                      type: ErrorType.INSUFFICIENT_BALANCE_TRANSFER));
                                } else {
                                  model.generateOtp();
                                }
                              }
                            }
                          }
                        },
                        child: Card(
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
                                      padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.h, end: 24.w),
                                      child: AppTextField(
                                        labelText: S.of(context).payFrom.toUpperCase(),
                                        hintText: S.of(context).pleaseSelect,
                                        controller: model.payFromController,
                                        key: model.payFromKey,
                                        readOnly: true,
                                        onPressed: () {
                                          AccountsDialog.show(context, label: S.of(context).selectAccount,
                                              onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.payFromController.text = value;
                                            model.validate();
                                          }, accountsList: [
                                            ProviderScope.containerOf(context)
                                                    .read(appHomeViewModelProvider)
                                                    .dashboardDataContent
                                                    .account
                                                    ?.accountNo ??
                                                ''
                                          ]);
                                        },
                                        suffixIcon: (isValid, value) {
                                          return Container(
                                              height: 16.h,
                                              width: 16.w,
                                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                                              child: AppSvg.asset(AssetUtils.downArrow,
                                                  color: Theme.of(context).primaryColorDark));
                                        },
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
                                          padding: EdgeInsetsDirectional.only(top: 26.0.h, bottom: 24.h),
                                          child: Visibility(
                                            visible: isValid!,
                                            child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                          ),
                                        );
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
}
