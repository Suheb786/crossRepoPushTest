import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class CaptureView extends BasePageViewWidget<CaptureViewModel> {
  CaptureView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CaptureViewModel model) {
    return AppStreamBuilder<bool>(
      stream: model.cameraControllerInitializerStream,
      initialData: false,
      dataBuilder: (context, data) {
        if (!data!) {
          return Container();
        } else {
          return AppStreamBuilder<Resource<bool>>(
              initialData: Resource.none(),
              stream: model.uploadImageResponseStream,
              onData: (isImageUploaded) {
                // Navigator.pop(context, true);

                /// TODO:: NEED TO HANDLE AFTER API UPDATES
                if (isImageUploaded.status == Status.SUCCESS) {
                  Navigator.pop(context, true);
                } else if (isImageUploaded.status == Status.ERROR) {
                  model.showToastWithError(isImageUploaded.appError!);
                }
              },
              dataBuilder: (context, data) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(model.cameraController!,
                      child: Stack(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                AppColor.black.withOpacity(0.8),
                                BlendMode.srcOut),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 373,
                                      width: 263,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(300),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 40,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                icon: Icon(Icons.close)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 381,
                              width: 271,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.white, width: 2),
                                borderRadius: BorderRadius.circular(300),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: IconButton(
                                onPressed: () async {
                                  model.takePicture();
                                },
                                icon: Icon(
                                  Icons.camera,
                                  size: 40,
                                )),
                          ),
                        ],
                      )),
                );
              });
        }
      },
    );
  }
}
