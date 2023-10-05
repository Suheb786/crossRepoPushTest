import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ActiveCallPageView extends BasePageViewWidget<ActiveCallPageViewModel> {
  ActiveCallPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<InfobipCallStatusEnum>(
        stream: model.callStatusStream,
        initialData: InfobipCallStatusEnum.ON_RINGING,
        onData: (value) {
          if (value == InfobipCallStatusEnum.ON_HANGUP_NORMAL ||
              value == InfobipCallStatusEnum.ON_HANGUP_NETWORK_ERROR ||
              value == InfobipCallStatusEnum.ON_HANGUP_REQUEST_TIMEOUT) {
            Navigator.pushReplacementNamed(context, RoutePaths.CallEndedPage);
          }
        },
        dataBuilder: (context, data) => Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 272.0.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AssetUtils.line),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 144.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.vividYellow,
                            ),
                            child:
                                Center(child: AppSvg.asset(AssetUtils.helpAgent, height: 71, width: 57.28)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26.h),
                  AppStreamBuilder<String>(
                      stream: model.callDurationStream,
                      initialData: '00 : 00',
                      dataBuilder: (context, data) => Text(
                            data!,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 32.t),
                          )),
                  SizedBox(height: 206.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 56.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppStreamBuilder<Resource<bool>>(
                            stream: model.speakerResponseStream,
                            initialData: Resource.success(data: false),
                            dataBuilder: (context, data) => InkWell(
                                  onTap: () => model.toggleSpeaker(),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 72.0.h,
                                      width: 72.0.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white,
                                      ),
                                      child: Center(
                                          child: AppSvg.asset(
                                              data!.data! ? AssetUtils.speaker : AssetUtils.speakerOff,
                                              height: 30.32.h,
                                              width: 30.32.w)),
                                    ),
                                  ),
                                )),
                        AppStreamBuilder<Resource<bool>>(
                            stream: model.muteUnMuteResponseStream,
                            initialData: Resource.success(data: false),
                            dataBuilder: (context, data) => InkWell(
                                  onTap: () => model.toggleMute(),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 72.0.h,
                                      width: 72.0.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white,
                                      ),
                                      child: Center(
                                          child: AppSvg.asset(
                                              !data!.data! ? AssetUtils.micBlue : AssetUtils.muteMicBlue,
                                              height: 30.32.h,
                                              width: 30.32.w)),
                                    ),
                                  ),
                                )),
                        AppStreamBuilder<Resource<bool>>(
                            stream: model.hangupResponseStream,
                            initialData: Resource.none(),
                            onData: (value) {
                              print("HANGUP ::::: ${value.data}");
                              if (value.data!) {
                                Navigator.pushReplacementNamed(context, RoutePaths.CallEndedPage);
                              }
                            },
                            dataBuilder: (context, data) => InkWell(
                                  onTap: () {
                                    model.hangup();
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 72.0.h,
                                      width: 72.0.w,
                                      padding: EdgeInsets.symmetric(horizontal: 18.92.w, vertical: 18.92.h),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.dark_brown,
                                      ),
                                      child: Center(
                                          child: AppSvg.asset(AssetUtils.hangUp,
                                              height: 30.32.h, width: 30.32.w)),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
