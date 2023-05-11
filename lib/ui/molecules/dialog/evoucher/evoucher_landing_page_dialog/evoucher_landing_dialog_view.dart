import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EvoucherLandingDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;

  const EvoucherLandingDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel: true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                onDismissed?.call();
              }
            },
            child: Container(
                child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  image != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 166,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            color: AppColor.light_acccent_blue,
                          ),
                          child: carouselWidget())
                      : Container(),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 31),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: descriptionWidget,
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      onSelected!.call();
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.all(16),
                      height: 57,
                      width: 57,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyMedium!.color!),
                      child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 16),
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
                                fontFamily: StringUtils.appFont,
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

  Widget carouselWidget() {
    return CarouselSlider.builder(
        itemCount: 2,
        itemBuilder: (context, index, realIndex) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), border: Border.all(width: 2, color: Colors.yellow)),
            width: 158,
            height: 102,
          );
        },
        options: CarouselOptions(
            enlargeCenterPage: true,
            height: 102,
            autoPlay: false,
            viewportFraction: 0.4,
            pageSnapping: false,
            enlargeStrategy: CenterPageEnlargeStrategy.height));
  }

  Widget slidingBanner() {
    return Builder(builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        color: AppColor.light_acccent_blue,
        child: ListView(
          children: [
            CarouselSlider(
              items: [
                //1st Image of Slider
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image.asset(
                    AssetUtils.apple_music,
                    width: 170,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),

                //2nd Image of Slider
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image.asset(
                    AssetUtils.apple_music,
                    width: 158,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                ),

                //3rd Image of Slider
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image.asset(
                    AssetUtils.apple_music,
                    width: 158,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                ),

                //4th Image of Slider
              ],

              //Slider Container properties
              options: CarouselOptions(
                  height: 166,
                  enlargeCenterPage: true,
                  viewportFraction: 0.4,
                  autoPlay: false,
                  pageSnapping: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
            ),
          ],
        ),
      );
    });
  }
}
