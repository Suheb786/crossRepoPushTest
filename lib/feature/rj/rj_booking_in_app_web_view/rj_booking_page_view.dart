import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'rj_booking_page_view_model.dart';

class RjBookingPageView extends BasePageViewWidget<RjBookingPageViewModel> {
  RjBookingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    print(model.rjBookingPageArguments.url);
    return SafeArea(
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(model.rjBookingPageArguments.url ?? '')),
            onProgressChanged: (controller, progress) {
              model.setIndicatorProgressValue(progress / 100);
            },
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(useHybridComposition: true),
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
    );
  }
}
