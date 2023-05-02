import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/app_router.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class App extends ConsumerWidget {
  late AppViewModel _appViewModel;

  @override
  Widget build(BuildContext context, ref) {
    return BaseWidget<AppViewModel>(
      providerBase: appViewModel,
      onModelReady: (model) {
        _appViewModel = ref.watch(appViewModel);
        // model.initAppFlyerSDKStream.listen((event) {
        //   if (event.status == Status.SUCCESS) {
        //     debugPrint('-----SDK INITIALIZED------');
        //     model.logAppFlyerSDKEvents(eventName: 'APP_LAUNCH', eventValue: {"app_laumched": "APP LAUNCHED"});
        //   } else if (event.status == Status.ERROR) {
        //     debugPrint('-----SDK INITIALIZED FAILED------');
        //   }
        // });
      },
      builder: (context, appModel, child) {
        return ThemeProvider(
          initTheme: _appViewModel.themeData,
          builder: (_, theme) {
            return LayoutBuilder(builder: (context, constraints) {
              SizeHelperUtil.setWidthHeight(constraints);
              return MaterialApp(
                  navigatorKey: appLevelKey,
                  // builder: (context, widget) => ResponsiveWrapper.builder(
                  //       ClampingScrollWrapper.builder(context, widget!),
                  //       maxWidth: 1400,
                  //       minWidth: 320,
                  //       defaultScale: true,
                  //       breakpoints: [
                  //         ResponsiveBreakpoint.resize(320, name: MOBILE),
                  //         ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  //         ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  //         ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  //         ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                  //       ],
                  //     ),
                  builder: DevicePreview.appBuilder,
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  onGenerateTitle: (context) => S.of(context).appName,
                  debugShowCheckedModeBanner: false,
                  locale: _appViewModel.currentLocale,
                  initialRoute: RoutePaths.Splash,
                  theme: theme,
                  onGenerateRoute: AppRouter.generateRoute);
            });
          },
        );
      },
    );
  }
}
