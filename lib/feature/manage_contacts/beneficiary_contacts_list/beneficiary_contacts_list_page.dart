import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'beneficiary_contacts_list_page_view_model.dart';
import 'beneficiary_request_money_list_tab/beneficiary_request_money_list_page_view.dart';
import 'beneficiary_send_money_list_tab/beneficiary_send_money_list_page_view.dart';

class BeneficiaryContactListPage extends BasePage<BeneficiaryContactListPageViewModel> {
  NavigationType navigationType;

  BeneficiaryContactListPage({this.navigationType = NavigationType.SEND_MONEY});

  @override
  BeneficiaryContactListPageState createState() => BeneficiaryContactListPageState();
}

class BeneficiaryContactListPageState
    extends BaseStatefulPage<BeneficiaryContactListPageViewModel, BeneficiaryContactListPage>
    with TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return beneficiaryContactListPageViewModelProvider;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late final _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.0.h),
      child: GestureDetector(
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
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
                      matchTextDirection: true,
                      color: widget.navigationType == NavigationType.REQUEST_MONEY
                          ? Theme.of(context).colorScheme.surfaceVariant
                          : Theme.of(context).colorScheme.secondary),
                ),
              ),
              Text(
                S.of(context).manageContacts,
                style: TextStyle(
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: widget.navigationType == NavigationType.REQUEST_MONEY
                        ? Theme.of(context).colorScheme.surfaceVariant
                        : Theme.of(context).colorScheme.secondary),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 18.0.w),
                child: Container(
                  width: 28.w,
                ),
              )
            ],
          )),
    );
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return getViewModel().navigationType == NavigationType.REQUEST_MONEY
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(BeneficiaryContactListPageViewModel model) {
    if (widget.navigationType == NavigationType.REQUEST_MONEY) {
      _tabController.index = 1;
    }

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            widget.navigationType = NavigationType.SEND_MONEY;
            model.navigationType = NavigationType.SEND_MONEY;
            model.changeBackgroundColor();

            break;
          case 1:
            widget.navigationType = NavigationType.REQUEST_MONEY;
            model.navigationType = NavigationType.REQUEST_MONEY;
            model.changeBackgroundColor();
        }
      }
    });
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, BeneficiaryContactListPageViewModel model) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 8.h,
            ),
            height: 4.h,
            width: 64.w,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(4.w)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7.w,
              child: TabBar(
                labelColor: Theme.of(context).colorScheme.surfaceVariant,
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 8.h, top: 27.h),
                padding: EdgeInsets.zero,
                unselectedLabelColor: Theme.of(context).colorScheme.onInverseSurface,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0.w,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3.0.w))),
                controller: _tabController,
                tabs: [
                  Text(
                    S.of(context).sendMoney,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    S.of(context).requestMoney.toTitleCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14.t, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              BeneficiarySendMoneyListPageView(provideBase()),
              BeneficiaryRequestMoneyListPageView(provideBase())
            ]),
          )
        ],
      ),
    );
  }
}
