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
    switch (_appTheme) {
      case AppTheme.dark:
        _themeData = _themeData.copyWith(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColor.black,
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
              bodyColor: AppColor.brightBlue,
              displayColor: AppColor.brightBlue),
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
      case AppTheme.light:
        _themeData = _themeData.copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.white,
          primaryColor: AppColor.brightRed,
          primaryColorDark: AppColor.black,
          primaryColorLight: AppColor.verySoftRed,
          accentColor: AppColor.white,
          backgroundColor: AppColor.lightGray,
          cardTheme: CardTheme(
              color: AppColor.veryLightGray,
              shadowColor: AppColor.black.withOpacity(0.24),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColor.dark_moderate_blue)),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.veryDarkGray2,
            selectionHandleColor: AppColor.veryDarkGray2,
            selectionColor: AppColor.veryDarkGray2,
          ),
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                fontFamily: "Montserrat",
                color: AppColor.gray1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              //contentPadding: EdgeInsets.zero,
              filled: false,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.000001,
                      color: AppColor.gray1,
                      style: BorderStyle.none)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.000001,
                      color: AppColor.veryDarkGray1,
                      style: BorderStyle.none)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.000001,
                      color: AppColor.strongRed,
                      style: BorderStyle.none)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.000001,
                      color: AppColor.gray1,
                      style: BorderStyle.none)),
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
                color: AppColor.veryDarkGray2,
                fontSize: 18,
                height: 1.48,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              )),
          textTheme: _themeData.textTheme.apply(
              fontFamily: "Montserrat",
              bodyColor: AppColor.veryDarkGray2,
              displayColor: AppColor.veryDarkGray2),
          accentTextTheme: _themeData.textTheme.apply(
              fontFamily: "Montserrat",
              bodyColor: AppColor.brightBlue,
              displayColor: AppColor.brightBlue),
          primaryTextTheme: _themeData.textTheme.apply(
              fontFamily: "Montserrat",
              bodyColor: AppColor.very_dark_gray_black,
              displayColor: AppColor.white),
          iconTheme: IconThemeData(
            color: AppColor.white,
          ),
          indicatorColor: AppColor.veryDarkGray2,
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

  ThemeData toggleTheme() {
    if (appTheme == AppTheme.dark) {
      _appTheme = AppTheme.light;
    } else {
      _appTheme = AppTheme.dark;
    }
    return themeData;
  }
}

enum AppTheme {
  dark,
  light,
}
