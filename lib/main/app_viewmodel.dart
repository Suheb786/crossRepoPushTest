import 'dart:async';
import 'dart:isolate';

import 'package:domain/usecase/infobip_audio/init_infobip_message_usecase.dart';
import 'package:domain/usecase/infobip_audio/save_user_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

GlobalKey<NavigatorState> appLevelKey = GlobalKey(debugLabel: 'app-key');

class AppViewModel extends BaseViewModel {
  ThemeData _themeData = ThemeData();
  AppTheme _appTheme = AppTheme.light;

  // static Timer? tokenTimer;

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
              selectionHandleColor: Colors.blue,
              selectionColor: Colors.blue.withOpacity(0.3),
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
            errorColor: AppColor.vivid_red,
            indicatorColor: AppColor.veryDarkGray2,
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              textTheme: ButtonTextTheme.normal,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            dividerColor: AppColor.lightGrayishBlue,
            canvasColor: AppColor.vividYellow);
        break;
    }

    return _themeData;
  }

  late ReceivePort _receivePort;
  Isolate? _isolate;

  final GetTokenUseCase _getTokenUseCase;
  final SaveUserUseCase _saveUserUseCase;
  final InfobipMessagePluginUseCase _infobipMessagePluginUseCase;

  PublishSubject<InfobipMessagePluginUseCaseParams>
      _initInfobipMessageRequestSubject = PublishSubject();

  PublishSubject<SaveUserUseCaseParams> _saveUserRequestSubject =
      PublishSubject();

  static PublishSubject<GetTokenUseCaseParams> _getTokenRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _initInfobipMessageResponseSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _saveuserResponseSubject = PublishSubject();

  static PublishSubject<Resource<bool>> _getTokenResponse = PublishSubject();

  Stream<Resource<bool>> get getTokenStream => _getTokenResponse.stream;

  Stream<Resource<bool>> get initInfobipMessageResponseStream =>
      _initInfobipMessageResponseSubject.stream;

  Stream<Resource<bool>> get saveUserResponseStream =>
      _saveuserResponseSubject.stream;

  AppViewModel(this._getTokenUseCase, this._infobipMessagePluginUseCase,
      this._saveUserUseCase) {
    _getTokenRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getTokenUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.ERROR) {
          print("error");
        }
        _getTokenResponse.safeAdd(event);
      });
    });

    _initInfobipMessageRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _infobipMessagePluginUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _initInfobipMessageResponseSubject.safeAdd(event);
      });
    });

    _saveUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _saveUserUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _saveuserResponseSubject.safeAdd(event);
      });
    });
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    initInfobipMessagePlugin();
  }

  initInfobipMessagePlugin() async {
    _initInfobipMessageRequestSubject
        .safeAdd(InfobipMessagePluginUseCaseParams());
  }

  void saveUserData() {
    _saveUserRequestSubject.safeAdd(SaveUserUseCaseParams());
  }

  // void getToken() async {
  //   if (_isolate != null) {
  //     return;
  //   }
  //   _receivePort = ReceivePort();
  //   _isolate = await Isolate.spawn(_getTokenCallBack, _receivePort.sendPort);
  //   _receivePort.listen(_handleMessage, onDone: () {
  //     print('Done');
  //   });
  // }

  void _handleMessage(dynamic data) {
    print('data $data');
    _callGetToken();
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    Timer.periodic(Duration(minutes: 2), (Timer t) {
      sendPort.send('Send');
    });
  }

  // void pauseRefreshToken() {
  //   if (_isolate != null) {
  //     print('inside pause token');
  //     _isolate!.pause(_isolate!.pauseCapability!);
  //     //_receivePort.close();
  //   }
  // }
  //
  // void resumeRefreshToken() {
  //   if (_isolate != null) {
  //     print('inside resume token');
  //     _isolate!.resume(_isolate!.pauseCapability!);
  //   } else {
  //     getToken();
  //   }
  // }
  //
  // void stopRefreshToken() {
  //   if (_isolate != null) {
  //     print('inside stop token');
  //     _isolate!.kill(priority: 0);
  //     _isolate = null;
  //   }
  // }

  void _callGetToken() {
    _getTokenRequest.add(GetTokenUseCaseParams());
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
    super.dispose();
  }
}

enum AppTheme {
  dark,
  light,
}
