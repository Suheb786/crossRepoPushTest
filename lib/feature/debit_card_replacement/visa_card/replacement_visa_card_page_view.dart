import 'dart:ui';

import 'package:domain/model/card/card_issuance_details.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/visa_card/replacement_visa_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/apply_debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';

class ReplacementVisaCardPageView extends BasePageViewWidget<ReplacementVisaCardPageViewModel> {
  ReplacementVisaCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<CardIssuanceDetails>>(
        stream: model.cardIssuanceStream,
        initialData: Resource.none(),
        dataBuilder: (context, data) {
          return Card(
            margin: EdgeInsets.zero,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FlipCard(
                        controller: model.cardController,
                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL,
                        front: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(16.w),
                                child: AppSvg.asset(AssetUtils.replacementVisaCard)),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.w),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                  onTap: () {
                                    model.cardController.toggleCard();
                                  },
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                    child: Container(
                                      height: 60.w,
                                      width: 60.w,
                                      child: AppSvg.asset(AssetUtils.flipButton),
                                    ),
                                  )),
                            )
                          ],
                        ),
                        back: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: AppColor.vividYellow,
                                  borderRadius: BorderRadius.circular(16.w),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 18.52.h, bottom: 52.h),
                                      child: Container(
                                        height: 42.h,
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.only(end: 8.0.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data!.data?.cardHolderName ?? "-",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 12.t,
                                                        color: Theme.of(context).primaryColorDark),
                                                  ),
                                                  Text(
                                                    (data.data?.cardNumber != null &&
                                                            data.data!.cardNumber.isNotEmpty)
                                                        ? StringUtils.getLastFourDigitOfCardNo(
                                                            data.data!.cardNumber)
                                                        : "XXXX",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 10.t,
                                                        color: Theme.of(context).primaryColorDark),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Image.asset(AssetUtils.birdPng)
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 5.0.t, bottom: 15.2.h, end: 20.w),
                                        child: Text(
                                          'Debit',
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10.t,
                                              color: Theme.of(context).primaryColorDark),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            InkWell(
                                onTap: () {
                                  model.cardController.toggleCard();
                                },
                                child: AppSvg.asset(AssetUtils.flipButton, width: 50.w, height: 50.w))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 16.0.h,bottom: 20.0.h),
                          child: AppPrimaryButton(
                            text: S.of(context).next,
                            onPressed: () {
                              ProviderScope.containerOf(context).read(debitCardReplacementViewModelProvider).nextPage();
                            },
                          )),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (ProviderScope.containerOf(context)
                              .read(debitCardReplacementViewModelProvider)
                              .debitCardReplacementArguments
                              .debitRoutes ==
                              DebitRoutes.DASHBOARD) {
                            Navigator.pop(context);
                          } else {
                            Navigator.of(context)
                              ..pop
                              ..pop();
                          }

                          ProviderScope.containerOf(context)
                              .read(appHomeViewModelProvider)
                              .getDashboardData();
                        },
                        child: Text(
                          S.of(context).backToDashboard,
                          style: TextStyle(
                            color: AppColor.brightBlue,
                            fontSize: 14.t,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
