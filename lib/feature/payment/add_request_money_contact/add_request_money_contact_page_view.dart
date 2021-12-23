import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AddRequestMoneyContactPageView
    extends BasePageViewWidget<AddRequestMoneyContactViewModel> {
  AddRequestMoneyContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppKeyBoardHide(
        child: AppStreamBuilder<bool>(
          stream: model.addContactClickedStream,
          initialData: false,
          dataBuilder: (context, isClicked) {
            return isClicked == false
                ? Center(
                    child: AspectRatio(
                      aspectRatio: 0.62,
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (!(details.primaryVelocity!.isNegative)) {
                            ProviderScope.containerOf(context)
                                .read(paymentHomeViewModelProvider)
                                .pageController
                                .previous();
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 2,
                          color: Theme.of(context).canvasColor,
                          margin: EdgeInsets.zero,
                          shadowColor: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.32),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30, left: 27),
                                  child: Text(
                                    S.of(context).requestMoney,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        model
                                            .updateAddContactClickedValue(true);
                                      },
                                      child: AppSvg.asset(
                                          AssetUtils.profileCircle),
                                    ),
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AspectRatio(
                      aspectRatio: 0.62,
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            ProviderScope.containerOf(context)
                                .read(paymentHomeViewModelProvider)
                                .pageController
                                .next();
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 2,
                          color: Theme.of(context).canvasColor,
                          margin: EdgeInsets.zero,
                          shadowColor: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.32),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30, left: 27),
                                  child: Text(
                                    S.of(context).requestMoney,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
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
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CustomRoute.createRoute(
                                                    RequestAmountFromContactPage()));
                                          },
                                          child: Container(
                                            height: 64,
                                            width: 64,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child:
                                                Image.asset(AssetUtils.image),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 6),
                                          child: Text(
                                            "Rose",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 29.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 36,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        S.of(context).seeAllContacts,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .accentTextTheme
                                                .bodyText1!
                                                .color),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
