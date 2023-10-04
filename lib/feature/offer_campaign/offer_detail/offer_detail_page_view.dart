// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../utils/string_utils.dart';
import 'offer_detail_page_view_model.dart';

class OfferDetailPageView extends BasePageViewWidget<OfferDetailPageViewModel> {
  OfferDetailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Stack(
      children: [
        Container(
          height: 180.h,
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: double.infinity,
                child: Image.memory(
                  model.argument.offers.image,
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
                        color: Theme.of(context).colorScheme.secondary),
                    child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 168.h),
          child: Container(
            width: MediaQuery.of(context).size.width,
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
  OfferDetailPageViewModel model;

  PageDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: model.argument.offers.campaignName ?? '',
                  textSize: 20.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                SizedBox(
                  height: 4.h,
                ),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: model.argument.offers.descriptions ?? '',
                  textSize: 14.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.surfaceTint,
                ),
                SizedBox(height: 16.h),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).endsOn(TimeUtils.getFormattedDateForTransaction(
                      model.argument.offers.campaignValidTill ?? '')),
                  textSize: 14.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.surfaceTint,
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.0.w),
                  child: Container(
                    padding: EdgeInsetsDirectional.only(start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                    decoration: BoxDecoration(
                        color: TimeUtils.differentBetweenTwoDateInDays(
                                    model.argument.offers.campaignValidTill ?? '') <=
                                9
                            ? getColor(OfferType.EARLY)
                            : getColor(OfferType.LATER),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      TimeUtils.differentBetweenTwoDateInDays(model.argument.offers.campaignValidTill ?? '')
                              .toString() +
                          " days left",
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0.t),
                    ),
                  ),
                ),
                Visibility(
                  visible: (model.argument.offers.termsAndConditions ?? '').isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.h,
                      ),
                      EVoucherTextWidget(
                        alignment: AlignmentDirectional.topStart,
                        text: S.of(context).termsAndConditionsSetting,
                        textSize: 14.t,
                        textWeight: FontWeight.w600,
                        textColor: Theme.of(context).colorScheme.shadow,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.w, top: 16.h),
                        child: Column(
                          children: [
                            CustomBulletWithTitle(
                              title: model.argument.offers.termsAndConditions ?? '',
                              fontSize: 14.t,
                              lineHeight: 1.7,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color getColor(OfferType value) {
    switch (value) {
      case OfferType.EARLY:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
