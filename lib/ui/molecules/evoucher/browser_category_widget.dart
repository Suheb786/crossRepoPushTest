import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BrowserByCategoryItemWidget extends StatelessWidget {
  List<VoucherCategories> categories;
  Function(VoucherCategories) onSelectCategory;

  BrowserByCategoryItemWidget(this.categories, {required this.onSelectCategory, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: const EdgeInsets.only(top: 24),
      itemBuilder: (context, index) {
        return Container(
          child: _buildListItem(context, categories[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: AppDivider(),
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, VoucherCategories category) {
    return InkWell(
      onTap: () {
        onSelectCategory(category);

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              border: Border.all(color: AppColor.gray1, width: 1),
            ),
            alignment: Alignment.center,
            child: AppSvg.asset(
              AssetUtils.processing_voucher_icon,
              color: AppColor.brightBlue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              category.bankCategory,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.gray_black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
