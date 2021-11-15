import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/feature/splash/splash_page_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class SplashPageView extends BasePageViewWidget<SplashViewModel> {
  SplashPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<double>(
      stream: model.splashProgressStream,
      initialData: 0,
      onData: (data) {
        if (data == 1) {
          Navigator.pushReplacementNamed(context, RoutePaths.OnBoarding);
        }
      },
      dataBuilder: (context, data) {
        return ThemeSwitcher(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                ProviderScope.containerOf(context)
                    .read(appViewModel)
                    .toggleTheme();

                ThemeSwitcher.of(context)!.changeTheme(
                    theme: ProviderScope.containerOf(context)
                        .read(appViewModel)
                        .themeData);
              },
              child: Center(
                child: Container(
                  width: 104,
                  height: 104,
                  alignment: Alignment.center,
                  child: Image.asset(AssetUtils.splashLogo),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
