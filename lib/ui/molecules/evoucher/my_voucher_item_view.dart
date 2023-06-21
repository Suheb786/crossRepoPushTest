import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class MyVoucherItemView extends StatelessWidget {
  const MyVoucherItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2) + const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.green),
              child: Text(
                "Failed",
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              )),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  AssetUtils.playStationIcon,
                  height: 40,
                  width: 40,
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsetsDirectional.only(start: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(S.of(context).myVoucherItemTitle,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.gray_black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text("6:10PM",
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.gray1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 17),
                child: Text(
                  "-5000",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: AppColor.dark_brown,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                  margin: EdgeInsetsDirectional.only(start: 2),
                  child: Column(
                    children: [
                      Text(
                        'JOD',
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.gray1,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.all(6.0),
                        child: Text(
                          'USD',
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.gray1,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
