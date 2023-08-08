import 'package:animated_widgets/animated_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/settlement_amount/settlement_amount_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/app_svg.dart';

class SettlementAmountPageView extends BasePageViewWidget<SettlementAmountPageViewModel> {
  SettlementAmountPageView(
    ProviderBase model,
  ) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<EVoucherOTP>>(
                  initialData: Resource.none(),
                  stream: model.evoucherOtpStream,
                  onData: (value) {
                    if (value.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(purchaseEVoucherWithoutRegionPageViewModel(model.argument))
                          .nextPage();
                      ProviderScope.containerOf(context)
                          .read(otpPurchaseEvoucherWithoutRegionPageViewModelProvider(model.argument))
                          .otpController
                          .clear();
                    }
                  },
                  dataBuilder: (context, snapshot) {
                    return AppStreamBuilder<Resource<bool>>(
                      stream: model.selectAccountStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.getOTP();
                        } else if (data.status == Status.ERROR) {
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(purchaseEVoucherWithoutRegionPageViewModel(model.argument))
                                    .appSwiperController
                                    .page ==
                                0.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.validateFields(context);
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(purchaseEVoucherWithoutRegionPageViewModel(model.argument))
                                      .previousPage();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.validateFields(context);
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(purchaseEVoucherWithoutRegionPageViewModel(model.argument))
                                      .previousPage();
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
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              height: 72.h,
                                              width: 72.w,
                                              child: CachedNetworkImage(
                                                imageUrl: model.argument.selectedItem.cardFaceImage,
                                                placeholder: (context, url) =>
                                                    Container(color: Theme.of(context).primaryColor),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            model.argument.selectedItem.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: Theme.of(context).indicatorColor,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                model.argument.settlementAmount.toStringAsFixed(3),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).indicatorColor,
                                                  fontSize: 24.t,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4.h,
                                              ),
                                              Text(
                                                S.current.JOD,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 32.h,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    S.current.payFrom,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: Theme.of(context).indicatorColor,
                                                      fontSize: 14.t,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.h),
                                                    border: Border.all(
                                                        color:
                                                            Theme.of(context).colorScheme.tertiaryContainer)),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.all(16.h),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  S.current.currentAccount,
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    color: Theme.of(context).indicatorColor,
                                                                    fontSize: 14.t,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 3.h),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  ProviderScope.containerOf(context)
                                                                          .read(appHomeViewModelProvider)
                                                                          .dashboardDataContent
                                                                          .account
                                                                          ?.accountNo ??
                                                                      "",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .inversePrimary,
                                                                    fontSize: 12.t,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 16.h),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.account?.availableBalance}" +
                                                                      " " +
                                                                      "${S.current.JOD}",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    color: Theme.of(context).indicatorColor,
                                                                    fontSize: 14.t,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      AppStreamBuilder<bool>(
                                                          stream: model.isCheckedStream,
                                                          initialData: false,
                                                          dataBuilder: (context, isChecked) {
                                                            return isChecked!
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      model.check(false);
                                                                      model.validate();
                                                                    },
                                                                    child: Container(
                                                                      height: 40.h,
                                                                      width: 40.h,
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              Theme.of(context).canvasColor,
                                                                          border: Border.all(
                                                                            color: Theme.of(context)
                                                                                .indicatorColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100)),
                                                                      child: AppSvg.asset(AssetUtils.check,
                                                                          color: Theme.of(context)
                                                                              .indicatorColor,
                                                                          height: 16.h,
                                                                          fit: BoxFit.scaleDown,
                                                                          width: 16.h),
                                                                    ),
                                                                  )
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      model.check(true);
                                                                      model.validate();
                                                                    },
                                                                    child: Container(
                                                                      height: 40.h,
                                                                      width: 40.h,
                                                                      decoration: BoxDecoration(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .secondary,
                                                                          border: Border.all(
                                                                            color: Theme.of(context)
                                                                                .indicatorColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100)),
                                                                    ),
                                                                  );
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(top: 12.0.h, bottom: 23.h),
                                          child: AppStreamBuilder<bool>(
                                            stream: model.showButtonStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return Visibility(
                                                  visible: true,
                                                  child: AnimatedButton(
                                                    buttonText: S.of(context).swipeToProceed,
                                                  ));
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            S.of(context).cancel,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  }),
            );
          }),
    );
  }
}
