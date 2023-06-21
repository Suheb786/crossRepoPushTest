import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BrowserByCategoryItemWidget extends StatelessWidget {
  const BrowserByCategoryItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: const EdgeInsets.only(top: 24),
      itemBuilder: (context, index) {
        return Container(
          child: _buildListItem(context),
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

  Widget _buildListItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.EVouchersListing);
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
              S.of(context).games,
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
