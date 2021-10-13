import 'package:domain/model/country/country.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EmployerCountryListWidget extends StatelessWidget {
  final Country item;

  const EmployerCountryListWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: item.isSelected ? AppColor.dark_violet_3 : AppColor.white),
      child: Row(
        children: <Widget>[
          Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(item.countryFlag ?? "",
                          package: "country_calling_code_picker"),
                      fit: BoxFit.cover))),
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
                        ? AppColor.white
                        : AppColor.very_dark_violet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
