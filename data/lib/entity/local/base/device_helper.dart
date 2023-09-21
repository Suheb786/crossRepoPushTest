import 'dart:io';

import 'package:data/entity/local/base/device_info_service.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<DeviceCompatibilityEnum> deviceJailBroken =
    BehaviorSubject.seeded(DeviceCompatibilityEnum.NONE);

Stream<DeviceCompatibilityEnum> get deviceJailBrokenStream => deviceJailBroken.stream;

bool isJailBreakPopUpShown = false;

class DeviceInfoHelper extends DeviceInfoService {
  String platformType() {
    return Platform.isAndroid ? 'A' : 'I';
  }

  ///Load device info to submit as base class in api.
  Future<BaseClassEntity> initialiseDeviceInfo() async {
    String deviceData = await FlutterUdid.consistentUdid;
    final PackageInfo info = await PackageInfo.fromPlatform();
    debugPrint('Device Data ' + deviceData.toString());
    debugPrint('Package Info Data ' + ' ' + info.version + ' ' + info.buildNumber);

    return BaseClassEntity(
      appVersion: info.version,
      ip: '',
      deviceID: deviceData,
      mobileModel: "",
    );
  }

  Future<bool> checkDeviceSecurity() async {
    try {
      debugPrint('-----JailBroken------${await FlutterJailbreakDetection.jailbroken}');
      return await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      return true;
    }
  }
}
