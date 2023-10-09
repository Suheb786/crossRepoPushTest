import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/manage_credit_settlement_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageCreditSettlementPageView extends BasePageViewWidget<ManageCreditSettlementViewModel> {
  ManageCreditSettlementPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 52.0.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0.h),
            child: Text(
              S.of(context).manageSettlement,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.t),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 24.0.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                    padding: EdgeInsetsDirectional.only(top: 42.0.h, bottom: 30.h) +
                        EdgeInsetsDirectional.symmetric(horizontal: 30.0.h),
                    child: Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Column(children: [
                            IgnorePointer(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, RoutePaths.ChangeCardPayment);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        S.of(context).changeCardPaymentAccount,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.t,
                                            color: Theme.of(context).inputDecorationTheme.hintStyle!.color ??
                                                AppColor.gray1),
                                      )),
                                      AppSvg.asset(AssetUtils.rightChevron,
                                          width: 20.w,
                                          height: 20.h,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge?.color)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AppDivider(),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutePaths.ChangeCardSettlementPercentage,
                                    arguments: ChangeCardSettlementPercentageArguments(
                                        creditCard: model.arguments!.creditCard));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      S.of(context).changeSettlementOptions,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.t),
                                    )),
                                    AppSvg.asset(AssetUtils.rightChevron,
                                        width: 20.w,
                                        height: 20.t,
                                        color: Theme.of(context).primaryTextTheme.bodyLarge?.color)
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48.h,
                      width: 48.h,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                          ]),
                      child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
