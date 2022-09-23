import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EmployerCountryListWidget extends StatelessWidget {
  final CountryData item;

  const EmployerCountryListWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0.w),
      padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 20.0.w, top: 20.0.h, bottom: 20.0.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        children: <Widget>[
          Container(
            height: 32.0.w,
            width: 32.0.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorDark,
            ),
            child: AppSvg.asset(
              "${AssetUtils.flags}${item.isoCode3?.toLowerCase() ?? ""}.svg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                item.countryName ?? "",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.0.t,
                    fontWeight: FontWeight.w400,
                    color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.very_dark_violet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
