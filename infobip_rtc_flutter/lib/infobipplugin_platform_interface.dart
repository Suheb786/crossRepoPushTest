import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'infobipplugin_method_channel.dart';

abstract class InfobippluginPlatform extends PlatformInterface {
  /// Constructs a InfobippluginPlatform.
  InfobippluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static InfobippluginPlatform _instance = MethodChannelInfobipplugin();

  /// The default instance of [InfobippluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelInfobipplugin].
  static InfobippluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InfobippluginPlatform] when
  /// they register themselves.
  static set instance(InfobippluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
