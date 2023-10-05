import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'infobipplugin_platform_interface.dart';

/// An implementation of [InfobippluginPlatform] that uses method channels.
class MethodChannelInfobipplugin extends InfobippluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('infobipplugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
