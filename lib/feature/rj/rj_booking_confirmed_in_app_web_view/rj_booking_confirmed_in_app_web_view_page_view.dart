import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:share_plus/share_plus.dart';

import '../../../base/base_page.dart';
import '../../../generated/l10n.dart';
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
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(model.arguments.url)),
                    onWebViewCreated: (controller) {},
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
                          cacheEnabled: true,
                          allowFileAccessFromFileURLs: false,
                          useShouldInterceptAjaxRequest: false),
                    ),
                    androidOnPermissionRequest: (controller, origin, resource) async {
                      return PermissionRequestResponse(
                          resources: resource, action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading: (controller, navigation) async {
                      if (navigation.request.url?.scheme == "https") {
                        return NavigationActionPolicy.ALLOW;
                      } else {
                        return NavigationActionPolicy.CANCEL;
                      }
                    },
                    onLoadStart: (controller, url) async {},
                    onLoadStop: (controller, url) {},
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
          ),
          Container(
            height: MediaQuery.of(context).size.height / 18,
            decoration:
                BoxDecoration(border: Border(top: BorderSide(color: AppColor.very_light_grayish_blue))),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: EdgeInsetsDirectional.only(end: 20.w),
                icon: AppSvg.asset(AssetUtils.share, color: Theme.of(context).colorScheme.onPrimaryContainer),
                onPressed: () {
                  _shareFiles(context, model.arguments.url);
                },
              ),
            ),
          ),
          SizedBox(
            height: 45.h,
          )
        ],
      ),
    );
  }

  void _shareFiles(BuildContext context, String url) async {
    await Share.share(
      url,
      subject: S.of(context).confirmationURL,
    );
  }
}
