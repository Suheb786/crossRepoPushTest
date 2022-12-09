import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_fligt_booking_page.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';

import '../../../main/navigation/route_paths.dart';
import 'rj_booking_page_view_model.dart';

class RjBookingPageView extends BasePageViewWidget<RjBookingPageViewModel> {
  RjBookingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(model.rjBookingPageArguments.url)),
          onWebViewCreated: (controller) {
            model.webViewController = controller;
          },
          onPageCommitVisible: (con, uri) async {
            debugPrint("url ${uri.toString()}");
            // await Future.delayed(Duration(seconds:50 ));
            // model.loadNewUrl();
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
          onLoadStop: (controller, url) async {
            debugPrint('-----onload stop ---->${url}');
            debugPrint('-----onload path ---->${url?.path}');
            if (model.rjBookingPageArguments.webViewRoute == WebViewRoute.bookingDialog) {
              if ((url?.path ?? '').contains(AppConstantsUtils.RJRouteLink)) {
                debugPrint('------RJ DETAILS----');
                debugPrint('-----onload path ---->${url}');
                String referenceNumber = url?.queryParameters['customerReferece'] ?? '';
                //await Future.delayed(Duration(seconds: 40));
                Navigator.pushReplacementNamed(context, RoutePaths.RjFlightBookingDetailPage,
                    arguments: RJFlightDetailsPageArguments(referenceNumber: referenceNumber));
                debugPrint('------RJ DETAILS----');
              }
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
    );
  }
}
