import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../ui/molecules/button/app_secondary_button.dart';

class PurchaseVoucherSuccessPageView extends BasePageViewWidget<PurchaseVoucherSuccessPageViewModel> {
  PurchaseVoucherSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PurchaseVoucherSuccessPageViewModel model) {
    return Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 72.h),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AssetUtils.line,
                            color: AppColor.softRed,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 111.37.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).canvasColor,
                              ),
                              child: Center(
                                  child: AppSvg.asset(AssetUtils.right,
                                      color: Theme.of(context).primaryColorDark)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          double.parse(model.argument.settlementAmount ?? '').toStringAsFixed(3),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 32.t,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(width: 4.w),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 8.h),
                          child: Text(
                            S.of(context).JOD,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.t,
                                color: Theme.of(context).textTheme.titleSmall?.color),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: Theme.of(context).colorScheme.secondary),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.w),
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
                                fontWeight: FontWeight.w600,
                                fontSize: 14.t,
                                color: Theme.of(context).indicatorColor),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            model.argument.selectedItem.brand,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.t,
                                color: Theme.of(context).indicatorColor),
                          ),
                          SizedBox(height: 24.h),
                          AccountDetails(
                            title: S.current.refNo,
                            value: model.argument.placeOrder?.referenceNo ?? '',
                            showIcon: false,
                          ),
                          SizedBox(height: 16.h),
                          AccountDetails(
                            title: S.current.amount.toCapitalized(),
                            value:
                                "${model.argument.placeOrder?.lineItems?.first.value?.toStringAsFixed(3) ?? 0.0} ${model.argument.placeOrder?.lineItems?.first.currency ?? ""}",
                            showIcon: false,
                          ),
                          //  SizedBox(height: 16.h),
                          Visibility(
                            visible: false,
                            child: AccountDetails(
                              title: S.current.validUntil,
                              value: '-',
                              showIcon: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).date,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: model.argument.placeOrder?.placementDate != null
                                          ? "${TimeUtils.convertDateTimeToDMY(model.argument.placeOrder!.placementDate!)} - "
                                          : '-',
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: model.argument.placeOrder?.placementDate != null
                                          ? "${TimeUtils.convertUTCDateToLocal(model.argument.placeOrder!.placementDate!)}"
                                          : '-',
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.surfaceTint,
                                      ),
                                    )
                                  ]),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            AppSecondaryButton(
              onPressed: () {
                final provider = ProviderScope.containerOf(context).read(
                  evoucherViewModelProvider,
                );

                Navigator.popUntil(context, (route) => route.settings.name == RoutePaths.Evoucher);

                provider.tabChangeNotifier.value = 1;
                provider.myVoucherHistoryList = [];
                provider.getVoucherCategories();
                // to switch to history tab...
                provider.switchTabSubject.safeAdd(1);
              },
              text: S.of(context).viewHistory,
            ),
            SizedBox(height: 24.h),
          ],
        ));
  }
}
