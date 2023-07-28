import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:flutter_inappwebview/src/in_app_webview/in_app_webview_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../generated/l10n.dart';

class ShareVoucherPageViewModel extends BasePageViewModel {
  InAppWebViewController? webViewController;

  void shareFiles(
    BuildContext context, {
    required String s1,
    required String s2,
  }) async {
    // final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      S.of(context).hereMyCliqDetails + '${s1}' + S.of(context).getYourBlinkAccountTodayBlinkNow + "\n$s2",
      subject: S.current.shareAccountInfo,
      // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    );
  }
}
