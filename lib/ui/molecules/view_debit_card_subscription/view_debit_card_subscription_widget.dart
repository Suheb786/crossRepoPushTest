import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ViewDebitCardSubscriptionWidget extends StatelessWidget {
  const ViewDebitCardSubscriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16, bottom: 32),
      color: Theme.of(context).colorScheme.secondary,
      child: ListView.separated(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 17),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(AssetUtils.viewSubscription),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Netflix US",
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  "8.51",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 2, top: 4),
                                  child: Text(
                                    "JOD/YR",
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.gray1),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.gray1,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        shrinkWrap: true,
        itemCount: 6,
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              height: 1,
              color: AppColor.light_grayish_violet,
            ),
          );
        },
      ),
    );
  }
}
