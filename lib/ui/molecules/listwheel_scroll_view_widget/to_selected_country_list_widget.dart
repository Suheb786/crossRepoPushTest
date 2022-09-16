import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view_model.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ToSelectedCountryListWidget extends StatelessWidget {
  final ToSearchCountry item;

  const ToSelectedCountryListWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsetsDirectional.only(start: 24, end: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.searchCountry,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.very_dark_violet
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
