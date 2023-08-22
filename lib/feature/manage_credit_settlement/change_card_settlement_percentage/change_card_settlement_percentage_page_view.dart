import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ChangeCardSettlementPercentagePageView
    extends BasePageViewWidget<ChangeCardSettlementPercentagePageViewModel> {
  ChangeCardSettlementPercentagePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0.h, horizontal: 24.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).changeLinkedAccount.toUpperCase(),
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            S.of(context).selectNewPercentage,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 32.h,
          ),
          Expanded(
              child: AppStreamBuilder<Resource<bool>>(
                  stream: model.updateSettlementStream,
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      Navigator.pushReplacementNamed(context, RoutePaths.CreditCardApplySuccess,
                          arguments: CreditCardApplySuccessArguments(
                              creditSuccessState: CreditSuccessState.Settlement_Percentage_Changed));
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  initialData: Resource.none(),
                  dataBuilder: (context, snapshot) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Text(
                                    S.of(context).currentSettlementPercentage,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.t,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: AppDivider(
                                    color: AppColor.lightGrayishBlue,
                                    indent: 12.w,
                                    endIndent: 8.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.background,
                                            shape: BoxShape.circle),
                                        child: AppSvg.asset(
                                          AssetUtils.percentage,
                                          color: Theme.of(context).primaryColorDark,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        model.arguments?.creditCard.minimumSettlement != null
                                            ? model.arguments!.creditCard.minimumSettlement.toString() + "%"
                                            : "",
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: AppDivider(
                                    color: AppColor.lightGrayishBlue,
                                    indent: 12.w,
                                    endIndent: 8.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  child: AppTextField(
                                    labelText: S.of(context).newSettlementPercentage.toUpperCase(),
                                    hintText: S.of(context).pleaseSelect,
                                    readOnly: true,
                                    controller: model.settlementPercentageController,
                                    key: model.settlementPercentageKey,
                                    onPressed: () {
                                      RelationshipWithCardHolderDialog.show(context,
                                          title: S.of(context).settlementPercentage,
                                          relationSHipWithCardHolder: model.percentageList,
                                          onSelected: (value) {
                                        Navigator.pop(context);
                                        model.settlementPercentageController.text = value;
                                        model.validate();
                                      }, onDismissed: () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    suffixIcon: (value, data) {
                                      return Container(
                                          height: 16.h,
                                          width: 16.w,
                                          padding: EdgeInsetsDirectional.only(end: 8.w),
                                          child: AppSvg.asset(AssetUtils.downArrow,
                                              color: AppColor.dark_gray_1));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0.h),
                                  child: AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return AppPrimaryButton(
                                          text: S.of(context).next,
                                          isDisabled: !isValid!,
                                          onPressed: () {
                                            model.updateSettlement();
                                          },
                                        );
                                      }),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      S.of(context).backToCardSettings,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.brightBlue,
                                        letterSpacing: 1,
                                        fontSize: 14.t,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
