import 'dart:async';
import 'package:get/get.dart';
import 'package:infobipplugin/infobipplugin.dart';
import 'package:infobipplugin_example/Screens/home_screen/home_controller.dart';
import 'package:infobipplugin_example/Screens/home_screen/home_screen.dart';
import 'package:infobipplugin_example/Screens/not_answerd_screen/not_answred_screen.dart';
import 'package:infobipplugin_example/Utils/colorconstatnt.dart';

class CallController extends GetxController {
  var startTimeIdGet = '';
  var endTimeIdGet = '';
  var callDurationIdGet = '';
  var establishTimeIdGet = '';
  bool speaker = false;
  bool mute = false;
  var status = '';
  var hangup = false;

  HomeController homeController = Get.put(HomeController());

  /// ---- mute/unmute ----

  muteUnmute() async {
    if (homeController.onlineStatus == true) {
      var muteOrUnmute = await InfoBip().muteUnmute();
      mute = muteOrUnmute;

      update(['hang']);
    } else {
      Get.snackbar("Error", "Please Check Internet Connection",
          backgroundColor: ColorConstatnts.red, colorText: ColorConstatnts.white);
    }
  }

  /// ---- speaker phone ----

  speakerPhone() async {
    if (homeController.onlineStatus == true) {
      var speakerPhone = await InfoBip().speakerPhone();
      speaker = speakerPhone;
      //callstatus();
      update(['hang']);
    } else {
      Get.snackbar("Error", "Please Check Internet Connection",
          backgroundColor: ColorConstatnts.red, colorText: ColorConstatnts.white);
    }
  }

  // ---- establish time ----

  establishTime() async {
    var establish = await InfoBip().establishTime();
    establishTimeIdGet = establish.toString();

    update(['hang']);
  }

  /// ---- hang duration ----

  callDuration() async {
    var callDurationTime = await InfoBip().callDuration();
    callDurationIdGet = callDurationTime.toString();

    update(['hang']);
  }

  /// ---- start Time ----

  startTime() async {
    var startTimeId = await InfoBip().startTime();
    startTimeIdGet = startTimeId;

    update(['hang']);
  }

  /// ---- End Time ----

  endTime() async {
    var endTimeId = await InfoBip().endTime();
    endTimeIdGet = endTimeId;

    update(['hang']);
  }

  /// ---- hang up hang ----

  hangUpCall() async {
    if (homeController.onlineStatus == true) {
      var hangcall = await InfoBip().callHang();
      callTime();
      hangup = hangcall;
      update(['hang']);
    } else {
      Get.snackbar("Error", "Please Check Internet Connection",
          backgroundColor: ColorConstatnts.red, colorText: ColorConstatnts.white);
    }
  }

  @override
  void dispose() {
    startTimeIdGet = '';
    endTimeIdGet = '';
    callDurationIdGet = '';
    establishTimeIdGet = '';
    speaker = false;
    mute = false;
    status = '';
    hangup = false;
    update(['hang']);

    super.dispose();
  }

  init() async {
    InfoBip().listenCallStatus.listen((event) {
      status = event!;
      update(['hang']);
    });
  }

  callTime() async {
    if (homeController.onlineStatus == true) {
      await startTime();
      await endTime();
      await establishTime();
      await callDuration();
    } else {
      Get.snackbar("Error", "Please Check Internet Connection",
          backgroundColor: ColorConstatnts.red, colorText: ColorConstatnts.white);
    }
  }

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      init();
      if (status == "onHangup-REQUEST_TIMEOUT") {
        hangup = true;
        callTime();
        Get.to(const NotAnsweredScreen());
        timer.cancel();
      } else if (status == "onHangup-NORMAL_HANGUP") {
        hangup = true;
        callTime();
        timer.cancel();
      } else if (status == "onHangup-NETWORK_ERROR") {
        InfoBip().callHang();
        hangup = true;
        callTime();
        timer.cancel();
        Get.offAll(HomeScreen());
      }
    });
    super.onInit();
  }
}
