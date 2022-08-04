import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardDeliveredPageView extends BasePageViewWidget<CreditCardDeliveredViewModel> {
  CreditCardDeliveredPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 40, end: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                    onTap: () {
                      ProviderScope.containerOf(context)
                          .read(homeViewModelProvider)
                          .homeController
                          .jumpToPage(2);
                    },
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AppSvg.asset(AssetUtils.close)))),
            Stack(
              children: [
                AppStreamBuilder<Resource<bool>>(
                    stream: model.confirmCreditCardDeliveryStream,
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CreditCardVerificationSuccessPage()));
                      }
                    },
                    initialData: Resource.none(),
                    dataBuilder: (context, cardDeliveryResponse) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(top: 106.0, start: 24),
                        child: GestureDetector(
                          onHorizontalDragEnd: (details) {
                            model.confirmCreditCardDelivery(
                                cardId: model.creditCard.cardId ?? '',
                                cardDigit: model.creditCard.cardNumber!.isNotEmpty
                                    ? StringUtils.getLastFourDigitOfCardNo(model.creditCard.cardNumber!)
                                    : '');
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 2,
                            color: Theme.of(context).accentColor,
                            margin: EdgeInsets.zero,
                            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(top: 226),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        S.of(context).numberOnCard,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.gray4),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(top: 9),
                                      child: Text(
                                        model.creditCard.cardNumber!.isNotEmpty
                                            ? StringUtils.getLastFourDigitOfCardNo(
                                                model.creditCard.cardNumber)
                                            : '-',
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(top: 32, start: 30, end: 24),
                                      child: Text(
                                        S.of(context).cardHasBeenDelivered,
                                        textAlign: TextAlign.center,
                                        maxLines: 4,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.gray4),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(top: 75, bottom: 31),
                                      child: AnimatedButton(
                                          buttonText: S.of(context).swipeToConfirm,
                                          borderColor: Theme.of(context).accentTextTheme.bodyText1!.color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                PositionedDirectional(
                    start: 40,
                    end: 16,
                    top: 72,
                    child: Stack(
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                              height: 186,
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(top: 116, start: 20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        AssetUtils.creditCard,
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10.43)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.creditCard.cardNumber!.isNotEmpty
                                        ? model.creditCard.accountTitle ?? '-'
                                        : '-',
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.only(top: 10),
                                      child: Text(
                                          model.creditCard.cardNumber!.isNotEmpty
                                              ? StringUtils.getLastFourDigitOfCardNo(
                                                  model.creditCard.cardNumber!)
                                              : '-',
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700)))
                                ],
                              )),
                        ),
                        Positioned(
                            left: 7,
                            bottom: 19,
                            child: Container(
                              height: 47,
                              width: 47,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).canvasColor.withOpacity(0.45)),
                            ))
                      ],
                    ))
              ],
            ),
            Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 36),
                child: Text(
                  S.of(context).deliveryIssue,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).accentTextTheme.bodyText1!.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
