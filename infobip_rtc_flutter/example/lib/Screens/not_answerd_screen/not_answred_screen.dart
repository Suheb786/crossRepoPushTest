import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infobipplugin_example/Screens/home_screen/home_screen.dart';

class NotAnsweredScreen extends StatelessWidget {
  const NotAnsweredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(HomeScreen());
        return true;
      },
      child: Scaffold(
        body: Container(
            width: Get.width,
            height: Get.height,
            alignment: Alignment.center,
            child: Column(
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
                        Get.offAll(HomeScreen());
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                      )),
                ),
                const Spacer(),
                const Text("Not Answerd"),
                const Text("Agent no available"),
                const Spacer(),
              ],
            )),
      ),
    );
  }
}
