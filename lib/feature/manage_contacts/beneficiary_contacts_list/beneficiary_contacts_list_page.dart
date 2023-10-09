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

import '../../../utils/color_utils.dart';
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
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return widget.navigationType == NavigationType.REQUEST_MONEY
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  bool? resizeToAvoidBottomInset() {
    return false;
  }

  @override
  void onModelReady(BeneficiaryContactListPageViewModel model) {
    if (widget.navigationType == NavigationType.REQUEST_MONEY) {
      _tabController.index = 1;
    }
    model.navigationType = widget.navigationType;

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
            break;
        }
      }
    });
    super.onModelReady(model);
  }

  Widget? _sendMoneyBeneficiary;
  Widget? _requestMoneyBeneficiary;

  @override
  Widget buildView(BuildContext context, BeneficiaryContactListPageViewModel model) {
    if (_sendMoneyBeneficiary == null) {
      _sendMoneyBeneficiary = BeneficiarySendMoneyListPageView(provideBase());
    }
    if (_requestMoneyBeneficiary == null) {
      _requestMoneyBeneficiary = BeneficiaryRequestMoneyListPageView(provideBase());
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 52.0.h, bottom: 0.h),
          height: 80.h,
          child: Text(
            S.of(context).manageContacts,
            textAlign: TextAlign.center,
            softWrap: false,
            style: TextStyle(
                fontSize: 14.t,
                fontWeight: FontWeight.w600,
                color: model.navigationType == NavigationType.REQUEST_MONEY
                    ? Theme.of(context).colorScheme.shadow
                    : Theme.of(context).colorScheme.secondary),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 24.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
                child: Column(
                  children: [
                    SizedBox(height: 47.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: TabBar(
                          labelColor: Theme.of(context).colorScheme.surfaceVariant,
                          isScrollable: true,
                          labelPadding: EdgeInsets.only(
                            left: 24.w,
                            right: 24.w,
                            bottom: 8.h,
                          ),
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
                        _sendMoneyBeneficiary!,
                        _requestMoneyBeneficiary!,
                      ]),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    // ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateBackToMainPage();
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
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                        ]),
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
