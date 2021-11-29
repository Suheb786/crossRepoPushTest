import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_detail/card_detail_view_model.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CardDetailPageView extends BasePageViewWidget<CardDetailViewModel> {
  CardDetailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        color: Theme.of(context).canvasColor,
        margin: EdgeInsets.zero,
        shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 27.0, bottom: 29, top: 38, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Zein Malhas",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Flip back",
                      style: TextStyle(
                          color: AppColor.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 63),
                  child: Text(
                    "8451 1353 1245 3421",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "CARD NUMBER",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColor.green),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 19),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 21),
                  child: Text(
                    "140591314151414",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "LINKED ACCOUNT NUMBER",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColor.green),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 19),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 21, bottom: 128),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "08/23",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "EXPIRY DATE",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.green,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 59.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "688",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "CVV",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColor.green,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
