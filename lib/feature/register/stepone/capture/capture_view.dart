import 'package:camera/camera.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
                if (isImageUploaded.status == Status.SUCCESS) {
                  Navigator.of(context).pop(true);
                } else if (isImageUploaded.status == Status.ERROR) {
                  model.showToastWithError(isImageUploaded.appError!);
                  model.cameraController!.resumePreview();
                  if (isImageUploaded.appError?.type == ErrorType.ID_VERIFICATION_FAILED) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
                  }
                } else if (isImageUploaded.status == Status.LOADING) {
                  model.cameraController!.pausePreview();
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
                            // ColorFiltered(
                            //   colorFilter: ColorFilter.mode(
                            //       AppColor.black.withOpacity(0.8),
                            //       BlendMode.srcOut),
                            //   child: Stack(
                            //     children: [
                            //       Container(
                            //         decoration: BoxDecoration(
                            //           color: Colors.transparent,
                            //         ),
                            //         child: Align(
                            //           alignment: Alignment.center,
                            //           child: Container(
                            //             height: 373,
                            //             width: 373,
                            //             decoration: BoxDecoration(
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(300),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            PositionedDirectional(
                              end: 16.w,
                              top: 40.h,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Container(
                            //     height: 373,
                            //     width: 373,
                            //     decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: AppColor.white, width: 2),
                            //       borderRadius: BorderRadius.circular(300),
                            //     ),
                            //   ),
                            // ),
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
                                    Text(
                                      S.of(context).selfieCheck,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 20.t,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      S.of(context).makeSureYourFaceFitsTheFrame,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    SizedBox(height: 8.h),
                                    InkWell(
                                        onTap: () {
                                          model.takePicture();
                                        },
                                        child: AppSvg.asset(AssetUtils.capture)),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ),
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
