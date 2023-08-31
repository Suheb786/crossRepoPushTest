import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ShareVoucherPage extends BasePage<ShareVoucherPageViewModel> {
  final ShareVoucherPageArgument argument;

  ShareVoucherPage(this.argument);

  @override
  ShareVoucherPageState createState() => ShareVoucherPageState();
}

class ShareVoucherPageState extends BaseStatefulPage<ShareVoucherPageViewModel, ShareVoucherPage> {
  @override
  ProviderBase provideBase() {
    return shareVoucherViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0.w),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    height: 24.h,
                    width: 24.w,
                    matchTextDirection: true,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Text(
              S.of(context).viewVoucher,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.t),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 18.0.w),
              child: Container(
                width: 28.w,
              ),
            )
          ],
        ));
  }

  @override
  Widget buildView(BuildContext context, ShareVoucherPageViewModel model) {
    return ShareVoucherPageView(provideBase());
  }
}

class ShareVoucherPageArgument {
  final VoucherDetail? voucherDetail;

  ShareVoucherPageArgument(this.voucherDetail);
}
