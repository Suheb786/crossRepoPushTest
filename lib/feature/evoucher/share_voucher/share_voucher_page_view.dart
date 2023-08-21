import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/src/in_app_webview/in_app_webview.dart';
import 'package:flutter_inappwebview/src/types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ShareVoucherPageView extends BasePageViewWidget<ShareVoucherPageViewModel> {
  ShareVoucherPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Container(
        padding: EdgeInsetsDirectional.only(top: 52.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 48.0.h),
              child: Center(
                child: Text(
                  S.of(context).viewVoucher,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.t),
                ),
              ),
            ),
            SizedBox(height: 35.h),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 48.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 1.7.h,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1.w)),
                        width: double.infinity,
                        child: InAppWebView(
                          initialUrlRequest: URLRequest(
                              url: Uri.parse(model.argument?.voucherDetail?.lineItems.first.claimURL ?? "")),
                          // onWebViewCreated: (controller) {
                          //   model.webViewController = controller;
                          // },
                        )),
                    InkWell(
                      onTap: () async {},
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 24.h),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!)),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).shareVoucher,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w600),
                              ),
                              AppSvg.asset(AssetUtils.share, color: Theme.of(context).primaryColorDark)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 36.h),
                      child: InkWell(
                        onTap: () {},
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            S.of(context).back,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontSize: 14.t,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// void _shareFiles(BuildContext context, File file) async {
//   final box = context.findRenderObject() as RenderBox?;
//   await Share.shareXFiles([XFile(file.path)],
//       subject: 'View Voucher', sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
// }
}
