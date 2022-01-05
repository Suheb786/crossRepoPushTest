import 'dart:async';

import 'package:flutter/services.dart';
import 'package:infobip_plugin/Utils/call_event_listener.dart';
import 'package:infobip_plugin/Utils/call_status.dart';
import 'package:infobip_plugin/Utils/method_keys.dart';

class InfobipPlugin {
  static const MethodChannel _channel = MethodChannel('infobip_plugin');

  static const EventChannel _stream = EventChannel('infobip_plugin_event');

  ///
  /// this method is used to initialize the stuff
  /// Need to pass ApplicationId, AppKey and BaseUrl
  ///
  Future<bool?> init(
      {required String applicationId,
      required String appKey,
      required String baseUrl, required Function callStatus}) async {
    _stream.receiveBroadcastStream().listen((onData) {
      print("LISTEN::$onData");
      callStatus(onData);
    });
    var parameter = {
      'application_id': applicationId,
      "app_key": appKey,
      "app_base_url": baseUrl
    };
    final bool? initStatus =
        await _channel.invokeMethod(MethodKeys.init, parameter);
    return initStatus;
  }

  ///
  /// This method used to obtain token from destination, display name
  ///
  Future<String?> getToken(
      {required String identity, required String displayName}) async {
    var parameter = {'identity': identity, "displayName": displayName};
    final String? tokenDetail =
        await _channel.invokeMethod(MethodKeys.getToken, parameter);
    return tokenDetail;
  }

  ///
  /// This method is used for establish the call
  ///
  Future<bool> callConversations() async {
   return await _channel.invokeMethod(MethodKeys.makeCall);
  }

  ///
  /// This method is used for listen the call status
  ///
  static Stream<String?> get listenCallStatus async* {
    var result =
        await _channel.invokeMethod<String?>(MethodKeys.finalCallStatus);

    yield result;
  }

  void handleLocationChanges() {}

  static setCallbackForCall(CallEventListener callEventListener) {
    listenCallStatus.listen((event) {
      switch (event) {
        case CallStatus.ON_RINGING:
          callEventListener.onRinging();
          break;
        case CallStatus.ON_HANGUP:
          callEventListener.onHangup();
          break;
        case CallStatus.ON_EARLY_MEDIA:
          callEventListener.onEarlyMedia();
          break;
        case CallStatus.ON_ESTABLISHED:
          callEventListener.onEstablished();
          break;
        case CallStatus.ON_UPDATED:
          callEventListener.onUpdated();
          break;
      }
    });
  }

  ///
  /// This method is used for mute or unmute the call
  ///
  Future<bool?> muteUnMute() async {
    var result = await _channel.invokeMethod<bool?>(MethodKeys.muteUnMute);

    return result;
  }

  ///
  /// This method is used for call on speaker and off speaker
  ///
  Future<bool?> toggleSpeaker() async {
    var result = await _channel.invokeMethod<bool?>(MethodKeys.toggleSpeaker);

    return result;
  }

  ///
  /// This method is used for get current call duration and the return value of duration is in second
  ///
  Future<int?> getCallDuration() async {
    var result = await _channel.invokeMethod<int?>(MethodKeys.callDuration);

    return result;
  }

  ///
  /// This method is used for get current call establish time and the return [DateTime] String
  ///
  Future<String?> getCallEstablishTime() async {
    var result =
        await _channel.invokeMethod<String?>(MethodKeys.callEstablishTime);

    return result;
  }

  ///
  /// This method is used for get current call start time and the return [DateTime] String
  ///
  Future<String?> getCallStartTime() async {
    var result = await _channel.invokeMethod<String?>(MethodKeys.callStartTime);

    return result;
  }

  ///
  /// This method is used for get current call end time and the return [DateTime] String
  ///
  Future<String?> getEndTime() async {
    var result = await _channel.invokeMethod<String?>(MethodKeys.callEndTime);

    return result;
  }

  ///
  /// This method is used for hang up the current call
  ///
  Future<bool?> hangUpCall() async {
    var result = await _channel.invokeMethod<bool?>(MethodKeys.callHangUp);
    return result;
  }
}
