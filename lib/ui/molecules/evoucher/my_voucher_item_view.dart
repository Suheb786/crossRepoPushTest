import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class MyVoucherItemView extends StatelessWidget {
  VoucherDetail data;

  MyVoucherItemView(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w) +
          EdgeInsets.only(top: 16.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h) +
                  EdgeInsets.only(top: 4.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: Text(
                data.lineItems.first.status ?? '',
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.w)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: data.cardImage ?? '',
                  placeholder: (context, url) => Container(
                      color: Theme.of(context).colorScheme.secondaryContainer),
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
                          TimeUtils.getFormattedTimeForTransaction(
                              data.creationDate.toString()),
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                              fontSize: 12.t,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 17.w, top: 4.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "-" + data.lineItems.first.value.toString(),
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
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
