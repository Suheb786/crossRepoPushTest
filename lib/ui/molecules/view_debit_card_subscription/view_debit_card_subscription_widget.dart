import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ViewDebitCardSubscriptionWidget extends StatelessWidget {
  const ViewDebitCardSubscriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.only(top: 16, bottom: 32),
          color: Theme.of(context).accentColor,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(AssetUtils.viewSubscription),
                      )),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Netflix US",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "8.51",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2, top: 4),
                                    child: Text(
                                      "JOD/YR",
                                      style: TextStyle(
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
                                  color: AppColor.gray1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      thickness: 4,
                      color: Colors.red,
                    ),
                  )
                ],
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
        ),
      ],
    );
  }
}
