import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ChangeCardSettlementPercentagePageView
    extends BasePageViewWidget<ChangeCardSettlementPercentagePageViewModel> {
  ChangeCardSettlementPercentagePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).changeLinkedAccount.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).selectNewPercentage,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: AppStreamBuilder<Resource<bool>>(
                  stream: model.updateSettlementStream,
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      Navigator.pushReplacementNamed(
                          context, RoutePaths.CreditCardApplySuccess,
                          arguments: CreditCardApplySuccessArguments(
                              creditSuccessState: CreditSuccessState
                                  .Settlement_Percentage_Changed));
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  initialData: Resource.none(),
                  dataBuilder: (context, snapshot) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              model.updateSettlement();
                            } else {}
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    child: Text(
                                      S.of(context).currentSettlementPercentage,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: AppDivider(
                                      color: AppColor.lightGrayishBlue,
                                      indent: 12,
                                      endIndent: 8,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              shape: BoxShape.circle),
                                          child: AppSvg.asset(
                                            AssetUtils.percentage,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          model.arguments?.creditCard
                                                      .minimumSettlement !=
                                                  null
                                              ? model.arguments!.creditCard
                                                      .minimumSettlement
                                                      .toString() +
                                                  "%"
                                              : "",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: AppDivider(
                                      color: AppColor.lightGrayishBlue,
                                      indent: 12,
                                      endIndent: 8,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: AppTextField(
                                      labelText: S
                                          .of(context)
                                          .newSettlementPercentage
                                          .toUpperCase(),
                                      hintText: S.of(context).pleaseSelect,
                                      readOnly: true,
                                      controller:
                                          model.settlementPercentageController,
                                      key: model.settlementPercentageKey,
                                      onPressed: () {
                                        RelationshipWithCardHolderDialog.show(
                                            context,
                                            title: S
                                                .of(context)
                                                .settlementPercentage,
                                            relationSHipWithCardHolder:
                                                model.percentageList,
                                            onSelected: (value) {
                                          Navigator.pop(context);
                                          model.settlementPercentageController
                                              .text = value;
                                          model.validate();
                                        }, onDismissed: () {
                                          Navigator.pop(context);
                                        });
                                      },
                                      suffixIcon: (value, data) {
                                        return Container(
                                            height: 16,
                                            width: 16,
                                            padding: EdgeInsets.only(right: 8),
                                            child: AppSvg.asset(
                                                AssetUtils.downArrow,
                                                color: AppColor.dark_gray_1));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.showButtonStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return Visibility(
                                            visible: isValid!,
                                            child: AnimatedButton(
                                              buttonText:
                                                  S.of(context).swipeToProceed,
                                            ),
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
                                          color: AppColor.brightBlue,
                                          letterSpacing: 1,
                                          fontSize: 14,
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
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
