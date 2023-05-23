import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_fligt_booking_page.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/string_utils.dart';
import 'rj_booking_page_view_model.dart';

class RjBookingPageView extends BasePageViewWidget<RjBookingPageViewModel> {
  RjBookingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        int sensitivity = 8;
        if (details.primaryVelocity! > sensitivity) {
          Navigator.pop(context);
        } else if (details.primaryVelocity! < -sensitivity) {}
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.rj_gray,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 57.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColor.white,
                      size: 12.h,
                    ),
                  ),
                  SizedBox(width: 50.w),
                  Text(
                    S.of(context).bookYourFlight,
                    style: TextStyle(
                        color: AppColor.white,
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 35.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      InAppWebView(
                        initialUrlRequest: URLRequest(url: Uri.parse(model.rjBookingPageArguments.url ?? '')),
                        onWebViewCreated: (controller) {
                          model.webViewController = controller;
                        },
                        onPageCommitVisible: (con, uri) {
                          debugPrint("url ${uri.toString()}");
                          // Navigator.pushNamed(context, RoutePaths.RjFlightBookingDetailPage);
                          //  con.goBack();
                        },
                        onProgressChanged: (controller, progress) {
                          model.setIndicatorProgressValue(progress / 100);
                        },
                        initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                            useHybridComposition: true,
                            clearSessionCache: true,
                            cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
                          ),
                          ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
                          crossPlatform: InAppWebViewOptions(
                            useShouldOverrideUrlLoading: true,
                            javaScriptEnabled: true,
                          ),
                        ),
                        androidOnPermissionRequest: (controller, origin, resource) async {
                          return PermissionRequestResponse(
                              resources: resource, action: PermissionRequestResponseAction.GRANT);
                        },
                        onLoadStart: (controller, url) {
                          debugPrint('-----onload start ---->${url}');
                        },
                        onLoadStop: (controller, url) {
                          debugPrint('-----onload stop ---->${url}');
                          debugPrint('-----onload path ---->${url?.path}');
                          if ((url?.path ?? '')
                              .contains('http://10.6.13.2:2186/RJFlightConfirmation/Index')) {
                            debugPrint('------RJ DETAILS----');
                            debugPrint('-----onload path ---->${url}');
                            String referenceNumber = url?.queryParameters['referenceNumber'] ?? '';
                            Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                                arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
                            debugPrint('------RJ DETAILS----');
                          }
                        },
                      ),
                      AppStreamBuilder<double>(
                        stream: model.indicatorProgressStream,
                        initialData: 0.0,
                        dataBuilder: (context, data) {
                          return (data ?? 0.0) < 1.0
                              ? LinearProgressIndicator(
                                  value: data,
                                )
                              : Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
