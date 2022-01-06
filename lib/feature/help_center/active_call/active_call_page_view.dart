import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/help_center/help_center_modules.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class ActiveCallPageView extends BasePageViewWidget<ActiveCallPageViewModel> {
  ActiveCallPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder(
        stream: ProviderScope.containerOf(context)
            .read(helpCenterViewModelProvider)
            .callStatusStream,
        initialData: InfobipCallStatusEnum.ON_RINGING,
        onData: (value) {
          if (value == InfobipCallStatusEnum.ON_HANGUP) {
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
                    padding: EdgeInsets.only(top: 272),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AssetUtils.line),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 144.37,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.vividYellow,
                            ),
                            child: Center(
                                child: AppSvg.asset(AssetUtils.helpAgent,
                                    height: 71, width: 57.28)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26),
                  AppStreamBuilder<String>(
                      stream: model.callDurationStream,
                      initialData: '00 : 00',
                      dataBuilder: (context, data) => Text(
                            data!,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 32),
                          )),
                  SizedBox(height: 206),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 56.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppStreamBuilder<Resource<bool>>(
                            stream: model.speakerResponseStream,
                            initialData: Resource.none(),
                            dataBuilder: (context, data) => InkWell(
                                  onTap: () => model.toggleSpeaker(),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 72.0,
                                      width: 72.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white,
                                      ),
                                      child: Center(
                                          child: AppSvg.asset(
                                              data!.data!
                                                  ? AssetUtils.speaker
                                                  : AssetUtils.speakerOff,
                                              height: 30.32,
                                              width: 30.32)),
                                    ),
                                  ),
                                )),
                        AppStreamBuilder<Resource<bool>>(
                            stream: model.muteUnMuteResponseStream,
                            initialData: Resource.none(),
                            dataBuilder: (context, data) => InkWell(
                                  onTap: () => model.toggleMute(),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 72.0,
                                      width: 72.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white,
                                      ),
                                      child: Center(
                                          child: AppSvg.asset(
                                              data!.data!
                                                  ? AssetUtils.micBlue
                                                  : AssetUtils.muteMicBlue,
                                              height: 30.32,
                                              width: 30.32)),
                                    ),
                                  ),
                                )),
                        AppStreamBuilder<Resource<bool>>(
                            stream: model.hangupResponseStream,
                            initialData: Resource.none(),
                            onData: (value) {
                              print("HANGUP ::::: ${value.data}");
                              if (value.data!) {
                                Navigator.pushReplacementNamed(
                                    context, RoutePaths.CallEndedPage);
                              }
                            },
                            dataBuilder: (context, data) => InkWell(
                                  onTap: () {
                                    model.hangup();
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 72.0,
                                      width: 72.0,
                                      padding: EdgeInsets.all(18.92),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.dark_brown,
                                      ),
                                      child: Center(
                                          child: AppSvg.asset(AssetUtils.hangUp,
                                              height: 30.32, width: 30.32)),
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
