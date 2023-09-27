import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'Utils/call_event_listener.dart';
import 'Utils/call_status.dart';
import 'Utils/method_keys.dart';

class InfoBip {
  MethodChannel channel = const MethodChannel(MethodKeys.TAG);
  EventChannel eventChannel = const EventChannel(MethodKeys.CHANNEL);

  /// ---- sdk init ----

  sdkInit(
      {required String applicationId,
      required String appKey,
      required String baseUrl,
      required Function callStatus}) async {
    eventChannel.receiveBroadcastStream().listen((onData) {
      if (kDebugMode) {
        print("LISTEN::$onData");
      }
      callStatus(onData);
    });
    var parameter = {'application_id': applicationId, "app_key": appKey, "app_base_url": baseUrl};
    try {
      final bool? data = await channel.invokeMethod(MethodKeys.init, parameter);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// ---- get Token ----

  getToken({required Map<String, String> parameter}) async {
    try {
      final String? tokenDetail = await channel.invokeMethod(MethodKeys.getToken, parameter);
      if (kDebugMode) {
        print("Token $tokenDetail");
      }
      return tokenDetail;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- call Dial ----

  callDial({required String token}) async {
    try {
      Map parameter = {"token": token};

      final bool? callMake = await channel.invokeMethod(MethodKeys.makeCall, parameter);

      return callMake;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- call mute/unmute ----

  muteUnmute() async {
    try {
      final bool? muteUnmuteId = await channel.invokeMethod(
        MethodKeys.muteUnMute,
      );

      return muteUnmuteId;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- speaker phone ----

  speakerPhone() async {
    try {
      final bool? speaker = await channel.invokeMethod(
        MethodKeys.toggleSpeaker,
      );

      return speaker;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- establish time ----

  establishTime() async {
    try {
      final String? establishTimeId = await channel.invokeMethod(MethodKeys.callEstablishTime);

      return establishTimeId;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- start time----

  startTime() async {
    try {
      final String? startTimeId = await channel.invokeMethod(MethodKeys.callStartTime);

      return startTimeId;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- end Time ----

  endTime() async {
    try {
      final String? endTimeId = await channel.invokeMethod(MethodKeys.callEndTime);

      return endTimeId;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- call duration ----

  callDuration() async {
    try {
      final int? callDurationId = await channel.invokeMethod(MethodKeys.callDuration);

      return callDurationId;
    } catch (e) {
      rethrow;
    }
  }

  /// ---- call hang up ----

  callHang() async {
    try {
      final bool? callHang = await channel.invokeMethod(MethodKeys.callHangUp);

      return callHang;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// call status
  ///

  callStatus() async {
    try {
      var result = await channel.invokeMethod(MethodKeys.finalCallStatus);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used for listen the call status
  ///

  Stream<String?> get listenCallStatus async* {
    var result = await channel.invokeMethod<String>(MethodKeys.finalCallStatus);

    yield result;
  }

  setCallbackForCall(CallEventListener callEventListener) {
    listenCallStatus.listen((event) {
      switch (event) {
        case CallStatus.onRinging:
          callEventListener.onRinging();
          break;
        case CallStatus.onHangUp:
          callEventListener.onHangup();
          break;
        case CallStatus.onEarlyMedia:
          callEventListener.onEarlyMedia();
          break;
        case CallStatus.onEstablished:
          callEventListener.onEstablished();
          break;
        case CallStatus.onUpdated:
          callEventListener.onUpdated();
          break;
      }
    });
  }

}