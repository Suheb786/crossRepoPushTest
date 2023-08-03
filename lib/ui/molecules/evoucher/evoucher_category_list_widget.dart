import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EVoucherCategoryListWidget extends StatelessWidget {
  final VoucherItem? categoryVoucher;
  final Function()? onTap;
  final String imageUrl;

  const EVoucherCategoryListWidget({
    required this.imageUrl,
    Key? key,
    this.categoryVoucher,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 56,
                width: 56,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Container(color: Theme.of(context).primaryColor),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 24.w),
            Flexible(
              child: Text(
                categoryVoucher?.name ?? "",
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.t,
                    color: Theme.of(context).indicatorColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
