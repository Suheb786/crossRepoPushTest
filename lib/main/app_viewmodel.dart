import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

GlobalKey<NavigatorState> appLevelKey = GlobalKey(debugLabel: 'app-key');

class AppViewModel extends BaseViewModel {
  ThemeData _themeData = ThemeData();
  AppTheme _appTheme = AppTheme.light;

  AppTheme get appTheme => _appTheme;

  ThemeData get themeData {
    // based on platform WidgetsBinding.instance.window.platformBrightness
    switch (_appTheme) {
      case AppTheme.dark:
      case AppTheme.light:
        _themeData = _themeData.copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.very_light_grey,
          accentColor: AppColor.white,
          primaryColor: AppColor.white,
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColor.dark_moderate_blue)),
          primaryColorDark: AppColor.dark_moderate_blue,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.very_light_grey,
            selectionHandleColor: AppColor.very_light_grey,
            selectionColor: AppColor.very_light_grey,
          ),
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                fontFamily: "Montserrat",
                color: AppColor.white.withOpacity(0.3),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              //contentPadding: EdgeInsets.zero,
              filled: false,
              border: InputBorder.none,
              isCollapsed: true,
              errorStyle: TextStyle(
                fontFamily: "Montserrat",
                color: AppColor.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              labelStyle: TextStyle(
                fontFamily: "Montserrat",
                color: AppColor.black,
                fontSize: 18,
                height: 1.48,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              )),
          textTheme: _themeData.textTheme.apply(
              fontFamily: "Montserrat",
              bodyColor: AppColor.black,
              displayColor: AppColor.black),
          accentTextTheme: _themeData.textTheme.apply(
              fontFamily: "Montserrat",
              bodyColor: AppColor.white,
              displayColor: AppColor.white),
          primaryTextTheme: _themeData.textTheme.apply(
              fontFamily: "Montserrat",
              bodyColor: AppColor.white,
              displayColor: AppColor.white),
          iconTheme: IconThemeData(
            color: AppColor.white,
          ),
          indicatorColor: AppColor.white,
          buttonTheme: ButtonThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            textTheme: ButtonTextTheme.normal,
          ),
        );
        break;
    }

    return _themeData;
  }
}

enum AppTheme {
  dark,
  light,
}
