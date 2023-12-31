import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/constants/enum/evoucher_history_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import '../../../utils/string_utils.dart';
import '../share_voucher/share_voucher_page.dart';
import 'evoucher_detail_page_view_model.dart';

class EvoucherDetailView extends BasePageViewWidget<EVoucherDetailViewModel> {
  EvoucherDetailView(ProviderBase model) : super(model);

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
                  imageUrl: model.argument.selectedVoucherData?.cardFaceImage ?? "",
                  placeholder: (context, url) => Container(color: Theme.of(context).primaryColor),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                top: 47.h,
                start: 24.w,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 48.w,
                    width: 48.w,
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
  EVoucherDetailViewModel model;

  PageDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var htmlDecodedString =
        parse(model.argument.selectedVoucherData?.termsAndConditions ?? "").body?.text ?? '';
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: model.argument.selectedVoucherData?.brand ?? "",
                  textSize: 12.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                SizedBox(height: 8.h),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: model.argument.selectedVoucherData?.name ?? "",
                  textSize: 20.t,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                //  SizedBox(height: 8.h),
                Visibility(
                  visible: false,
                  child: EVoucherTextWidget(
                    alignment: AlignmentDirectional.topStart,
                    text: S.of(context).validUntil + " " + "--",
                    textSize: 14.t,
                    textWeight: FontWeight.w400,
                    textColor: Theme.of(context).colorScheme.shadow,
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.argument.selectedVoucherData?.fromValue.toStringAsFixed(3) ?? "",
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontSize: 24.t,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 8.0.w, bottom: 4.h),
                          child: Text(
                            model.argument.selectedVoucherData?.currency ?? "",
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
                Visibility(
                  visible: (model.argument.selectedVoucherData?.termsAndConditions ?? '').isNotEmpty,
                  child: EVoucherTextWidget(
                    alignment: AlignmentDirectional.topStart,
                    text: S.of(context).termsAndConditionsSetting,
                    textSize: 14.t,
                    textWeight: FontWeight.w600,
                    textColor: Theme.of(context).colorScheme.shadow,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.w, top: 16.h),
                  child: Column(
                    children: [
                      Text(
                        Bidi.stripHtmlIfNeeded(htmlDecodedString),
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
        SizedBox(height: 24.h),
        ViewVoucherBtb(
          model: model,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}

class ViewVoucherBtb extends StatelessWidget {
  EVoucherDetailViewModel model;

  ViewVoucherBtb({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w),
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, RoutePaths.ShareVoucher);

          if (model.argument.voucherDetail?.lineItems.first.status == EvoucherHistoryStatusEnum.SUCCESS) {
            Navigator.pushNamed(context, RoutePaths.ShareVoucher,
                arguments: ShareVoucherPageArgument(model.argument.voucherDetail));
          } else {
            InformationDialog.show(context,
                image: AssetUtils.processing_voucher_icon,
                imageHight: 40.h,
                imageWidth: 40.w,
                title: S.of(context).evoucherUnderProcessing,
                descriptionWidget: Text(
                  S.of(context).viewVoucherDialogDescription,
                  style: TextStyle(fontSize: 14.t, fontWeight: FontWeight.w400),
                ), onSelected: () {
              Navigator.pop(context);
            }, onDismissed: () {
              Navigator.pop(context);
            });
          }
        },
        child: Container(
          height: 56.h,
          child: EVoucherTextWidget(
            alignment: AlignmentDirectional.center,
            text: S.of(context).viewVoucher,
            textSize: 14.t,
            textWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.inverseSurface),
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.all(
                Radius.circular(40.w),
              )),
        ),
      ),
    );
  }
}
