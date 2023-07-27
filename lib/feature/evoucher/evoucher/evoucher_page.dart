import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/evoucher/buy_voucher/buy_evoucher_view.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'evoucher_view_model.dart';
import 'my_voucher_history/my_voucher_history_view.dart';

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
  void onModelReady(EvoucherViewModel model) {
    if (!_tabController.hasListeners) {
      _tabController.addListener(() {
        if (model.tabChangeNotifier.value != _tabController.index)
          model.tabChangeNotifier.value = _tabController.index;
        model.voucherItemFilterResponseSubject.safeAdd(Resource.success(data: model.filterList));
        model.voucherCategoriesResponseSubject.safeAdd(Resource.success(data: model.categoriesList));
      });
    }
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    final provider = ProviderScope.containerOf(context).read(
      evoucherViewModelProvider,
    );

    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85.h),
        child: Padding(
          padding: EdgeInsets.only(top: 52.0.h),
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
                S.of(context).eVouchers,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              ValueListenableBuilder<int>(
                  valueListenable: provider.tabChangeNotifier,
                  builder: (context, int value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(end: 18.0),
                      child: AnimatedOpacity(
                        opacity: value == 0 ? 1.0 : 0.0,
                        duration: Duration(microseconds: 500),
                        child: InkWell(
                          onTap: () {
                            EVouchersFilterDialog.show(context,
                                title: S.of(context).filterVouchers,
                                categoriesList: provider.categoriesList, onSelected: (value) {
                              provider.evoucherFilterOption = value.filterOption;
                              provider.getVoucherItemFilter(
                                  category: value.categryId,
                                  region: value.region,
                                  maxValue: double.parse(value.maxValue),
                                  minValue: double.parse(value.minValue),
                                  searchText: "");

                              Navigator.pop(context);
                            }, onDismissed: () {
                              Navigator.pop(context);
                            });
                          },
                          child: AppSvg.asset(AssetUtils.filterMenu),
                        ),
                      ),
                    );
                  })
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
      margin: const EdgeInsetsDirectional.only(top: 34),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TabBar(
                isScrollable: true,
                indicatorWeight: 10.0,
                controller: _tabController,
                tabs: [
                  Text(
                    S.of(context).buyVouchers,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 2),
                    child: Text(
                      S.of(context).history,
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
                  children: [BuyEvoucherView(provideBase()), MyVoucherHistoryView(provideBase())]),
            ),
          )
        ],
      ),
    );
  }
}
