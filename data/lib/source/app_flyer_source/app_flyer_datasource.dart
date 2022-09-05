abstract class AppFlyerDataSource {
  /// init sdk
  Future<bool> initAppFlyerSdk();

  /// log events
  Future<bool> logAppFlyerEvent({required String eventName, required Map eventValue});
}
