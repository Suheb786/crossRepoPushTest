import 'dart:ui';

import 'package:domain/model/card/card_issuance_details.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class VisaCardPageView extends BasePageViewWidget<VisaCardPageViewModel> {
  VisaCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    listenPopUp(model, context);
    return AppStreamBuilder<Resource<CardIssuanceDetails>>(
      stream: model.cardIssuanceStream,
      initialData: Resource.none(),
      onData: (data) {
        if (data.status == Status.SUCCESS) {
          ProviderScope.containerOf(context)
              .read(cardDeliveryViewModelProvider)
              .cardNumber = data.data!.cardNumber;
        }
      },
      dataBuilder: (context, data) {
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (ProviderScope.containerOf(context)
                    .read(cardDeliveryViewModelProvider)
                    .appSwiperController
                    .page ==
                0.0) {
              if (data!.status == Status.SUCCESS) {
                ProviderScope.containerOf(context)
                    .read(cardDeliveryViewModelProvider)
                    .nextPage();
                // .next(animation: true);
              }
            }
          },
          child: Card(
            margin: EdgeInsets.zero,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                borderRadius: BorderRadius.circular(16),
                                child: AppSvg.asset(AssetUtils.visaCard)),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                  onTap: () {
                                    model.cardController.toggleCard();
                                  },
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaY: 15, sigmaX: 15),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child:
                                          AppSvg.asset(AssetUtils.flipButton),
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
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.52, bottom: 52),
                                      child: Container(
                                        height: 42,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data!.data
                                                            ?.cardHolderName ??
                                                        "-",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                                  ),
                                                  Text(
                                                    (data.data?.cardNumber !=
                                                                null &&
                                                            data
                                                                .data!
                                                                .cardNumber
                                                                .isNotEmpty)
                                                        ? StringUtils
                                                            .getLastFourDigitOfCardNo(
                                                                data.data!
                                                                    .cardNumber)
                                                        : "XXXX",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 10,
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
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
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 15.2, right: 20),
                                        child: Text(
                                          'Debit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            InkWell(
                                onTap: () {
                                  model.cardController.toggleCard();
                                },
                                child: AppSvg.asset(AssetUtils.flipButton,
                                    width: 50, height: 50))
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: AnimatedButton(
                          buttonHeight: 50,
                          buttonText: S.of(context).swipeToProceed,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  void listenPopUp(VisaCardPageViewModel model, BuildContext context) {
    model.cardDeliveryPopUpDataStream.listen((data) {
      if (data) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => popUpWidget(context, AssetUtils.anghamiPlus));
      }
    });
  }

  Widget popUpWidget(BuildContext context, String image) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              height: 530,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColor.brightBlue,
                  )),
            )
          ],
        ));
  }
}
