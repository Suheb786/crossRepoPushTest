import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:data/di/local_module.dart';
import 'package:data/helper/antelop_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/constants/app_constants_domain.dart';
import 'package:domain/constants/enum/language_enum.dart';
import 'package:domain/usecase/app_flyer/init_app_flyer_sdk.dart';
import 'package:domain/usecase/app_flyer/log_app_flyers_events.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:domain/usecase/user/local_session_usecase.dart';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../ui/molecules/app_progress.dart';
import '../ui/molecules/dialog/session_timeout/session_timeout_dailog.dart';
import 'navigation/route_paths.dart';

GlobalKey<NavigatorState> appLevelKey = GlobalKey(debugLabel: 'app-key');

class AppViewModel extends BaseViewModel {
  ThemeData _themeData = ThemeData();
  AppTheme _appTheme = AppTheme.light;

  AppTheme get appTheme => _appTheme;

  Locale _currentLocale = Locale('en');

  LanguageEnum selectedLanguageEnum = LanguageEnum.ENGLISH;

  Locale get currentLocale => _currentLocale;

  void toggleLocale(LanguageEnum locale) {
    selectedLanguageEnum = locale;
    _currentLocale = Locale(locale.toString());
    AppConstantsDomain.SELECTED_LANGUAGE = locale.toString().toUpperCase();
    notifyListeners();
  }

  ThemeData get themeData {
    switch (_appTheme) {
      case AppTheme.dark:
      case AppTheme.light:
        _themeData = ThemeData.light().copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.white,
          primaryColor: AppColor.brightRed,
          primaryColorDark: AppColor.black,
          primaryColorLight: AppColor.verySoftRed,
          dialogBackgroundColor: AppColor.white,
          colorScheme: _themeData.colorScheme.copyWith(
              secondary: AppColor.white,
              onSecondary: AppColor.light_gray_4,
              onSecondaryContainer: AppColor.brightBlue,
              background: AppColor.lightGray,
              error: AppColor.vivid_red,
              secondaryContainer: AppColor.darkModerateLimeGreen,
              onTertiaryContainer: AppColor.dark_orange,
              onSurface: AppColor.rj_gray,
              surfaceVariant: AppColor.veryDarkGray2,
              surface: AppColor.veryDarkGray1,
              surfaceTint: AppColor.dark_gray_1,
              onInverseSurface: AppColor.gray1,
              inverseSurface: AppColor.white_gray,
              shadow: AppColor.gray_black,
              onBackground: AppColor.whiteGrey,
              inversePrimary: AppColor.gray5,
              tertiary: AppColor.dark_violet_4,
              tertiaryContainer: AppColor.dark_Grayish_Blue,
              onTertiary: AppColor.light_grayish_violet,
              scrim: AppColor.dark_brown,
              onPrimaryContainer: AppColor.cerulean_Blue,
              outlineVariant: AppColor.azure_blue),
          // backgroundColor: AppColor.lightGray,
          cardTheme: CardTheme(
              color: AppColor.veryLightGray,
              shadowColor: AppColor.black.withOpacity(0.24),
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColor.dark_moderate_blue)),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.veryDarkGray2,
            selectionHandleColor: Colors.blue,
            selectionColor: Colors.blue.withOpacity(0.3),
          ),
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                fontFamily: StringUtils.appFont,
                color: AppColor.gray1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              filled: false,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 0.000001, color: AppColor.gray1, style: BorderStyle.none)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.000001, color: AppColor.veryDarkGray2, style: BorderStyle.none)),
              errorBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.000001, color: AppColor.strongRed, style: BorderStyle.none)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 0.000001, color: AppColor.gray1, style: BorderStyle.none)),
              isCollapsed: true,
              errorStyle: TextStyle(
                fontFamily: StringUtils.appFont,
                color: AppColor.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              labelStyle: TextStyle(
                fontFamily: StringUtils.appFont,
                color: AppColor.veryDarkGray2,
                fontSize: 18,
                height: 1.48,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              )),
          textTheme: _themeData.textTheme.copyWith(
              bodyLarge: TextStyle(
                color: AppColor.brightBlue,
                fontFamily: StringUtils.appFont,
              ),
              bodyMedium: TextStyle(
                color: AppColor.veryDarkGray2,
                fontFamily: StringUtils.appFont,
              ),
              bodySmall: TextStyle(
                color: AppColor.very_dark_gray,
                fontFamily: StringUtils.appFont,
              ),
              titleLarge: TextStyle(
                color: AppColor.very_dark_gray,
                fontFamily: StringUtils.appFont,
              ),
              titleSmall: TextStyle(
                color: AppColor.very_light_red,
                fontFamily: StringUtils.appFont,
              ),
              displayLarge: TextStyle(
                color: AppColor.very_dark_gray,
                fontFamily: StringUtils.appFont,
              ),
              displayMedium: TextStyle(
                color: AppColor.very_dark_gray2,
                fontFamily: StringUtils.appFont,
              ),
              displaySmall: TextStyle(
                color: AppColor.very_dark_gray,
                fontFamily: StringUtils.appFont,
              ),
              labelLarge: TextStyle(
                color: AppColor.gray_2,
                fontFamily: StringUtils.appFont,
              ),
              labelMedium: TextStyle(
                color: AppColor.darkGray,
                fontFamily: StringUtils.appFont,
              ),
              labelSmall: TextStyle(
                color: AppColor.dark_yellow1,
                fontFamily: StringUtils.appFont,
              ),
              titleMedium: TextStyle(
                color: AppColor.very_dark_gray1,
                fontFamily: StringUtils.appFont,
              )),
          primaryTextTheme: _themeData.textTheme.copyWith(
            bodyLarge: TextStyle(color: AppColor.white, fontFamily: StringUtils.appFont),
          ),
          iconTheme: IconThemeData(
            color: AppColor.very_dark_violet,
          ),
          indicatorColor: AppColor.veryDarkGray2,
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            textTheme: ButtonTextTheme.normal,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          dividerColor: AppColor.lightGrayishBlue,
          canvasColor: AppColor.vividYellow,
          tabBarTheme: TabBarTheme(
            labelColor: AppColor.darkBlack,
            unselectedLabelColor: AppColor.gray4,
            indicatorColor: AppColor.brightRed,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4.0, color: AppColor.brightRed),
            ),
          ),
        );
        break;
    }

    return _themeData;
  }

  late ReceivePort _receivePort;
  Isolate? _isolate;

  final GetTokenUseCase _getTokenUseCase;
  final InitAppFlyerSDKUseCase _initAppFlyerSDKUseCase;
  final LogAppFlyerSDKEventsUseCase _logAppFlyerSDKEventsUseCase;
  final LocalSessionUseCase _localSessionUseCase;

  static PublishSubject<GetTokenUseCaseParams> _getTokenRequest = PublishSubject();

  PublishSubject<GetTokenUseCaseParams> _getTokenWithLoaderRequest = PublishSubject();

  PublishSubject<Resource<bool>> _initInfobipMessageResponseSubject = PublishSubject();

  static PublishSubject<Resource<bool>> _getTokenResponse = PublishSubject();

  Stream<Resource<bool>> get getTokenStream => _getTokenResponse.stream;

  Stream<Resource<bool>> get initInfobipMessageResponseStream => _initInfobipMessageResponseSubject.stream;

  ///---------------init app flyers------------------///
  PublishSubject<InitAppFlyerSDKUseCaseParams> _initAppFlyerSDKRequestSubject = PublishSubject();
  PublishSubject<Resource<bool>> _initAppFlyerSDKResponseSubject = PublishSubject();

  Stream<Resource<bool>> get initAppFlyerSDKStream => _initAppFlyerSDKResponseSubject.stream;

  void initAppFlyerSDK() async {
    _initAppFlyerSDKRequestSubject.safeAdd(InitAppFlyerSDKUseCaseParams());
  }

  ///---------------init app flyers------------------///

  ///---------------log app flyers events------------------///
  PublishSubject<LogAppFlyerSDKEventsUseCaseParams> _logSDKFlyerEventsRequestSubject = PublishSubject();
  PublishSubject<Resource<bool>> _logSDKFlyerEventsResponseSubject = PublishSubject();

  Stream<Resource<bool>> get logSDKFlyerEventsStream => _logSDKFlyerEventsResponseSubject.stream;

  void logAppFlyerSDKEvents({required String eventName, required Map eventValue}) async {
    _logSDKFlyerEventsRequestSubject
        .safeAdd(LogAppFlyerSDKEventsUseCaseParams(eventValue: eventValue, eventName: eventName));
  }

  ///---------------log app flyers events------------------///
  AppViewModel(this._getTokenUseCase, this._initAppFlyerSDKUseCase, this._logAppFlyerSDKEventsUseCase,
      this._localSessionUseCase) {
    _getTokenRequest.listen((value) {
      RequestManager(value, createCall: () => _getTokenUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.ERROR) {
          //print("error");
        }
        _getTokenResponse.safeAdd(event);
      });
    });

    /// For the session timeout...
    _getTokenWithLoaderRequest.listen((value) {
      RequestManager(value, createCall: () => _getTokenUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS || event.status == Status.ERROR) {
          Navigator.pop(appLevelKey.currentContext!);
        } else if (event.status == Status.LOADING) {
          AppProgress(appLevelKey.currentContext!);
        }
      });
    });

    _initAppFlyerSDKRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _initAppFlyerSDKUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _initAppFlyerSDKResponseSubject.safeAdd(event);
        if (event.status == Status.SUCCESS) {
          debugPrint('-----SDK INITIALIZED------');
          logAppFlyerSDKEvents(eventName: 'app_launch', eventValue: {"app_launched": "First launch"});
        }
      });
    });

    _logSDKFlyerEventsRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _logAppFlyerSDKEventsUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _logSDKFlyerEventsResponseSubject.safeAdd(event);
        if (event.status == Status.SUCCESS) {
          debugPrint('-----EVENT LOGGED------');
        }
      });
    });

    initAppFlyerSDK();
  }

  BehaviorSubject<bool>? sessionWarningStream;
  StreamSubscription<bool>? sessionWarningStreamSubscription;
  BehaviorSubject<bool>? sessionEndStream;
  StreamSubscription<bool>? sessionEndStreamSubscription;

  startSessionWarningStream() {
    sessionWarningStreamSubscription?.cancel();
    sessionEndStreamSubscription?.cancel();

    sessionWarningStream = ProviderScope.containerOf(appLevelKey.currentState!.context)
        .read(localSessionService)
        .warningStreamSubject;

    sessionWarningStreamSubscription = sessionWarningStream?.stream.listen((event) {
      if (event) {
        SessionTimeoutDialog.show(
          appLevelKey.currentState!.context,
          title: S.of(appLevelKey.currentState!.context).activity,
          onSelected: () {
            /// continue button call api to restart timer...
            _callGetTokenWithLoader();
            Navigator.pop(appLevelKey.currentState!.context);
          },
        );
      }
    });

    sessionEndStream = ProviderScope.containerOf(appLevelKey.currentState!.context)
        .read(localSessionService)
        .sessionStreamSubject;

    sessionEndStreamSubscription = sessionEndStream?.stream.listen((event) {
      if (event) {
        AppConstantsUtils.resetCacheLists();

        if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
          AntelopHelper.walletDisconnect();
        }
        Navigator.pushNamedAndRemoveUntil(
            appLevelKey.currentContext!, RoutePaths.OnBoarding, (route) => false);
      }
    });
  }

  void getToken() async {
    if (_isolate != null) {
      return;
    }
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_getTokenCallBack, _receivePort.sendPort);
    _receivePort.listen(_handleMessage, onDone: () {});
  }

  void _handleMessage(dynamic data) {
    _callGetToken();
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    Timer.periodic(Duration(minutes: 2), (Timer t) {
      sendPort.send('Send');
    });
  }

  void stopRefreshToken() {
    if (_isolate != null) {
      _isolate!.kill(priority: 0);
      _isolate = null;
    }
  }

  void _callGetToken() {
    _getTokenRequest.add(GetTokenUseCaseParams());
  }

  void _callGetTokenWithLoader() {
    _getTokenWithLoaderRequest.add(GetTokenUseCaseParams());
  }

  Future<void> userActivityDetected() async {
    String? token = await SecureStorageHelper.instance.getToken();
    if (token != null) {
      ProviderScope.containerOf(appLevelKey.currentState!.context).read(localSessionService).startTimer();
    }
  }

  ThemeData toggleTheme() {
    if (appTheme == AppTheme.dark) {
      _appTheme = AppTheme.light;
    } else {
      _appTheme = AppTheme.dark;
    }
    return themeData;
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolate?.kill();
    _getTokenWithLoaderRequest.close();
    _getTokenRequest.close();
    sessionEndStreamSubscription?.cancel();
    sessionWarningStreamSubscription?.cancel();

    super.dispose();
  }

  Future<void> getAppSignature() async {
    AppConstantsDomain.APP_SIGNATURE = await SmsAutoFill().getAppSignature;
  }
}

enum AppTheme {
  dark,
  light,
}
