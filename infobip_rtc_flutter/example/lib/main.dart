import 'package:flutter/material.dart';
import 'dart:async';

import 'package:infobip_plugin/infobip_plugin.dart';
import 'package:infobip_plugin/Utils/call_event_listener.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements CallEventListener {
  @override
  void initState() {
    super.initState();
    initInfobip();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                  onPressed: initInfobip,
                  child: const Text("Init Infobit Rtc")),
            ),
            Center(
              child: TextButton(
                  onPressed: obtainToken, child: const Text("Get Token")),
            ),
            Center(
              child: TextButton(onPressed: call, child: const Text("Call")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => mute(), child: const Text("Mute / Unmute")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => toggleSpeaker(),
                  child: const Text("Speaker ON/OFF")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => getCallEstablishTime(),
                  child: const Text("Get Call Establish Time")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => getCallDuration(),
                  child: const Text("Get Call Duration")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => getCallStartTime(),
                  child: const Text("Get Call Start Time")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => getCallendTime(),
                  child: const Text("Get Call end Time")),
            ),
            Center(
              child: TextButton(
                  onPressed: () => callHangUp(),
                  child: const Text("Hang up call")),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Replace the appkey with your infobip portal app key
  /// Replace the applicationId with your infobip Application id
  ///
  Future<void> initInfobip() async {
    try {
      var isSuccess = await InfobipPlugin().init(
              appKey:
                  "d48f97a07a5828761b1b8abe2976a24a-f66e3aa6-ff53-4387-a45e-0f52bdc89a11",
              applicationId: "75154e24-1e99-48e4-a25d-9f561df4d101",
              baseUrl: "https://gyw5rw.api.infobip.com",
              callStatus: (callStatus) {
                print("EXAMPLE $callStatus");
              }) ??
          {};
      print(isSuccess);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method used for get your token with
  Future<void> obtainToken() async {
    try {
      var parameter = {'identity': "Alice_Test", "displayName": "Alice_Test"};
      var tokenDetail = await InfobipPlugin().getToken(parameter: parameter);
      // ignore: avoid_print
      print(tokenDetail);
    } catch (e) {
      rethrow;
    }
  }

  ///
  ///Add recod audio permission
  ///
  Future<void> requestPermission() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.permanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    setState(() {
      print(status);
    });
  }

  ///
  /// This method is used to call agent
  ///
  void call() async {
    requestPermission().then((value) async {
      try {
        await InfobipPlugin().callConversations();
        InfobipPlugin().setCallbackForCall(this);
      } catch (e) {
        rethrow;
      }
    });
  }

  ///
  /// This method is used to mute or unmute call
  ///
  void mute() async {
    try {
      var currentMuteStatus = await InfobipPlugin().muteUnMute();
      print(currentMuteStatus);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to on off phone speaker
  ///
  void toggleSpeaker() async {
    try {
      var currentSpeakerStatus = await InfobipPlugin().toggleSpeaker();
      print(currentSpeakerStatus);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get current call duration in seconds
  ///
  void getCallDuration() async {
    try {
      var durationInSecond = await InfobipPlugin().getCallDuration();
      print(durationInSecond);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get call establish time
  ///
  void getCallEstablishTime() async {
    try {
      var establishTime = await InfobipPlugin().getCallEstablishTime();
      print(establishTime);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get call start time
  ///
  void getCallStartTime() async {
    try {
      var startTime = await InfobipPlugin().getCallStartTime();
      print(startTime);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get call end time
  ///
  void getCallendTime() async {
    try {
      var endTime = await InfobipPlugin().getEndTime();
      print(endTime);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to hangup call
  ///
  void callHangUp() async {
    try {
      var status = await InfobipPlugin().hangUpCall();
      print(status);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onError() {
    // TODO: implement onError
    print("ON ERROR");
  }

  @override
  void onHangup() {
    // TODO: implement onHangup
    print("ON HANGUP");
  }

  @override
  void onRinging() {
    // TODO: implement onRinging
    print("ON RINGING");
  }

  @override
  void onEarlyMedia() {
    // TODO: implement onEarlyMedia
    print("ON EARLY MEDIA");
  }

  @override
  void onEstablished() {
    // TODO: implement onEstablished
    print("ON ESTABLISH");
  }

  @override
  void onUpdated() {
    // TODO: implement onUpdated
    print("ON UPDATE");
  }
}
