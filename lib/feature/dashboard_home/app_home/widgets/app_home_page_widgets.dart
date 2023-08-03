import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AppHomePageWidgets {
  /// TOP TOTAL WIDGET ...
  static Widget totalBalance(String availableBalance) {
    return Builder(builder: (context) {
      return Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            S.of(context).totalBalance,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                fontSize: 18.0.t,
                color: AppColor.black),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$availableBalance ',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 24.0.t,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColorDark)),
                TextSpan(
                  text: S.of(context).JOD,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0.t,
                      color: AppColor.verLightGray4),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
