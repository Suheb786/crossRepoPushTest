import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/payment/payment_beneficiary_empty_widget.dart';
import 'package:neo_bank/ui/molecules/payment/payment_beneficiary_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class AddRequestMoneyContactPageView extends BasePageViewWidget<AddRequestMoneyContactViewModel> {
  AddRequestMoneyContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: AspectRatio(
              aspectRatio: 0.62,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (!(details.primaryVelocity!.isNegative)) {
                    ProviderScope
                        .containerOf(context)
                        .read(paymentHomeViewModelProvider)
                        .pageController
                        .previous();
                  }
                },
                child: Card(
                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme
                      .of(context)
                      .canvasColor,
                  margin: EdgeInsets.zero,
                  shadowColor: Theme
                      .of(context)
                      .primaryColorDark
                      .withOpacity(0.32),
                  child: AppStreamBuilder<Resource<GetBeneficiaryListResponse>>(
                      stream: ProviderScope
                          .containerOf(context)
                          .read(paymentHomeViewModelProvider)
                          .beneficiaryResponse,
                      initialData: Resource.none(),
                      dataBuilder: (context, beneficiaryResponse) {
                        List<Beneficiary> beneficiaries = [];
                        beneficiaryResponse!.data!.beneficiaryList!
                            .forEach((element) {
                          if (element.beneType == "RTP") {
                            beneficiaries.add(element);
                          }
                        });
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 30, left: 27),
                                    child: Text(S.of(context).requestMoney,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12))),
                                beneficiaries.length > 0
                                    ? Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    GridView.builder(
                                      itemCount: 9,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.8,
                                          mainAxisSpacing: 6),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          top: 22, right: 28, left: 27),
                                      itemBuilder: (context, index) {
                                        if (index >=
                                                  beneficiaries.length) {
                                                return PaymentBeneficiaryEmptyWidget();
                                              }
                                              if (beneficiaryResponse
                                                      .data!
                                                      .beneficiaryList![index]
                                                      .beneType ==
                                                  "RTP") {
                                                return PaymentBeneficiaryWidget(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutePaths
                                                            .RequestAmountFromContact,
                                                        arguments:
                                                            beneficiaries[
                                                                index]);
                                                  },
                                                  transferEnum:
                                                      TransferEnum.request,
                                                  beneficiary:
                                                      beneficiaries[index],
                                                );
                                              } else {
                                                return PaymentBeneficiaryEmptyWidget();
                                              }
                                            },
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 29.0),
                                      child: Visibility(
                                        visible: beneficiaryResponse
                                            .data!
                                            .beneficiaryList!
                                            .length >=
                                            9,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 36,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 14),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20)),
                                            child: Text(
                                              S
                                                  .of(context)
                                                  .seeAllContacts,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .accentTextTheme
                                                      .bodyText1!
                                                      .color),
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
                                        child: InkWell(
                                            onTap: () {
                                              model
                                                  .updateAddContactClickedValue(
                                                  true);
                                            },
                                            child: AppSvg.asset(AssetUtils
                                                .profileCircle)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          S.of(context).addSendContact,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .accentColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
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
                    S
                        .of(context)
                        .swipeToRequest,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.dark_gray_1
                    ),
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
