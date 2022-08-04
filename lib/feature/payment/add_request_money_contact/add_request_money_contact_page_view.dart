import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/payment/payment_beneficiary_empty_widget.dart';
import 'package:neo_bank/ui/molecules/payment/payment_beneficiary_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AddRequestMoneyContactPageView extends BasePageViewWidget<AddRequestMoneyContactViewModel> {
  final List<Beneficiary>? beneficiaries;

  AddRequestMoneyContactPageView(ProviderBase model, this.beneficiaries) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (StringUtils.isDirectionRTL(context)) {
                  if ((details.primaryVelocity!.isNegative)) {
                    ProviderScope.containerOf(context)
                        .read(paymentHomeViewModelProvider)
                        .appSwiperController
                        .previousPage(duration: Duration(milliseconds: 600), curve: Curves.linear);
                  }
                } else {
                  if (!(details.primaryVelocity!.isNegative)) {
                    ProviderScope.containerOf(context)
                        .read(paymentHomeViewModelProvider)
                        .appSwiperController
                        .previousPage(duration: Duration(milliseconds: 600), curve: Curves.linear);
                  }
                }
              },
              child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme.of(context).canvasColor,
                  margin: EdgeInsets.zero,
                  shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.only(top: 30, start: 27),
                            child: Text(S.of(context).requestMoney,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColorDark))),
                        beneficiaries!.length > 0
                            ? Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: GridView.builder(
                                      itemCount: 9,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, childAspectRatio: 0.8, mainAxisSpacing: 6),
                                      shrinkWrap: true,
                                      padding: EdgeInsetsDirectional.only(top: 22, end: 28, start: 27),
                                      itemBuilder: (context, index) {
                                        if (index >= beneficiaries!.length) {
                                          return PaymentBeneficiaryEmptyWidget();
                                        }
                                        return PaymentBeneficiaryWidget(
                                          onTap: () {
                                            Navigator.pushNamed(context, RoutePaths.RequestAmountFromContact,
                                                arguments: beneficiaries![index]);
                                          },
                                          transferEnum: TransferEnum.request,
                                          beneficiary: beneficiaries![index],
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(bottom: 29.0),
                                    child: Visibility(
                                      visible: beneficiaries!.length >= 9,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, RoutePaths.AllContact,
                                              arguments:
                                                  AllContactArguments(beneficiaryList: beneficiaries ?? []));
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 36,
                                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).accentColor,
                                                borderRadius: BorderRadius.circular(20)),
                                            child: Text(
                                              S.of(context).seeAllContacts,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context).accentTextTheme.bodyText1!.color),
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
                                    padding: EdgeInsets.only(top: 90),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: AppSvg.asset(AssetUtils.profileCircle),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        S.of(context).addRequestMoney,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12,
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
                  )),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                AppSvg.asset(AssetUtils.swipeUp),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    S.of(context).swipeToRequest,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.dark_gray_1),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
