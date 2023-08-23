import 'package:domain/constants/enum/evoucher_landing_page_navigation_type_enum.dart';
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
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/color_utils.dart';
import 'evoucher_view_model.dart';
import 'my_voucher_history/my_voucher_history_view.dart';

class EvoucherPage extends BasePage<EvoucherViewModel> {
  EvoucherPageArguments arguments;

  EvoucherPage(this.arguments);

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
    if (widget.arguments.navigationType == EvoucherLandingPageNavigationType.PURCHASE_BY_CATEGORY) {
      _tabController.index = 1;
      //  model.tabChangeNotifier.value =1;
    }

    _tabController.addListener(() {
      if (model.tabChangeNotifier.value != _tabController.index) model.tabChangeNotifier.value = _tabController.index;
      model.voucherItemFilterResponseSubject.safeAdd(Resource.success(data: model.filterList));
      model.voucherCategoriesResponseSubject.safeAdd(Resource.success(data: model.categoriesList));
    });

    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, EvoucherViewModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 52.0.h, bottom: 0.h),
          height: 80.h,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Text(
                S.of(context).eVouchers,
                textAlign: TextAlign.center,
                softWrap: false,
                style: TextStyle(fontSize: 14.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
              ),
              PositionedDirectional(
                end: 18.0.w,
                child: ValueListenableBuilder<int>(
                    valueListenable: model.tabChangeNotifier,
                    builder: (context, int value, Widget? child) {
                      return AnimatedOpacity(
                        opacity: value == 0 ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 100),
                        child: InkWell(
                          onTap: () {
                            if (model.categoriesList.isNotEmpty)
                              EVouchersFilterDialog.show(context, title: S.of(context).filterVouchers, categoriesList: model.categoriesList, onSelected: (value) {
                                model.evoucherFilterOption = value.filterOption;
                                model.getVoucherItemFilter(
                                    category: value.categryId, region: value.region, maxValue: double.parse(value.maxValue), minValue: double.parse(value.minValue), searchText: model.buyVoucherSearchController.text);

                                Navigator.pop(context);
                              }, onDismissed: () {
                                Navigator.pop(context);
                              });
                          },
                          child: AppSvg.asset(AssetUtils.filterMenu, height: 26),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 24.h),
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
                child: Column(
                  children: [
                    SizedBox(height: 47.h),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TabBar(
                          isScrollable: true,
                          indicatorWeight: 8.0.h,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Theme.of(context).colorScheme.onInverseSurface,
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 4.0.w,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(3.0.w))),
                          tabs: [
                            Text(
                              S.of(context).buyVouchers,
                              style: TextStyle(fontSize: 14.t, fontWeight: FontWeight.w600, fontFamily: StringUtils.appFont),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 2.w),
                              child: Text(
                                S.of(context).history,
                                style: TextStyle(fontSize: 14.t, fontWeight: FontWeight.w600, fontFamily: StringUtils.appFont),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(controller: _tabController, children: [BuyEvoucherView(provideBase()), MyVoucherHistoryView(provideBase())]),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    // ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateBackToMainPage();

                    model.buyVoucherSearchController.clear();
                    model.myVoucherHistorySearchController
                        .clear(); // user enter search text then keyboard open and navigated back without searching than api should not call bcz api is call on onFocus

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))]),
                    child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EvoucherPageArguments {
  EvoucherLandingPageNavigationType navigationType;

  EvoucherPageArguments(this.navigationType);
}
