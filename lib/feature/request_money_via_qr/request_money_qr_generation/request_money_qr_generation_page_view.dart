import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/numeric_keyboard.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class RequestMoneyQrGenerationPageView
    extends BasePageViewWidget<RequestMoneyQrGenerationPageViewModel> {
  RequestMoneyQrGenerationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
          } else {
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 48),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16))),
                      ),
                      Positioned(
                          bottom: -8,
                          child: LottieBuilder.asset(
                            AssetUtils.swipeDownAnimation,
                            width: 28.0,
                            height: 28.0,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    S.of(context).backToPayments,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColor.dark_gray_1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    S.of(context).requestViaQR,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          model.currentPinValue,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              fontFamily: 'Montserrat',
                              color: AppColor.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 4),
                          child: Text(
                            "JOD",
                            style: TextStyle(
                                color: AppColor.verLightGray4,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        model.clearValue();
                      },
                      child: AppSvg.asset(AssetUtils.backspaceBlue),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    S.of(context).accountBalance,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColor.dark_gray_1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '12,451.91',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0, top: 2),
                        child: Text(
                          "JOD",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: AppColor.gray1),
                        ),
                      ),
                    ],
                  ),
                ),
                NumericKeyboard(
                    onKeyboardTap: (value) {
                      model.changeValue(value);
                    },
                    textColor: Colors.black,
                    rightButtonFn: () {
                      ///TODO:don't show account selection here
                      // AccountsDialog.show(context, onDismissed: () {
                      //   Navigator.pop(context);
                      // });
                      Navigator.pushReplacementNamed(
                          context, RoutePaths.QRScreen);
                    },
                    leftIcon: Icon(
                      Icons.circle,
                      color: AppColor.black,
                      size: 5,
                    ),
                    rightWidget: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColor.brightBlue,
                      child: Center(
                        child: AppSvg.asset(AssetUtils.next),
                      ),
                    ),
                    leftButtonFn: () {
                      model.changeValue(".");
                    },
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly),
              ],
            )
          ],
        ),
      ),
    );
  }
}
