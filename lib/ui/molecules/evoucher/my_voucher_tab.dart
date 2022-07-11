import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import '../app_keyboard_hide.dart';
import 'evoucher_text_widget.dart';

class MyVoucherTab extends StatefulWidget {
  MyVoucherTab({Key? key}) : super(key: key);

  @override
  State<MyVoucherTab> createState() => _MyVoucherTabState();
}

class _MyVoucherTabState extends State<MyVoucherTab> {
  Widget groupItemList() {
    List<dynamic> _elements = [
      {
        'date': '16 September',
        'status': 'Pending',
        'titele': "FIFA 22 Promo Packs Lorem Ipsum",
        "amt": '5000'
      },
      {
        'date': '16 September',
        'status': 'failed',
        'titele': "FIFA 22 Promo Packs Lorem Ipsum",
        "amt": '5000'
      },
      {
        'date': '19 September',
        'status': 'available',
        'titele': "FIFA 22 Promo Packs Lorem Ipsum",
        "amt": '5000'
      },
      {
        'date': '20 September',
        'status': 'Success',
        'titele': "FIFA 22 Promo Packs Lorem Ipsum",
        "amt": '5000'
      },
      {
        'date': '21 September',
        'status': 'unavailable',
        'titele': "FIFA 22 Promo Packs Lorem Ipsum",
        "amt": '5000'
      },
    ];

    return GroupedListView<dynamic, String>(
      elements: _elements,
      shrinkWrap: true,
      groupBy: (element) => element['date'],
      groupSeparatorBuilder: (String groupByValue) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32,
          ),
          Container(
              child: Text(
            groupByValue.toString(),
            style: TextStyle(
                color: AppColor.gray_black,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          )), //title
          SizedBox(
            height: 16,
          ),
        ],
      ),
      itemBuilder: (context, dynamic element) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.PurchaseNowDetail);
          },
          child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.light_grayish_violet,
                      blurRadius: 1.4,
                      spreadRadius: 1.8,
                      offset: Offset(0.0, 1.0)),
                ],
              ),
              constraints: BoxConstraints(minHeight: 125),
              child: BuildItem()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppKeyBoardHide(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            AppTextField(
              labelText: "",
              hintText: S.of(context).eVoucherSearchLabel,
            ),
            groupItemList(),
          ],
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 18),
          child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.green),
              child: Text(
                "Failed",
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetUtils.playStationIcon),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).myVoucherItemTitle,
                            style: TextStyle(
                                color: AppColor.gray_black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        Text("6:10PM",
                            style: TextStyle(
                                color: AppColor.gray1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(left: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "-5000",
                        style: TextStyle(
                            color: AppColor.dark_brown,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "4.9",
                        style: TextStyle(
                            color: AppColor.dark_gray_1,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Column(
                    children: [
                      Text(
                        'JOD',
                        style: TextStyle(
                            color: AppColor.gray1,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'USD',
                          style: TextStyle(
                              color: AppColor.gray1,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
