import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'camera_capture_page_view_model.dart';

class CameraCapturePageView extends BasePageViewWidget<CameraCapturePageViewModel> {
  CameraCapturePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CameraCapturePageViewModel model) {
    return AppStreamBuilder<bool>(
      stream: model.cameraControllerInitializerStream,
      initialData: false,
      dataBuilder: (context, data) {
        if (!data!) {
          return Container();
        } else {
          return AppStreamBuilder<String>(
              initialData: "",
              stream: model.filePathResponseStream,
              onData: (filePath) {
                if (filePath.isNotEmpty) {
                  Navigator.of(context).pop(filePath);
                }
              },
              dataBuilder: (context, data) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: AspectRatio(
                    aspectRatio: model.cameraController!.value.aspectRatio,
                    child: CameraPreview(model.cameraController!,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              start: 0,
                              end: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (model.cameras.length > 1) {
                                                switch (model.selectedCameraIndex) {
                                                  case 0:
                                                    model.selectedCameraIndex = 1;
                                                    return model.initCamera(
                                                        model.cameras, model.selectedCameraIndex);

                                                  case 1:
                                                    model.selectedCameraIndex = 0;
                                                    return model.initCamera(
                                                        model.cameras, model.selectedCameraIndex);

                                                  default:
                                                    return model.initCamera(model.cameras, 0);
                                                }
                                              }
                                            },
                                            icon: Icon(
                                              Icons.cameraswitch,
                                              size: 30.w,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            )),
                                        InkWell(
                                            onTap: () {
                                              model.takePicture();
                                            },
                                            child: AppSvg.asset(AssetUtils.capture)),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop("");
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 30.w,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                );
              });
        }
      },
    );
  }
}
