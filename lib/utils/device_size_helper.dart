import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';

import '../main/app_viewmodel.dart';

class DeviceSizeHelper {
  static bool get isSmallDevice {
    Size deviceSize = MediaQuery.of(appLevelKey.currentContext!).size;
    return deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
  }
}
