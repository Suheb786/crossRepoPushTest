import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PurchaseNowDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final String subTitle;
  final String price;
  final Widget descriptionWidget;

  const PurchaseNowDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.price,
      required this.descriptionWidget,
      this.isSwipeToCancel: true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding:
            EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                onDismissed?.call();
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      image != null
                          ? AppSvg.asset(image!, height: 50, width: 50)
                          : Container(),
                      SizedBox(height: 25),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 2),
                      Text(
                        subTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.gray_black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            price,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.brightBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              S.of(context).JOD,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.verLightGray4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      descriptionWidget,
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          onSelected!.call();
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 57,
                          width: 57,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .accentTextTheme
                                  .bodyText1!
                                  .color!),
                          child: AppSvg.asset(AssetUtils.tick,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: Visibility(
                          visible: isSwipeToCancel ?? true,
                          child: InkWell(
                            onTap: () {
                              onDismissed!.call();
                            },
                            child: Center(
                              child: Text(
                                S.of(context).swipeDownToCancel,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.dark_gray_1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
