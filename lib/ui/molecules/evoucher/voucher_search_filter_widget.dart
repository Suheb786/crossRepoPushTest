import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class VoucherSearchAndFilterWidget extends StatelessWidget {
  List<VoucherItem> voucherItems;
  Function(VoucherItem) onSelectSelectedVoucher;

  VoucherSearchAndFilterWidget(this.voucherItems, {required this.onSelectSelectedVoucher, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: voucherItems.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildItem(voucherItems[index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 185.h,
          crossAxisCount: 2,
          crossAxisSpacing: 0.2,
          mainAxisSpacing: 40.h,
          childAspectRatio: 1),
    );
  }

  Widget _buildItem(VoucherItem voucherItem) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          onSelectSelectedVoucher(voucherItem);
        },
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.zero,
                width: 155.5.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.w)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0, -0), blurRadius: 16.0),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(voucherItem.cardFaceImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 5.w),
                child: Text(
                  voucherItem.brand,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 12.t,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 5.w),
                  child: Text(
                    voucherItem.name,
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.shadow,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 5.w),
                child: Text(
                  voucherItem.fromValue.toStringAsFixed(3) + " " + voucherItem.currency,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.shadow,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
