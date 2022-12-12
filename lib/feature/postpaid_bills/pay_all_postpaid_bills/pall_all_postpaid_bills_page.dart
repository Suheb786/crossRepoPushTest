import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayAllPostPaidBillsPage extends BasePage<PayAllPostPaidBillsPageViewModel> {
  final PayAllPostPaidBillsPageArguments arguments;

  PayAllPostPaidBillsPage(this.arguments);

  @override
  PayAllPostPaidBillsPageState createState() => PayAllPostPaidBillsPageState();
}

class PayAllPostPaidBillsPageState
    extends BaseStatefulPage<PayAllPostPaidBillsPageViewModel, PayAllPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payAllPostPaidBillsPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0.w),
                child: Visibility(
                  visible: widget.arguments.paidBillsPayTypeOptionEnum ==
                          PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                      ? true
                      : false,
                  child: AppSvg.asset(AssetUtils.leftArrow,
                      matchTextDirection: true, color: Theme.of(context).accentColor),
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                    ? S.of(context).payAllBills
                    : S.of(context).myBills,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 18.0.w),
              child: Container(
                width: 28.w,
              ),
            ),
            Visibility(
              visible:
                  widget.arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                      ? false
                      : true,
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 24.0.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.NewBillsPage);
                    AppConstantsUtils.PRE_PAID_FLOW = false;
                    AppConstantsUtils.POST_PAID_FLOW = true;
                    AppConstantsUtils.IS_NEW_PAYMENT = true;
                  },
                  child: AppSvg.asset(
                    AssetUtils.plusIcon,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget buildView(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayAllPostPaidBillsPageView(provideBase()));
  }
}

class PayAllPostPaidBillsPageArguments {
  final PostPaidBillsPayTypeOptionEnum paidBillsPayTypeOptionEnum;

  PayAllPostPaidBillsPageArguments(this.paidBillsPayTypeOptionEnum);
}
