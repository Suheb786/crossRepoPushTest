import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EvoucherLandingDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;

  EvoucherLandingDialogView({this.onDismissed, this.onSelected, this.isSwipeToCancel = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Dialog(
              insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36.h, top: 204),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: WillPopScope(
                onWillPop: () async => false,
                child: Container(
                    child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(AssetUtils.eVouchersLanding),
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
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
                        child: AppPrimaryButton(
                          onPressed: () {
                            onSelected!.call();
                          },
                          text: S.of(context).confirm,
                        ),
                      )
                    ],
                  ),
                )),
              )),
          Positioned(
            bottom: 76.h,
            child: InkWell(
              onTap: () {
                onDismissed?.call();
              },
              child: Container(
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary),
                  child: Image.asset(
                    AssetUtils.close_bold,
                    scale: 3.5,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
