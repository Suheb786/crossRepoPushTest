import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/di/splash/splash_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import 'evoucher_model.dart';
import 'buy_voucher/buy_evoucher_view.dart';
import 'my_voucher/my_voucher_view.dart';

class EvoucherPage extends BasePage<EvoucherViewModel> {
  @override
  EvoucherState createState() => EvoucherState();
}

class EvoucherState extends BaseStatefulPage<EvoucherViewModel, EvoucherPage>
    with TickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  @override
  ProviderBase provideBase() {
    return evoucherViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    matchTextDirection: true,
                    color: Theme.of(context).accentColor),
              ),
            ),
            Text(
              S.of(context).eVouchers,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).accentColor),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 18.0),
              child: Container(
                width: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 18,
                      height: 2,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      width: 14,
                      height: 2,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      width: 10,
                      height: 2,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, EvoucherViewModel model) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TabBar(
                isScrollable: true,
                indicatorColor: AppColor.brightRed,
                labelColor: AppColor.darkBlack,
                unselectedLabelColor: AppColor.gray4,
                indicatorWeight: 10.0,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 5.0, color: AppColor.brightRed),
                ),
                controller: _tabController,
                tabs: [
                  Text(
                    S.of(context).buyVouchers,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 2),
                    child: Text(
                      S.of(context).myVouchers,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(controller: _tabController, children: [
                BuyEvoucherView(provideBase()),
                MyVoucherView(provideBase())
              ]),
            ),
          )
        ],
      ),
    );
  }
}
