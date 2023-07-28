import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EvoucherLandingDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;

  EvoucherLandingDialogView({this.onDismissed, this.onSelected, this.isSwipeToCancel = true});

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
                  carouselWidget(context),
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Text(
                      S.of(context).eVouchersAreHere,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontFamily: StringUtils.appFont,
                          fontSize: 20.t,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Text(
                      S.of(context).eVoucherLandingDialogDescption,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.shadow,
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.t,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      onSelected!.call();
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.all(16),
                      height: 57.w,
                      width: 57.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge!.color!),
                      child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 16.h),
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
                                fontSize: 10.t,
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

  int selectedIndex = 0;

  Widget carouselWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      padding: EdgeInsets.symmetric(vertical: 32.0.h),
      child: Gallery3D(
          controller: Gallery3DController(itemCount: 4, ellipseHeight: 0, autoLoop: false, minScale: 0.6),
          width: MediaQuery.of(context).size.width - 48,
          height: 108.h,
          onItemChanged: (index) {
            selectedIndex = index;
          },
          itemConfig: GalleryItemConfig(radius: 16, isShowTransformMask: false, width: 165.w, height: 108.w),
          onClickItem: (index) => {},
          itemBuilder: (context, index) {
            return getChild(index);
          }),
    );
  }

  Widget getChild(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: selectedIndex == index ? 12 : 0,
      shadowColor: AppColor.black.withOpacity(0.9),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: index == 0
                ? Colors.yellow.withOpacity(0.3)
                : index == 1
                    ? Colors.red
                    : index == 2
                        ? Colors.white
                        : Colors.black,
          ),
          color: index == 0
              ? Colors.yellow
              : index == 1
                  ? Colors.red
                  : index == 2
                      ? Colors.white
                      : Colors.black,
        ),
        width: 165.w,
        height: 108.h,
        alignment: Alignment.center,
        ///TODO: set image
        child: Text("$index"),
      ),
    );
  }
}
