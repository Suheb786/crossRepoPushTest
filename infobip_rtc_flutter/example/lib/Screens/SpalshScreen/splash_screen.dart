import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infobipplugin_example/Screens/home_screen/home_screen.dart';
import 'package:infobipplugin_example/Utils/asstImages.dart';
import 'package:infobipplugin_example/Utils/colorconstatnt.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Image.asset(
          AssetImages.infoBipLogo,
          color: ColorConstatnts.deepPurple,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
