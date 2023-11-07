import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_fligt_booking_page.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../main/navigation/route_paths.dart';
import 'rj_booking_page_view_model.dart';

class RjBookingPageView extends BasePageViewWidget<RjBookingPageViewModel> {
  RjBookingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondary,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(model.rjBookingPageArguments.url ?? '')),
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
                  clearSessionCache: false,
                  cacheMode: AndroidCacheMode.LOAD_DEFAULT,
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
                    clearCache: false,
                    allowUniversalAccessFromFileURLs: false,
                    cacheEnabled: true,
                    allowFileAccessFromFileURLs: false,
                    useShouldInterceptAjaxRequest: false),
              ),
              androidOnPermissionRequest: (controller, origin, resource) async {
                return PermissionRequestResponse(
                    resources: resource, action: PermissionRequestResponseAction.GRANT);
              },
              gestureRecognizers: [
                new Factory<OneSequenceGestureRecognizer>(
                  () => new EagerGestureRecognizer(),
                ),
              ].toSet(),
              onLoadStart: (controller, url) {},
              onLoadStop: (controller, url) async {
                if ((url?.path ?? '').toLowerCase().contains(AppConstantsUtils.RJRouteLink.toLowerCase())) {
                  String referenceNumber = url?.queryParameters['customerReference'] ?? '';
                  ProviderScope.containerOf(context).read(appViewModel).stopRefreshToken();
                  Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                      arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
                }

                /// FOR MOCK
                // String referenceNumber = "BLNKY239UKFW02";
                // if ((url?.path ?? '').contains('/main/start/')) {
                //   await Future.delayed(Duration(seconds: 2));
                //   Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                //       arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
                // }
              },
            ),
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
    );
  }
}
