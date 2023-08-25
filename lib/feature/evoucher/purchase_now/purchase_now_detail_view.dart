import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/constants/app_constants.dart';
import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/button/app_primary_button.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';

class PurchaseNowDetailView extends BasePageViewWidget<PurchaseNowDetailViewModel> {
  PurchaseNowDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Stack(
      children: [
        Container(
          height: 180.h,
          width: double.infinity,
          color: Colors.transparent,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: model.argument.selectedVoucherItem.cardFaceImage,
                  placeholder: (context, url) =>
                      Container(color: Theme
                          .of(context)
                          .primaryColor),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                top: 47.h,
                start: 33.w,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 56.h,
                    width: 56.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.w),
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),
                    child: Icon(Icons.arrow_back, color: Theme
                        .of(context)
                        .colorScheme
                        .onSecondaryContainer),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 168.h),
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
            child: PageDetail(
              model: model,
            ),
          ),
        ),
      ],
    );
  }
}

class PageDetail extends StatelessWidget {
  PurchaseNowDetailViewModel model;

  PageDetail({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var htmlDecodedString = parse(model.argument.selectedVoucherItem.termsAndConditions).body?.text ?? "";

    return AppStreamBuilder<Resource<GetSettlementAmount>>(
        initialData: Resource.none(),
        stream: model.getSettlementAmountStream,
        onData: (d) {
          if (d.status == Status.SUCCESS) {
            Navigator.pushNamed(context, RoutePaths.PurchaseEVoucherWithoutRegionPage,
                arguments: PurchaseEVoucherWithoutRegionPageArgument(
                  settlementAmount: d.data?.content ?? 0.0,
                  selectedItem: model.argument.selectedVoucherItem,
                ));
          }
        },
        dataBuilder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      EVoucherTextWidget(
                        alignment: AlignmentDirectional.topStart,
                        text: model.argument.selectedVoucherItem.brand,
                        textSize: 12.t,
                        textWeight: FontWeight.w600,
                        textColor: Theme
                            .of(context)
                            .colorScheme
                            .inversePrimary,
                      ),
                      SizedBox(height: 8.h),
                      EVoucherTextWidget(
                        alignment: AlignmentDirectional.topStart,
                        text: model.argument.selectedVoucherItem.name,
                        textSize: 20.t,
                        textWeight: FontWeight.w600,
                        textColor: Theme
                            .of(context)
                            .colorScheme
                            .shadow,
                      ),
                      SizedBox(height: 8.h),
                      EVoucherTextWidget(
                        alignment: AlignmentDirectional.topStart,
                        text: S
                            .of(context)
                            .validUntil + " " + "--",
                        textSize: 14.t,
                        textWeight: FontWeight.w400,
                        textColor: Theme
                            .of(context)
                            .colorScheme
                            .shadow,
                      ),
                      SizedBox(height: 24.h),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                num.parse(model.argument.selectedVoucherItem.fromValue.toString())
                                    .toStringAsFixed(3),
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                    fontSize: 24.t,
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(start: 8.0, bottom: 4),
                                child: Text(
                                  model.argument.selectedVoucherItem.currency,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.verLightGray4,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      EVoucherTextWidget(
                        alignment: AlignmentDirectional.topStart,
                        text: S
                            .of(context)
                            .termsAndConditionsSetting,
                        textSize: 14,
                        textWeight: FontWeight.w600,
                        textColor: Theme
                            .of(context)
                            .colorScheme
                            .shadow,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.w, top: 16.h),
                        child: Column(
                          children: [
                            CustomBulletWithTitle(
                              title: Bidi.stripHtmlIfNeeded(htmlDecodedString),
                              fontSize: 14.t,
                              lineHeight: 1.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              PurchaseNowBtn(
                model: model,
              ),
              SizedBox(height: 50.h),
            ],
          );
        });
  }
}

class PurchaseNowBtn extends StatelessWidget {
  PurchaseNowDetailViewModel model;

  PurchaseNowBtn({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: AppPrimaryButton(
        isDisabled: false,
        onPressed: () {
          model.getSettlementAmmount(
              Amount: (model.argument.selectedVoucherItem.fromValue.toDouble() *
                  double.parse(model.argument.selectedVoucherItem.exchangeRate)).toString(),
              FromCurrency: AppConstantsUtils.usdCurrency,
              ToCurrency: AppConstantsUtils.jodCurrency);
        },
        text: S
            .of(context)
            .purchaseNow,
      ),
    );
  }
}
