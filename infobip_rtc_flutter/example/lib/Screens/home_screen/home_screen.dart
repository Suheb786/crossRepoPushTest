import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infobipplugin_example/Screens/home_screen/home_controller.dart';
import 'package:infobipplugin_example/Utils/colorconstatnt.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Bip Sdk"),
        backgroundColor: ColorConstatnts.deepPurple,
      ),
      body: GetBuilder<HomeController>(
          id: "call",
          builder: (con) {
            return Container(
              width: Get.width,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// call initiated button
                    // InkWell(
                    //   onTap: () {
                    //     homeController.initSdk();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width * 0.3,
                    //     alignment: Alignment.center,
                    //     child: const Text("Initialize call"),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    //
                    // /// Get token button
                    // InkWell(
                    //   onTap: () {
                    //     homeController.getToken();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width * 0.3,
                    //     alignment: Alignment.center,
                    //     child: const Text("Get Token"),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    /// call button
                    InkWell(
                      onTap: () async {
                        await homeController.callDial();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width * 0.3,
                        alignment: Alignment.center,
                        color: ColorConstatnts.green,
                        child: const Text(
                          "Call",
                          style: TextStyle(color: ColorConstatnts.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // /// mute/unmute button
                    // InkWell(
                    //   onTap: (){
                    //     homeController.muteUnmute();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.35,
                    //     alignment: Alignment.center,
                    //     child: Row(
                    //       children: [
                    //         (homeController.mute)?const Icon(Icons.volume_up):const Icon(Icons.volume_off),
                    //     const SizedBox(width: 10,),
                    //         const Text("Mute/Unmute"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                    // /// Speaker ON/OFF button
                    // InkWell(
                    //   onTap: (){
                    //     homeController.speakerPhone();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.35,
                    //     alignment: Alignment.center,
                    //     child: Row(
                    //       children: [
                    //         (homeController.speaker)?const Icon(Icons.mic):const Icon(Icons.mic_off),
                    //         const SizedBox(width: 10,),
                    //         const Text("Speaker ON/OFF"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                    // /// Get Call Establish Time button
                    // (homeController.establishTimeIdGet != '')? Text("Call StartTime : ${  homeController.establishTimeIdGet}"):const SizedBox(),
                    // InkWell(
                    //   onTap: (){
                    //     homeController.establishTime();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.3,
                    //     alignment: Alignment.center,
                    //     child: const Text("Get Call Establish Time"),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                    // /// Get Call Duration button
                    // (homeController.callDurationIdGet != '')? Text("Call StartTime : ${  homeController.callDurationIdGet}"):const SizedBox(),
                    // InkWell(
                    //   onTap: (){
                    //     homeController.callDuration();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.3,
                    //     alignment: Alignment.center,
                    //     child: const Text("Get Call Duration"),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                    // /// Get Call Start Time button
                    // (homeController.startTimeIdGet != '')? Text("Call StartTime : ${  homeController.startTimeIdGet}"):const SizedBox(),
                    // InkWell(
                    //   onTap: (){
                    //     homeController.startTime();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.3,
                    //     alignment: Alignment.center,
                    //     child: const Text("Get Call Start Time"),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                    // /// Get Call End Time button
                    // (homeController.endTimeIdGet != '')? Text("Call StartTime : ${  homeController.endTimeIdGet}"):const SizedBox(),
                    // InkWell(
                    //   onTap: (){
                    //     homeController.endTime();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.3,
                    //     alignment: Alignment.center,
                    //     child: const Text("Get Call end Time"),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                    // /// Hang up call button
                    // InkWell(
                    //   onTap: (){
                    //     homeController.hangUpCall();
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: Get.width *0.3,
                    //     alignment: Alignment.center,
                    //     color: ColorConstatnts.red,
                    //     child: const Text("Hang up call",style: TextStyle(
                    //       color: ColorConstatnts.white,
                    //     ),),
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    //
                  ],
                ),
              ),
            );
          }),
    );
  }
}
