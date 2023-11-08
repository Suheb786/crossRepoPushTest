import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/device_size_helper.dart';

class RjCardWidget extends StatelessWidget {
  final int myIndex;

  const RjCardWidget({Key? key, required this.myIndex}) : super(key: key);

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
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              blurRadius: 15.0,
                              offset: Offset(0.0, 0.75))
                        ],
                      ),
                      padding: EdgeInsets.only(top: 12.h),
                      alignment: Alignment.center,
                      child: AppSvg.asset(
                        AssetUtils.GoRj,
                        height: 60.h,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 20,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.bottomCenter,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      child: AppSvg.asset(
                        AssetUtils.WalkingLady,
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Container(
                      color: AppColor.softRed1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppSvg.asset(AssetUtils.BestDealsWithBlink,
                                    width: DeviceSizeHelper.isSmallDevice ? 100 : 115),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsetsDirectional.only(end: 4.0),
                            child: Image.asset(
                              AssetUtils.AirplaneTail,
                              height: 118.h,
                              width: 123.w,
                              alignment: Alignment.bottomRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
