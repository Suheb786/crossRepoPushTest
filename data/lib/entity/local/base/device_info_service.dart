import 'package:data/entity/remote/base/base_class.dart';
import 'package:flutter/material.dart';

abstract class DeviceInfoService {
  BaseClassEntity? _deviceInfo;

  Future<BaseClassEntity> getDeviceInfo() async {
    if (_deviceInfo == null) {
      _deviceInfo = await initialiseDeviceInfo();
    }

    return _deviceInfo!;
  }

  @protected
  Future<BaseClassEntity> initialiseDeviceInfo();
}
