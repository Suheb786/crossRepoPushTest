import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:infobipplugin/infobipplugin.dart';
import 'package:infobipplugin_example/Screens/call_screen/call_screen.dart';
import 'package:infobipplugin_example/Utils/StringRes.dart';
import 'package:infobipplugin_example/Utils/colorconstatnt.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var time;

  var token = '';
  var startTimeIdGet = '';
  var endTimeIdGet = '';
  var callDurationIdGet = '';
  var establishTimeIdGet = '';
  bool speaker = false;
  bool mute = false;
  bool isCall = false;
  bool onlineStatus = false;
  var status = '';
  bool isIntialized = false;

  @override
  void onInit() {
    initAll();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      hasNetwork();
    });
    super.onInit();
  }

  initAll() async {
    await requestPermission();
    await hasNetwork();

    if (onlineStatus == true) {
      await initSdk();
      await getToken();
    } else {
      isIntialized = true;
    }
    Timer.periodic(const Duration(seconds: 2), (timer) {
      time = timer;
      init();

      update(['call']);
    });
  }

  hasNetwork() async {
    var st = await (Connectivity().checkConnectivity());

    if (st == ConnectivityResult.mobile ||
        st == ConnectivityResult.wifi ||
        st == ConnectivityResult.vpn ||
        st == ConnectivityResult.ethernet ||
        st == ConnectivityResult.other ||
        st == ConnectivityResult.bluetooth) {
      onlineStatus = true;

      if (isIntialized == true) {
        if (token == '') {
          await initSdk();
          await getToken();
        }
      }
      print("===================online status=================${onlineStatus}");
    } else {
      onlineStatus = false;
      print("===================online status=================${onlineStatus}");

      Get.snackbar("Error", "Please Check Internet Connection",
          backgroundColor: ColorConstatnts.red, colorText: ColorConstatnts.white);
    }

    update(['call']);
  }

  /// ----  sdk init ----

  initSdk() async {
    var data = await InfoBip().sdkInit(
        appKey: StringRes.apiKey,
        applicationId: StringRes.applicationId,
        baseUrl: StringRes.baseUrl,
        callStatus: (callStatus) {});
    Get.snackbar("Success", data.toString(),
        backgroundColor: ColorConstatnts.green, colorText: ColorConstatnts.white);

    update(['call']);
  }

  /// ---- get token ----

  getToken() async {
    var parameter = {
      'identity': StringRes.applicationId,
      "displayName": StringRes.applicationId,
      "applicationId": StringRes.applicationId,
      "appKey": StringRes.apiKey,
      "baseUrl": StringRes.baseUrl
    };
    var tokenDetail = await InfoBip().getToken(parameter: parameter);
    token = tokenDetail;

    Get.snackbar("Success", tokenDetail,
        backgroundColor: ColorConstatnts.green, colorText: ColorConstatnts.white);

    isIntialized = true;
    update(['call']);
  }

  ///
  ///Add recod audio permission
  ///
  Future<void> requestPermission() async {
    var permission = await Permission.microphone.status;

    if (permission == PermissionStatus.granted) {
    } else if (permission == PermissionStatus.denied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.

      Permission.microphone.request().then((value) => print("===========$value"));
    } else {}
  }

  /// ---- call dial ----

  callDial() async {
    if (onlineStatus == false) {
      Get.snackbar("Error", "Please Check Internet Connection",
          backgroundColor: ColorConstatnts.red, colorText: ColorConstatnts.white);
    } else {
      if (token != '') {
        String callMake = await InfoBip().callDial(token: token);
        if (callMake == 'Done') {
          Get.to(CallScreen());
          if (time != null) {
            time.cancel();
          }
        } else {
          Get.snackbar("Error", "$callMake", backgroundColor: ColorConstatnts.red);
        }
      } else {
        Get.snackbar("Error", "Please get token first", backgroundColor: ColorConstatnts.red);
      }
    }

    update(['call']);
  }

//   /// ---- mute/unmute ----
//
//   muteUnmute()async{
//     var muteOrUnmute = await InfoBip().muteUnmute();
//     mute = muteOrUnmute;
//
//     update(['call']);
//
//   }
//
//
//   /// ---- speaker phone ----
//
//   speakerPhone()async{
//     var speakerPhone = await InfoBip().speakerPhone();
//    speaker =speakerPhone;
//
//     update(['call']);
//
//   }
//
//
//   /// ---- establish time ----
//
//   establishTime()async{
//     var establish = await InfoBip().establishTime();
//     establishTimeIdGet = establish.toString();
//    // callstatus();
//     update(['call']);
//
//   }
//
//
//   /// ---- call duration ----
//
//   callDuration()async{
//     var callDurationTime = await InfoBip().callDuration();
//  callDurationIdGet = callDurationTime.toString();
//
//     update(['call']);
//
//   }
//
//
//   /// ---- start Time ----
//
//   startTime()async{
//     var startTimeId = await InfoBip().startTime();
// startTimeIdGet =  startTimeId;
//
//
//     update(['call']);
//
//   }
//
//
//   /// ---- End Time ----
//
//   endTime()async{
//     var endTimeId = await InfoBip().endTime();
//  endTimeIdGet = endTimeId;
//
//
//     update(['call']);
//
//   }
//
//   /// ---- hang up call ----
//
//   hangUpCall()async{
//     var hangCall = await InfoBip().callHang();
//     Get.snackbar("Success", hangCall.toString(),
//         backgroundColor: ColorConstatnts.green,
//         colorText: ColorConstatnts.white);
//
//
//     update(['call']);
//
//   }
//

  init() async {
    InfoBip().listenCallStatus.listen((event) {
      status = event!;
    });
  }
}
