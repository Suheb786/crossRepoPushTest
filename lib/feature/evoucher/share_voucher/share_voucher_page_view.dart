import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ShareVoucherPageView extends BasePageViewWidget<ShareVoucherPageViewModel> {
  ShareVoucherPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Container(
        padding: EdgeInsets.only(top: 52),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Center(
                child: Text(
                  S.of(context).viewVoucher,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                child: Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height / 2.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1)),
                      width: double.infinity,
                      child: Image.asset(
                        AssetUtils.shareVoucher,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () async {},
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 24),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!)),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).shareVoucher,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              AppSvg.asset(AssetUtils.share, color: Theme.of(context).primaryColorDark)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: InkWell(
                        onTap: () {
                          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.EVoucherMainPage));
                        },
                        child: Container(
                          height: 57,
                          width: 57,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge!.color!),
                          child: Center(
                            child:
                                AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
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
