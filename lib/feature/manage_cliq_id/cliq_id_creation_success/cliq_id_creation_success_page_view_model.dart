import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';

class CliqIdCreationSuccessPageViewModel extends BasePageViewModel {
  final CliqIdCreationSuccessPageArguments arguments;

  CliqIdCreationSuccessPageViewModel(this.arguments);

  void shareFiles(
    BuildContext context,
    String s,
  ) async {
    // final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      S.of(context).hereMyCliqDetails + '${s}' + S.of(context).getYourBlinkAccountTodayBlinkNow,
      subject: S.current.shareAccountInfo,
      // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    );
  }
}
