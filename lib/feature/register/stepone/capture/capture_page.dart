import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_model.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_view.dart';

class CapturePage extends BasePage<CaptureViewModel> {
  @override
  CapturePageState createState() => CapturePageState();
}

class CapturePageState extends BaseStatefulPage<CaptureViewModel, CapturePage> {
  @override
  ProviderBase provideBase() {
    return captureViewModelProvider;
  }

  @override
  void onModelReady(CaptureViewModel model) async {
    if (mounted) {
      List<CameraDescription> cameras = await availableCameras();
      model.initCamera(cameras);
    }
  }

  @override
  Widget buildView(BuildContext context, CaptureViewModel model) {
    return CaptureView(provideBase());
  }
}
