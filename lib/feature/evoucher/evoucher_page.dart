import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/buy_voucher/buy_evoucher_view.dart';
import 'package:neo_bank/feature/evoucher/my_voucher/my_voucher_view.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import 'evoucher_model.dart';

class EvoucherPage extends BasePage<EvoucherViewModel> {
  @override
  EvoucherState createState() => EvoucherState();
}

class EvoucherState extends BaseStatefulPage<EvoucherViewModel, EvoucherPage> with TickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  ProviderBase provideBase() {
    return evoucherViewModelProvider;
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85),
        child: Padding(
          padding: const EdgeInsets.only(top: 56.0),
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
                      matchTextDirection: true, color: Theme.of(context).accentColor),
                ),
              ),
              Text(
                S.of(context).eVouchers,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 18.0),
                child: InkWell(
                  onTap: () {
                    EVouchersFilterDialog.show(context, title: S.of(context).filterVouchers,
                        onSelected: (value) {
                      Navigator.pop(context);
                    }, onDismissed: () {
                      Navigator.pop(context);
                    });
                  },
                  child: AppSvg.asset(AssetUtils.filterMenu),
                ),
              )
            ],
          ),
        ));
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, EvoucherViewModel model) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 34),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
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
                  borderSide: BorderSide(width: 4.0, color: AppColor.brightRed),
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
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                  controller: _tabController,
                  children: [BuyEvoucherView(provideBase()), MyVoucherView(provideBase())]),
            ),
          )
        ],
      ),
    );
  }
}
