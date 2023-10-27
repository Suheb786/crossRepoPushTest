import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class DormantAccountDebitCardDisabledWidget extends StatefulWidget {
  int myIndex;

  DormantAccountDebitCardDisabledWidget({required this.myIndex});

  @override
  _DormantAccountDebitCardDisabledWidgetState createState() => _DormantAccountDebitCardDisabledWidgetState();
}

class _DormantAccountDebitCardDisabledWidgetState extends State<DormantAccountDebitCardDisabledWidget> {
  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
        initialData: 0,
        dataBuilder: (context, myyCurrentStep) {
          return AnimatedOpacity(
            opacity: myyCurrentStep == widget.myIndex ? 1 : 0.5,
            duration: const Duration(milliseconds: 400),
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme.of(context).canvasColor,
                  margin: EdgeInsetsDirectional.zero,
                  shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 27.0.w,
                      top: 30.0.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).myDebitCard,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 12.0.t,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 10.0.h),
                          child: AppSvg.asset(AssetUtils.blinkBlack),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 24.0.h),
                          child: Text(
                            S.of(context).yourAccountInactive,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.0.t,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 4.0.h, end: 24.w),
                          child: Text(
                            S.of(context).callToActivate,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 12.0.t,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).textTheme.labelSmall?.color),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 30.0.h,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: AppSvg.asset(AssetUtils.zigzagCircle,
                                height: 156.0.h, matchTextDirection: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
