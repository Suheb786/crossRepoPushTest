import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BrowserByCategoryItemWidget extends StatelessWidget {
  List<VoucherCategories> categories;
  Function(VoucherCategories) onSelectCategory;

  BrowserByCategoryItemWidget(this.categories,
      {required this.onSelectCategory, Key? key})
      : super(key: key);

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
        print("category.categoryIcon===>${category.categoryIcon}");
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
            child:
                //MemoryImage()
                Image.memory(
              category.categoryIcon,
              //   fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              category.categoryName ?? '',
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
