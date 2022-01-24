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

class CreditCardDeliveredPageView
    extends BasePageViewWidget<CreditCardDeliveredViewModel> {
  CreditCardDeliveredPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 40, right: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreditCardVerificationSuccessPage()));
                      }
                    },
                    initialData: Resource.none(),
                    dataBuilder: (context, cardDeliveryResponse) {
                      return Padding(
                        padding: EdgeInsets.only(top: 106.0, left: 24),
                        child: GestureDetector(
                          onHorizontalDragEnd: (details) {
                            model.confirmCreditCardDelivery(
                              cardId: model.creditCard.first.cardId!,
                              cardDigit: model.creditCard.first.creditLimit!
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 2,
                            color: Theme.of(context).accentColor,
                            margin: EdgeInsets.zero,
                            shadowColor: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.32),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 226),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        S.of(context).numberOnCard,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.gray4),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 9),
                                      child: Text(
                                        model.creditCard.isNotEmpty
                                            ? model.creditCard[0].cardNumber ??
                                                '-'
                                            : '-',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 78, left: 30, right: 24),
                                      child: Text(
                                        S.of(context).cardHasBeenDelivered,
                                        maxLines: 4,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.gray4),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 75, bottom: 31),
                                      child: AnimatedButton(
                                          buttonText:
                                              S.of(context).swipeToConfirm,
                                          borderColor: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                Positioned(
                    left: 40,
                    right: 16,
                    top: 72,
                    child: Stack(
                      children: [
                        Container(
                            height: 186,
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 111, left: 20),
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
                                  model.creditCard.isNotEmpty
                                      ? model.creditCard[0].name ?? '-'
                                      : '-',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                        model.creditCard.isNotEmpty
                                            ? model.creditCard[0].cardNumber ??
                                                '-'
                                            : '-',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700)))
                              ],
                            )),
                        Positioned(
                            left: 7,
                            bottom: 19,
                            child: Image.asset(AssetUtils.ellipseYellow))
                      ],
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 36),
              child: Text(
                S.of(context).deliveryIssue,
                style: TextStyle(
                    color: Theme.of(context).accentTextTheme.bodyText1!.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
