import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/splash/splash_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SplashPageView extends BasePageViewWidget<SplashViewModel> {
  SplashPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<bool>>(
      stream: model.isDeviceCompatible,
      initialData: Resource.none(),
      onData: (data) {
        if (data.status == Status.SUCCESS) {
          Navigator.pushReplacementNamed(context, RoutePaths.OnBoarding);
        } else if (data.status == Status.ERROR) {
          InformationDialog.show(context,
              image: AssetUtils.mobile,
              title: S.of(context).deviceNotSupported,
              descriptionWidget: Text(
                S.of(context).deviceNotSupportedNote,
                style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.0.t, height: 1.7),
              ), onDismissed: () {
            exit(0);
          }, onSelected: () {
            exit(0);
          });
        }
      },
      dataBuilder: (context, data) {
        return AppStreamBuilder<double>(
          stream: model.splashProgressStream,
          initialData: 0,
          onData: (data) {
            if (data == 1) {
              //model.checkDeviceCompatibility();
              Navigator.pushReplacementNamed(context, RoutePaths.OnBoarding);
              // Navigator.pushReplacementNamed(context, RoutePaths.LauncherPage);
            }
          },
          dataBuilder: (context, data) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  Expanded(
                    child: Lottie.asset(AssetUtils.splashAnimation,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        controller: model.animationController,
                        alignment: Alignment.center, onLoaded: (composition) {
                      model.startTimer(composition.duration);
                      model.animationController!
                        ..duration = composition.duration
                        ..forward();
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0.h, bottom: 20.0.h),
                    child: AppStreamBuilder<String>(
                      initialData: '',
                      stream: model.appVersionStream,
                      dataBuilder: (context, version) {
                        return Text(
                          version!,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.0.t,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
