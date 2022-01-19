import 'dart:async';

import 'package:domain/usecase/utility/check_device_compatibility_usecase.dart';
import 'package:flutter/animation.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/subjects.dart';

class SplashViewModel extends BasePageViewModel {
  final CheckDeviceCompatibilityUsecase _checkDeviceCompatibilityUsecase;

  PublishSubject<CheckDeviceCompatibilityUsecaseParams>
      _checkDeviceCompatibilityRequest = PublishSubject();

  PublishSubject<Resource<bool>> _checkDeviceCompatibilityResponse =
      PublishSubject();

  Stream<Resource<bool>> get isDeviceCompatible =>
      _checkDeviceCompatibilityResponse.stream;

  ///linear progress bar progress holder subject
  final BehaviorSubject<double> _splashProgressSubject =
      BehaviorSubject.seeded(0.0);

  Stream<double> get splashProgressStream => _splashProgressSubject.stream;

  AnimationController? animationController;

  ///app version response
  final PublishSubject<String> _appVersionSubject = PublishSubject();

  Stream<String> get appVersionStream => _appVersionSubject.stream;

  SplashViewModel(this._checkDeviceCompatibilityUsecase) {
    _checkDeviceCompatibilityRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkDeviceCompatibilityUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        _checkDeviceCompatibilityResponse.safeAdd(event);
      });
    });
    getAppVersion();
  }

  /// Timer logic to trigger after 1 sec
  startTimer(Duration duration) {
    Timer(duration, () {
      _splashProgressSubject.safeAdd(1.0);
    });
  }

  /// get version
  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    _appVersionSubject.safeAdd('Version: $version+$buildNumber');
  }

  /// Check device compatibility
  void checkDeviceCompatibility() {
    _checkDeviceCompatibilityRequest
        .safeAdd(CheckDeviceCompatibilityUsecaseParams());
  }

  @override
  void dispose() {
    _splashProgressSubject.close();
    _checkDeviceCompatibilityRequest.close();
    _checkDeviceCompatibilityResponse.close();
    super.dispose();
  }
}
