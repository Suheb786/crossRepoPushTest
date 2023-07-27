import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';
import '../purchase_evoucher_without_region/purchase_evoucher_without_region_page.dart';

class PurchaseNowDetailView extends BasePageViewWidget<PurchaseNowDetailViewModel> {
  PurchaseNowDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Stack(
      children: [
        Container(
          height: 180,
          color: Colors.yellow,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 24),
              Positioned.directional(
                textDirection: Directionality.of(context),
                top: 47,
                start: 33,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    color: Colors.white,
                    width: 56,
                    height: 56,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 168),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            child: PageDetail(),
          ),
        ),
      ],
    );
  }
}

class PageDetail extends StatelessWidget {
  const PageDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).buyVoucherDetailTitle,
                  textSize: 12,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 8),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).buyVoucherDetailSubTitle,
                  textSize: 20,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                const SizedBox(height: 8),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).buyVoucherDetailSubSubTitle,
                  textSize: 14,
                  textWeight: FontWeight.w400,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).amt,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8.0, bottom: 4),
                          child: Text(
                            S.of(context).JOD,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.verLightGray4,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).termsAndConditionsSetting,
                  textSize: 14,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0, end: 24, top: 16),
                  child: Column(
                    children: [
                      CustomBulletWithTitle(
                        title:
                            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ',
                        fontSize: 14,
                        lineHeight: 1.5,
                      ),
                      CustomBulletWithTitle(
                        title:
                            'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.  ',
                        fontSize: 14,
                        lineHeight: 1.5,
                      ),
                      CustomBulletWithTitle(
                        title:
                            'Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.',
                        fontSize: 14,
                        lineHeight: 1.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        PurchaseNowBtn(),
        const SizedBox(height: 50),
      ],
    );
  }
}

class PurchaseNowBtn extends StatelessWidget {
  const PurchaseNowBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: AppPrimaryButton(
        isDisabled: false,
        onPressed: () {
          // PurchaseNowDialog.show(context,
          //     image: AssetUtils.processing_voucher_icon,
          //     title: S.of(context).purchaseNowTitle,
          //     descriptionWidget: Text(
          //       S.of(context).viewVoucherDialogDescription,
          //       style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w400),
          //     ), onSelected: () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, RoutePaths.EnterCodeEVoucherPurchase);
          // }, onDismissed: () {
          //   Navigator.pop(context);
          // }, price: S.of(context).amt, subTitle: S.of(context).purchaseNowSubTitle);
          Navigator.pushNamed(context, RoutePaths.PurchaseEVoucherWithoutRegionPage,
              arguments: PurchaseEVoucherWithoutRegionPageArgument(
                  voucherItems: [
                    VoucherItem(
                        id: "2323",
                        name: "Playstation",
                        usageInstructions: "usageInstructions",
                        termsAndConditions: "termsAndConditions",
                        giftCardInformation: "giftCardInformation",
                        brand: "brand",
                        currency: "JOD",
                        fromValue: 1.22,
                        toValue: 200,
                        cardFaceImage: "fdasf",
                        cardFaceHash: "",
                        productId: 123,
                        categories: ["", "to", "toma"],
                        discount: "discount",
                        countryCode: "JD"),
                    VoucherItem(
                        id: "2323",
                        name: "Playstation",
                        usageInstructions: "usageInstructions",
                        termsAndConditions: "termsAndConditions",
                        giftCardInformation: "giftCardInformation",
                        brand: "brand",
                        currency: "JOD",
                        fromValue: 1.22,
                        toValue: 200,
                        cardFaceImage: "fdasf",
                        cardFaceHash: "",
                        productId: 123,
                        categories: ["", "to", "toma"],
                        discount: "discount",
                        countryCode: "JD")
                  ],
                  selectedItem: VoucherItem(
                      id: "2323",
                      name: "Playstation",
                      usageInstructions: "usageInstructions",
                      termsAndConditions: "termsAndConditions",
                      giftCardInformation: "giftCardInformation",
                      brand: "brand",
                      currency: "JOD",
                      fromValue: 1.22,
                      toValue: 200,
                      cardFaceImage: "fdasf",
                      cardFaceHash: "",
                      productId: 123,
                      categories: ["", "to", "toma"],
                      discount: "discount",
                      countryCode: "JD")));
        },
        text: S.of(context).purchaseNow,
      ),
    );
  }
}
