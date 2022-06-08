import 'package:domain/constants/enum/transaction_status_enum.dart';
import 'package:domain/model/payment/payment_activity_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentActivityPageView
    extends BasePageViewWidget<PaymentActivityViewModel> {
  PaymentActivityPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (StringUtils.isDirectionRTL(context)) {
            if (!details.primaryVelocity!.isNegative) {
            } else {
              ProviderScope.containerOf(context)
                  .read(activityHomeViewModelProvider)
                  .appSwiperController
                  .previousPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.linear);
            }
          } else {
            if (details.primaryVelocity!.isNegative) {
            } else {
              ProviderScope.containerOf(context)
                  .read(activityHomeViewModelProvider)
                  .appSwiperController
                  .previousPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.linear);
            }
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).canvasColor,
          margin: EdgeInsetsDirectional.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            padding: EdgeInsetsDirectional.only(top: 30, start: 24, end: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).paymentActivity,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark_yellow),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: AppStreamBuilder<Resource<List<PaymentActivityData>>>(
                      stream: ProviderScope.containerOf(context)
                          .read(activityHomeViewModelProvider)
                          .paymentActivityListStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, transaction) {
                        return transaction!.data!.length > 0
                            ? ListView.builder(
                                itemCount: transaction.data!.length > 4
                                    ? 4
                                    : transaction.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (mContext, index) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        top: index == 0 ? 0 : 23,
                                        bottom: index ==
                                                transaction.data!.length - 1
                                            ? 10
                                            : 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Text(
                                              transaction.data![index].name!
                                                          .split(" ")
                                                          .length >
                                                      1
                                                  ? StringUtils
                                                      .getFirstInitials(
                                                          transaction
                                                              .data![index]
                                                              .name!)
                                                  : "",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 11),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(TextSpan(
                                                    text: 'You requested ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              '${transaction.data![index].amount} JOD ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12)),
                                                      TextSpan(
                                                          text: 'from ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12)),
                                                      TextSpan(
                                                          text:
                                                              '${transaction.data![index].name}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12)),
                                                    ])),
                                                // Text(
                                                //   "You requested ${transaction
                                                //       .data![index]
                                                //       .amount} JOD from ${transaction
                                                //       .data![index].name}",
                                                //   maxLines: 2,
                                                //   style: TextStyle(
                                                //       fontWeight:
                                                //       FontWeight.w700,
                                                //       fontSize: 12),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(top: 6),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                        color: getColor(
                                                            transaction
                                                                .data![index]
                                                                .status!),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: Text(
                                                      transaction
                                                          .data![index].status!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "No Payment activity to display",
                                  textAlign: TextAlign.center,
                                ),
                              );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(TransactionStatusEnum value) {
    switch (value) {
      case TransactionStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case TransactionStatusEnum.CATEGORY_REJECTED:
        return AppColor.vividRed;
      case TransactionStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
