import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/constants/enum/evoucher_history_status_enum.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class MyVoucherHistoryWidget extends StatelessWidget {
  VoucherDetail data;

  MyVoucherHistoryWidget(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w) + EdgeInsets.only(top: 16.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h) + EdgeInsets.only(top: 4.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: getColor(data.lineItems.first.status, context)),
              child: Text(
                data.lineItems.first.status?.getEvoucherTransactionHistoryStatus(context: context) ?? '',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10.t,
                    fontWeight: FontWeight.w600),
              )),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: data.cardImage,
                  placeholder: (context, url) =>
                      Container(color: Theme.of(context).colorScheme.secondaryContainer),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsetsDirectional.only(start: 12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h),
                        Text(
                          data.lineItems.first.cardItemName ?? '',
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.shadow,
                            fontSize: 16.t,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          TimeUtils.getFormattedTimeForTransaction(data.creationDate.toString()),
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.onInverseSurface,
                              fontSize: 12.t,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 17.w, top: 4.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "- " + data.lineItems.first.value.toString(),
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.scrim,
                            fontSize: 14.t,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        data.lineItems.first.currency ?? '',
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.onInverseSurface,
                            fontSize: 10.t,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Color getColor(EvoucherHistoryStatusEnum? value, context) {
    switch (value) {
      case EvoucherHistoryStatusEnum.FAILED:
        return Theme.of(context).colorScheme.scrim;
      case EvoucherHistoryStatusEnum.PENDING:
        return Theme.of(context).colorScheme.onTertiaryContainer;
      case EvoucherHistoryStatusEnum.SUCCESS:
        return Theme.of(context).colorScheme.secondaryContainer;

      case EvoucherHistoryStatusEnum.UNAVAILABLE:
        return Theme.of(context).colorScheme.error;

      default:
        return Theme.of(context).dialogBackgroundColor;
    }
  }
}

extension EvoucherTransactionHistoryStatusExt on EvoucherHistoryStatusEnum {
  String getEvoucherTransactionHistoryStatus({required BuildContext context}) {
    switch (this) {
      case EvoucherHistoryStatusEnum.FAILED:
        return S.of(context).failed;
      case EvoucherHistoryStatusEnum.PENDING:
        return S.of(context).pending;
      case EvoucherHistoryStatusEnum.SUCCESS:
        return S.of(context).success.toCapitalized();
      case EvoucherHistoryStatusEnum.UNAVAILABLE:
        return S.of(context).unavailable;

      default:
        return "";
    }
  }
}
