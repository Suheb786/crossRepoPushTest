import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayMyPrePaidBillsPage extends BasePage<PayMyPrePaidBillsPageViewModel> {
  final bool needBackButton;

  PayMyPrePaidBillsPage({this.needBackButton = false});

  @override
  PayMyPrePaidBillsPageState createState() => PayMyPrePaidBillsPageState();
}

class PayMyPrePaidBillsPageState
    extends BaseStatefulPage<PayMyPrePaidBillsPageViewModel, PayMyPrePaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payMyPrePaidBillsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  void onModelReady(PayMyPrePaidBillsPageViewModel model) {
    model.setShowBackButton(widget.needBackButton);
    super.onModelReady(model);
  }

  /*@override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0.w),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Text(
              S.of(context).manageAndPayMyBills,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 18.0.w),
              child: Container(
                width: 28.w,
              ),
            )
          ],
        ));
  }*/

  @override
  Widget buildView(BuildContext context, PayMyPrePaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayMyPrePaidBillsPageView(provideBase()));
  }
}
