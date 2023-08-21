import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';

import 'camera_capture_page_view.dart';
import 'camera_capture_page_view_model.dart';

class CameraCapturePage extends BasePage<CameraCapturePageViewModel> {
  @override
  CameraCapturePageState createState() => CameraCapturePageState();
}

class CameraCapturePageState extends BaseStatefulPage<CameraCapturePageViewModel, CameraCapturePage> {
  @override
  ProviderBase provideBase() {
    return cameraCapturePageViewModelProvider;
  }

  @override
  void onModelReady(CameraCapturePageViewModel model) async {
    if (mounted) {
      model.cameras = await availableCameras();
      model.initCamera(model.cameras, 0);
    }
  }

  @override
  Widget buildView(BuildContext context, CameraCapturePageViewModel model) {
    return CameraCapturePageView(provideBase());
  }
}
