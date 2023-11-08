import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_fligt_booking_page.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../main/navigation/route_paths.dart';
import 'rj_booking_page_view_model.dart';

class RjBookingPageView extends BasePageViewWidget<RjBookingPageViewModel> {
  RjBookingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
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
            AppStreamBuilder<bool>(
                stream: model.navigationToFlightBookingDetailStream,
                initialData: false,
                dataBuilder: (context, data) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: InAppWebView(
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(model.rjBookingPageArguments?.url ?? '')),
                        onWebViewCreated: (controller) {
                          model.webViewController = controller;
                        },
                        onPageCommitVisible: (con, uri) {},
                        onProgressChanged: (controller, progress) {
                          model.setIndicatorProgressValue(progress / 100);
                        },
                        initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                            useHybridComposition: true,
                            safeBrowsingEnabled: true,
                            clearSessionCache: true,
                            cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
                            allowFileAccess: false,
                            allowContentAccess: false,
                            geolocationEnabled: false,
                            mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
                          ),
                          ios: IOSInAppWebViewOptions(
                              allowsInlineMediaPlayback: true, isFraudulentWebsiteWarningEnabled: true),
                          crossPlatform: InAppWebViewOptions(
                              useShouldOverrideUrlLoading: true,
                              javaScriptEnabled: true,
                              useOnLoadResource: true,
                              clearCache: true,
                              allowUniversalAccessFromFileURLs: false,
                              cacheEnabled: false,
                              allowFileAccessFromFileURLs: false,
                              useShouldInterceptAjaxRequest: false),
                        ),
                        androidOnPermissionRequest: (controller, origin, resource) async {
                          return PermissionRequestResponse(
                              resources: resource, action: PermissionRequestResponseAction.GRANT);
                        },
                        onLoadStart: (controller, url) {},
                        onLoadStop: (controller, url) async {
                          debugPrint('-----onload stop ---->${url}');
                          debugPrint('-----onload path ---->${url?.path}');
                          if ((url?.path ?? '')
                                  .toLowerCase()
                                  .contains(AppConstantsUtils.RJRouteLink.toLowerCase()) &&
                              !model.isNavigationOnConfirmationView()) {
                            model.setConfirmationView();
                            String referenceNumber = url?.queryParameters['customerReference'] ?? '';
                            ProviderScope.containerOf(context).read(appViewModel).stopRefreshToken();
                            Navigator.pushNamed(context, RoutePaths.RjFlightBookingDetailPage,
                                    arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber))
                                .then((value) {
                              if (value != null && value is String) {
                                model.confirmationUrl = value;
                                model.webViewController
                                    ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(value)));
                              } else {
                                model.setPurchaseTicketView();
                              }
                            });
                          }

                          /// FOR MOCK
                          // String referenceNumber = "099cec27-0241-4daa-882c-cedd504273d9";
                          //   await Future.delayed(Duration(seconds: 2));
                          //   Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                          //       arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
                        },
                        shouldOverrideUrlLoading: (controller, navigation) async {
                          if (navigation.request.url?.scheme == "https") {
                            return NavigationActionPolicy.ALLOW;
                          } else {
                            return NavigationActionPolicy.CANCEL;
                          }
                        },
                      ),
                    ),
                  );
                }),
            AppStreamBuilder<bool>(
              stream: model.navigationToFlightBookingDetailStream,
              initialData: false,
              dataBuilder: (context, data) {
                return (data ?? false)
                    ? Container(
                        height: MediaQuery.of(context).size.height / 18,
                        margin: EdgeInsets.only(bottom: 0.h),
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: AppColor.very_light_grayish_blue))),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: IconButton(
                            padding: EdgeInsetsDirectional.only(end: 20.w),
                            icon: AppSvg.asset(AssetUtils.share,
                                color: Theme.of(context).colorScheme.onPrimaryContainer),
                            onPressed: () {
                              model.shareFiles(context, model.confirmationUrl ?? "");
                            },
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
