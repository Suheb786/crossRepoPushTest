import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_page.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/payment/payment_beneficiary_empty_widget.dart';
import 'package:neo_bank/ui/molecules/payment/payment_beneficiary_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/device_size_helper.dart';
import '../payment_home/payment_home_view_model.dart';

class AddRequestMoneyContactPageView extends BasePageViewWidget<AddRequestMoneyContactViewModel> {
  final List<Beneficiary>? beneficiaries;

  AddRequestMoneyContactPageView(ProviderBase model, this.beneficiaries) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        color: Theme.of(context).canvasColor,
        margin: EdgeInsets.zero,
        shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
        child: LayoutBuilder(builder: (BuildContext p0, p1) {
          double itemBetweenSpacing = 6.w;
          double itemTopBottomSpacing = 68.h + 48.h;

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.only(top: 24.0.h, start: 24.0.w, end: 24.w),
                    child: Row(
                      children: [
                        AppSvg.asset(AssetUtils.blueStar, color: Theme.of(context).primaryColorDark),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          child: Text(S.of(context).requestMoneyFrom,
                              style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12.0.t, color: Theme.of(context).primaryColorDark)),
                        ),
                        Visibility(
                          visible: (ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.dashboardFeatures?.manageContactEnabled ?? false),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutePaths.AddContactsIBANManageContactsPage,
                                  arguments: AddBeneficiaryPageArguments(navigationType: NavigationType.REQUEST_MONEY, isFromContactCard: true));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              child: AppSvg.asset(AssetUtils.plusIcon, color: Theme.of(context).colorScheme.onSecondaryContainer, width: 16.w, height: 16.h),
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Theme.of(context).primaryColorDark.withOpacity(0.15), blurRadius: 8.96, offset: Offset(0, 4.48))]),
                            ),
                          ),
                        )
                      ],
                    )),
                (beneficiaries ?? []).length > 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: GridView.builder(
                              itemCount: 9,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: ((p1.maxWidth - itemBetweenSpacing) / (p1.maxHeight - itemTopBottomSpacing)), mainAxisSpacing: 2),
                              shrinkWrap: true,
                              padding: EdgeInsetsDirectional.only(top: 22.0.h, end: 27.0.w, start: 27.0.w),
                              itemBuilder: (context, index) {
                                if (index >= beneficiaries!.length) {
                                  return PaymentBeneficiaryEmptyWidget();
                                }
                                return PaymentBeneficiaryWidget(
                                  onTap: () {
                                    // Navigator.pushNamed(context, RoutePaths.RequestAmountFromContact, arguments: beneficiaries![index]);
                                    ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).setSelectedBenificiary(beneficiaries![index]);
                                    ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animatePage(AnimatedPage.REQUEST_FROM_SPECIFIC_PERSON);
                                  },
                                  transferEnum: TransferEnum.request,
                                  beneficiary: beneficiaries![index],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: DeviceSizeHelper.isBigDevice ? 6.h : 0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(bottom: 16.0.h),
                            child: Visibility(
                              visible: (ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.dashboardFeatures?.manageContactEnabled ?? false),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutePaths.BeneficiaryContactsList, arguments: NavigationType.REQUEST_MONEY);
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 14.0.w),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                      borderRadius: BorderRadius.circular(20.w),
                                      border: Border.all(color: AppColor.lightYellowColor, width: 1),
                                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 3))],
                                    ),
                                    child: Text(
                                      S.of(context).seeAllContacts,
                                      style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 90.0.h),
                            child: Align(
                              alignment: Alignment.center,
                              child: AppSvg.asset(AssetUtils.profileCircle, height: 96.0.h, width: 96.0.w),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 12.0.h, start: 24.0.w, end: 24.0.w),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                S.of(context).addRequestMoney,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 12.0.t,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          );
        }));
  }
}
