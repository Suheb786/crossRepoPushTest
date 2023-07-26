// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';

import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EVoucherCategoryListWidget extends StatelessWidget {
  final VoucherItem? categoryVoucher;
  final String name;

  const EVoucherCategoryListWidget({
    Key? key,
    this.categoryVoucher,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.EVouchersPurchase);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///TODO:use category image here
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 56,
                width: 56,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Theme.of(context).indicatorColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
