import 'dart:io';

import 'package:data/entity/remote/base/base_class.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:package_info/package_info.dart';
import 'package:r_get_ip/r_get_ip.dart';

class DeviceInfoHelper {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  String platformType() {
    return Platform.isAndroid ? 'A' : 'I';
  }

  ///Load device info to submit as base class in api.
  Future<BaseClassEntity> getDeviceInfo() async {
    Map<String, dynamic> deviceData = await initPlatformState();
    final PackageInfo info = await PackageInfo.fromPlatform();
    print('Device Data ' + deviceData.toString());
    print('Package Info Data ' + ' ' + info.version + ' ' + info.buildNumber);
    String externalIp = "";
    try {
      externalIp = (await RGetIp.externalIP)!;
    } catch (e) {
      print(e.toString());
      externalIp = "";
    }

    return BaseClassEntity(
      appVersion: info.version,
      //appVersion: info.version + ' ' + info.buildNumber,
      ip: externalIp,
      deviceID: Platform.isAndroid
          ? deviceData['androidId']
          : deviceData['identifierForVendor'],
      mobileModel:
          Platform.isAndroid ? deviceData['model'] : deviceData['model'],
    );
  }

  Future<Map<String, dynamic>> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    return deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'brand': build.brand,
      'androidId': build.androidId,
      'device': build.device,
      'model': build.model,
      'id': build.id,
      'board': build.board,
      'bootloader': build.bootloader,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'manufacturer': build.manufacturer,
      'product': build.product,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Future<bool> checkDeviceSecurity() async {
    try {
      if (Platform.isAndroid) {
        return await FlutterJailbreakDetection.developerMode;
      } else if (Platform.isIOS) {
        return await FlutterJailbreakDetection.jailbroken;
      }
    } on PlatformException {
      return true;
    }
    return true;
  }
}
