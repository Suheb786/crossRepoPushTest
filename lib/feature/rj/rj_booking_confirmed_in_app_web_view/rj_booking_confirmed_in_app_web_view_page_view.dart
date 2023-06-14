import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

import '../../../base/base_page.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';

class RJBookingConfirmedInAppWebViewPageView
    extends BasePageViewWidget<RJBookingConfirmedInAppWebViewPageViewModel> {
  RJBookingConfirmedInAppWebViewPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse("")),
                    onWebViewCreated: (controller) {},
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
                      if ((url?.path ?? '').contains('http://10.6.13.2:2186/RJFlightConfirmation/Index')) {
                        debugPrint('------RJ DETAILS----');
                        debugPrint('-----onload path ---->${url}');
                        String referenceNumber = url?.queryParameters['referenceNumber'] ?? '';
                        // Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                        //     arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
                        debugPrint('------RJ DETAILS----');
                      }

                      // //Todo need to remove from code
                      String referenceNumber = url?.queryParameters['referenceNumber'] ?? '';

                      // Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                      //     arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
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
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 18,
              decoration:
                  BoxDecoration(border: Border(top: BorderSide(color: AppColor.very_light_grayish_blue))),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: EdgeInsetsDirectional.only(end: 20.w),
                  icon: AppSvg.asset(AssetUtils.share, color: AppColor.very_light_blue),
                  onPressed: () {
                    _shareFiles(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
            )
          ],
        ),
      ),
    );
  }

  void _shareFiles(
    BuildContext context,
    // GetDashboardDataContent? cardData,
  ) async {
    // final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      '',
      subject: 'URL',
    );
  }
}
