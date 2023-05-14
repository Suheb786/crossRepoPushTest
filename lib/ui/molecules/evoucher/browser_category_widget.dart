import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BrowserByCategoryItemWidget extends StatelessWidget {
  const BrowserByCategoryItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          child: _buildListItem(context),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0, childAspectRatio: 1.0),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.EVouchersListing);
      },
      child: Card(
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          height: 103,
          width: 103.66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvg.asset(
                AssetUtils.processing_voucher_icon,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                S.of(context).games,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.gray_black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
