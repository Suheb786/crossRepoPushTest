import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0) + const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2) + const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: AppColor.darkModerateLimeGreen),
              child: Text(
                data.lineItems.first.status ?? '',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              )),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: data.cardImage ?? '',
                  placeholder: (context, url) => Container(color: AppColor.brightBlue),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsetsDirectional.only(start: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          data.lineItems.first.cardItemName ?? '',
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.gray_black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          TimeUtils.getFormattedTimeForTransaction(data.creationDate.toString()),
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.gray1,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 17, top: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.lineItems.first.value.toString(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.dark_brown,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data.lineItems.first.currency ?? '',
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.gray1,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
