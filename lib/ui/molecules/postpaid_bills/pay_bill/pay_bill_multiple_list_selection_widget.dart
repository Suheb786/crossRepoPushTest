import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class MultipleListSelectionWidget extends StatelessWidget {
  final List<ViewPostPaidBillsPageData> data;
  final ViewPostPaidBillsPageViewModel model;
  const MultipleListSelectionWidget({Key? key, required this.model, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  model.selectedItem(index);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(24.0),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.vividYellow,
                        ),
                        child: AppSvg.asset(model.viewPostPaidBillsPageDataList[index].icon),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.viewPostPaidBillsPageDataList[index].billType,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0.t),
                          ),
                          Text(
                            model.viewPostPaidBillsPageDataList[index].billName,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.veryDarkGray2,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0.t),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Due ',
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.veryDarkGray2,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0.t),
                                  children: [
                                TextSpan(
                                    text: model.viewPostPaidBillsPageDataList[index].billAmtDue.toString(),
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.veryDarkGray2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0.t)),
                                TextSpan(
                                    text: ' ' + S.of(context).JOD,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.veryDarkGray2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0.t)),
                              ]))
                        ],
                      ),
                      Spacer(),
                      data![index].isSelected
                          ? Container(
                              height: 40,
                              width: 40,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10, top: 10),
                                child: AppSvg.asset(AssetUtils.tick, color: AppColor.black),
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.vividYellow,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            )
                          : Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(color: AppColor.gray1),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return AppDivider();
            },
            itemCount: model.viewPostPaidBillsPageDataList.length),
      ),
    );
  }
}
