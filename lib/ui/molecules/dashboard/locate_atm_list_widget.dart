import 'package:domain/model/dashboard/get_atms/atm_content_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class LocateATMListWidget extends StatelessWidget {
  final AtmContentData? atmContentData;
  final Function()? onTap;

  const LocateATMListWidget({Key? key, this.atmContentData, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      atmContentData!.bankName!,
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      atmContentData!.bankAddress!,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        S.of(context).getDirections,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyMedium!.color!),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 39,
              ),
              Text(
                '0.8 km',
                style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            height: 1,
            color: AppColor.light_grayish_violet,
          ),
        ),
      ],
    );
  }
}
