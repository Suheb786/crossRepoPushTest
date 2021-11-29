import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/app_router.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends ConsumerWidget {
  late AppViewModel _appViewModel;

  @override
  Widget build(BuildContext context, watch) {
    return BaseWidget<AppViewModel>(
      providerBase: appViewModel,
      onModelReady: (model) {
        _appViewModel = watch(appViewModel);
      },
      builder: (context, appModel, child) {
        return ThemeProvider(
          initTheme: _appViewModel.themeData,
          builder: (_, theme) {
            return MaterialApp(
                navigatorKey: appLevelKey,
                builder: (context, widget) => ResponsiveWrapper.builder(
                      ClampingScrollWrapper.builder(context, widget!),
                      maxWidth: 1400,
                      minWidth: 360,
                      defaultScale: true,
                      breakpoints: [
                        ResponsiveBreakpoint.resize(360, name: MOBILE),
                        ResponsiveBreakpoint.autoScale(800, name: TABLET),
                        ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                        ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                        ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                      ],
                    ),
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: S.delegate.supportedLocales,
                onGenerateTitle: (context) => S.of(context).appName,
                debugShowCheckedModeBanner: false,
                // initialRoute: RoutePaths.Splash,
                home: AppHomePage(),
                theme: theme,
                onGenerateRoute: AppRouter.generateRoute);
          },
        );
      },
    );
  }
}
