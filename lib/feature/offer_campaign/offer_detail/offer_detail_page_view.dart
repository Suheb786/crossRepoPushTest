// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

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
          color: Colors.red,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: "",
                  placeholder: (context, url) => Container(color: Theme.of(context).primaryColor),
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
    // var htmlDecodedString =
    //     parse(model.argument.selectedVoucherData?.termsAndConditions ?? "").body?.text ?? '';
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
                  text: "Gerard",
                  textSize: 20.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: "15% discount on Debit Card",
                  textSize: 14.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.surfaceTint,
                ),
                SizedBox(height: 16.h),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: "Ends on 27th Sep",
                  textSize: 14.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.surfaceTint,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Container(
                    padding: EdgeInsetsDirectional.only(start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      "2 days left",
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0.t),
                    ),
                  ),
                ),
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
                      Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo",
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.t,
                          fontWeight: FontWeight.w400,
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
}
