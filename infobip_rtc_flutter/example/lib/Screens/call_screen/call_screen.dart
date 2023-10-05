import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infobipplugin_example/Screens/home_screen/home_screen.dart';
import 'package:infobipplugin_example/Utils/colorconstatnt.dart';

import 'call_controller.dart';

class CallScreen extends StatelessWidget {
  CallScreen({Key? key}) : super(key: key);
  CallController callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        callController.hangup = false;
        callController.startTimeIdGet = '';
        callController.endTimeIdGet = '';
        callController.callDurationIdGet = '';
        callController.establishTimeIdGet = '';
        callController.status = "";
        callController.speaker = false;
        callController.mute = false;
        callController.hangup = false;
        callController.update(['hang']);
        Get.offAll(HomeScreen());
        return true;
      },
      child: Scaffold(
        body: GetBuilder<CallController>(
            id: "hang",
            builder: (con) {
              return Container(
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: (callController.hangup == false)
                    ? Column(
                        children: [
                          const Spacer(),
                          Container(
                            height: 200,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                            child: Container(
                              height: 180,
                              width: 180,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                              child: const Icon(
                                Icons.person,
                                size: 100,
                                color: ColorConstatnts.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          (callController.status == "onHangup-REQUEST_TIMEOUT" ||
                                  callController.status == "onHangup-NORMAL_HANGUP")
                              ? const Text("Call Ended")
                              : (callController.status == "onEstablished")
                                  ? const Text("Running.....")
                                  : const Text("Ringing"),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// mute/unmute button
                              InkWell(
                                onTap: () {
                                  callController.muteUnmute();
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  child: (callController.mute == false)
                                      ? const Icon(Icons.mic)
                                      : const Icon(Icons.mic_off),
                                ),
                              ),

                              /// Speaker ON/OFF button
                              InkWell(
                                onTap: () {
                                  callController.speakerPhone();
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  child: (callController.speaker)
                                      ? const Icon(Icons.volume_up)
                                      : const Icon(Icons.volume_off),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          /// Hang up call button
                          InkWell(
                            onTap: () async {
                              await callController.hangUpCall();
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.3,
                              alignment: Alignment.center,
                              color: ColorConstatnts.red,
                              child: const Text(
                                "Hang up call",
                                style: TextStyle(
                                  color: ColorConstatnts.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: Get.width,
                            height: 50,
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  callController.hangup = false;
                                  callController.startTimeIdGet = '';
                                  callController.endTimeIdGet = '';
                                  callController.callDurationIdGet = '';
                                  callController.establishTimeIdGet = '';
                                  callController.status = "";
                                  callController.speaker = false;
                                  callController.mute = false;
                                  callController.hangup = false;
                                  callController.update(['hang']);

                                  Get.offAll(HomeScreen());
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20,
                                )),
                          ),
                          const Spacer(),
                          Text("Establish Time: ${callController.establishTimeIdGet}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Call Duration: ${callController.callDurationIdGet}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Call Start Time: ${callController.startTimeIdGet}"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Call End Time: ${callController.endTimeIdGet}"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Spacer(),
                        ],
                      ),
              );
            }),
      ),
    );
  }
}
