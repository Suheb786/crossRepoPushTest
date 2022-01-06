import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EmployerCountryListWidget extends StatelessWidget {
  final CountryData item;

  const EmployerCountryListWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        children: <Widget>[
          Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColorDark

                  ///TODO: uncomment later
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //         "${AssetUtils.flags}${item.isoCode3?.toLowerCase() ?? ""}.png"),
                  //     fit: BoxFit.cover)

                  )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.countryName ?? "",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: item.isSelected
                        ? Theme.of(context).primaryColorDark
                        : AppColor.very_dark_violet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
