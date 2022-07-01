import 'package:domain/model/country/country.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CountryListItem extends StatelessWidget {
  final Country item;

  const CountryListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsetsDirectional.only(start: 24, end: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: item.isSelected ? AppColor.very_light_gray : null),
      child: Row(
        children: <Widget>[
          Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(item.countryFlag ?? "", package: "country_calling_code_picker"),
                      fit: BoxFit.cover))),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.countryName ?? "",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(fontSize: 14, color: item.isSelected ? AppColor.black : AppColor.white),
              ),
            ),
          ),
          Visibility(visible: item.isSelected, child: AppSvg.asset(AssetUtils.check))
        ],
      ),
    );
  }
}
