import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class ApplyCreditCardWidget extends StatelessWidget {
  final bool isSmallDevices;
  final int myIndex;

  const ApplyCreditCardWidget({Key? key, this.isSmallDevices = false, required this.myIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
        initialData: 0,
        dataBuilder: (context, myyCurrentStep) {
          return AnimatedOpacity(
            opacity: myyCurrentStep == myIndex ? 1 : 0.5,
            duration: const Duration(milliseconds: 400),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetUtils.zigzagBackground),
                        fit: BoxFit.cover,
                        scale: isSmallDevices ? 1.3 : 1,
                        matchTextDirection: true)),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    PositionedDirectional(
                      child: topWidget(context),
                      top: 0,
                      start: 0,
                    ),
                    PositionedDirectional(
                      child: bottomWidget(context),
                      bottom: 0,
                      end: 0,
                      start: 0,
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSvg.asset(AssetUtils.cardCircle, height: 96.0.h),
                          Padding(
                              padding: EdgeInsetsDirectional.only(top: 12.0.h, start: 10.0.w, end: 10.0.w),
                              child: Text(
                                S.of(context).blinkCreditCard,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.0.t,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.secondary),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  topWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 23.0.h, end: 23.0.w, start: 23.0.w),
      child: AppSvg.asset(AssetUtils.blink_updated_logo, height: 33.64.h, width: 72.0.w),
    );
  }

  bottomWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w, bottom: 32.h),
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.BlinkCreditCard);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
            decoration: BoxDecoration(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                S.of(context).applyNow,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.0.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
