import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class ShareVoucherPageView extends BasePageViewWidget<ShareVoucherPageViewModel> {
  ShareVoucherPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 40.h, bottom: 56.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(16.w), topLeft: Radius.circular(16.w))),
              child: Column(
                children: [
                  Expanded(
                    child: InAppWebView(
                      initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(useHybridComposition: true),
                          ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
                          crossPlatform: InAppWebViewOptions(
                              transparentBackground: true,
                              javaScriptEnabled: true,
                              cacheEnabled: false,
                              clearCache: true)),
                      androidOnPermissionRequest: (controller, origin, resource) async {
                        return PermissionRequestResponse(
                            resources: resource, action: PermissionRequestResponseAction.GRANT);
                      },
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(model.argument?.voucherDetail?.lineItems.first.claimURL ?? "")),
                      onLoadStart: (controller, uri) {
                        //    model.updateLoader();
                      },
                      onLoadStop: (controller, uri) {
                        //   model.updateLoader();
                      },
                      onWebViewCreated: (controller) {
                        model.webViewController = controller;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// void _shareFiles(BuildContext context, File file) async {
//   final box = context.findRenderObject() as RenderBox?;
//   await Share.shareXFiles([XFile(file.path)],
//       subject: 'View Voucher', sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
// }
}
