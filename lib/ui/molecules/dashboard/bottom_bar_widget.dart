import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dashboard/bottom_bar_widget_item.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class BottomBarWidget extends StatelessWidget {
  final Function() onHomeTap;
  final Function() onMoreTap;
  final Function() onContactUsTap;

  const BottomBarWidget({Key? key, required this.onHomeTap, required this.onMoreTap, required this.onContactUsTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
          border: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.background, width: 1),
            left: BorderSide(color: Theme.of(context).colorScheme.background, width: 1),
            right: BorderSide(color: Theme.of(context).colorScheme.background, width: 1),
            bottom: BorderSide(color: Theme.of(context).colorScheme.background, width: 1),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          BottomBarWidgetItem(
            onTap: () {
              onHomeTap.call();
            },
            image: AssetUtils.homeOutlineButton,
            label: S.of(context).home,
          ),
          SizedBox(
            width: 40.w,
          ),
          // Spacer(),
          BottomBarWidgetItem(
            onTap: () {
              onMoreTap.call();
            },
            image: AssetUtils.blinkLogo1,
            label: S.of(context).more,
          ),
          SizedBox(
            width: 40.w,
          ),
          // Spacer(),
          BottomBarWidgetItem(
            onTap: () {
              onContactUsTap.call();
            },
            image: AssetUtils.contactUs,
            label: S.of(context).contactUs,
          ),
        ],
      ),
    );
  }
}
