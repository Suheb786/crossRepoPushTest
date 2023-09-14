import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../di/dashboard/dashboard_modules.dart';
import '../../../../ui/molecules/app_svg.dart';
import '../../../../ui/molecules/dialog/sub_accounts_dialogs/select_account_list_dialog/select_account_list_dialog.dart';
import '../../../../utils/asset_utils.dart';

class RjMakePaymentView extends BasePageViewWidget<RjMakePaymentViewModel> {
  RjMakePaymentView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
                enabled: isError ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<bool>>(
                    initialData: Resource.none(),
                    stream: model.rjOtpValidateStream,
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(rjFlightBookingDetailViewModelProvider)
                            .nextPage();
                      }
                      //Todo remove from code
                      ProviderScope.containerOf(context)
                          .read(rjFlightBookingDetailViewModelProvider)
                          .nextPage();
                    },
                    dataBuilder: (BuildContext context, data) {
                      return AppStreamBuilder<List<MakePaymentCard>>(
                          initialData: [],
                          stream: model.itemSelectedStream,
                          dataBuilder: (BuildContext context, data) {
                            return GestureDetector(
                              /*  onHorizontalDragEnd: (details) {
                                if (ProviderScope.containerOf(context)
                                        .read(rjFlightBookingDetailViewModelProvider)
                                        .appSwiperController
                                        .page ==
                                    1.0) {
                                  FocusScope.of(context).unfocus();

                                  if (StringUtils.isDirectionRTL(context)) {
                                    if (details.primaryVelocity!.isNegative) {
                                      ProviderScope.containerOf(context)
                                          .read(rjFlightBookingDetailViewModelProvider)
                                          .previousPage();
                                    } else {
                                      // model.rjOtpValidate();
                                    }
                                  } else {
                                    if (details.primaryVelocity!.isNegative) {
                                      // model.rjOtpValidate();
                                    } else {
                                      ProviderScope.containerOf(context)
                                          .read(rjFlightBookingDetailViewModelProvider)
                                          .previousPage();
                                    }
                                  }
                                }
                              }, */
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional.topStart,
                                          child: Text(
                                            S.of(context).payFrom,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: Theme.of(context).colorScheme.surfaceVariant,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.t),
                                          ),
                                        ),

                                        // Expanded(
                                        //   child: ListView.separated(
                                        //     itemCount: model.makePaymentCardList.length,
                                        //     itemBuilder: (BuildContext context, int index) {
                                        //       return (data ?? []).length > 0
                                        //           ? GestureDetector(
                                        //               onTap: () {
                                        //                 model.selectedItem(index);
                                        //               },
                                        //               child: Container(
                                        //                   padding: EdgeInsets.symmetric(
                                        //                       horizontal: 16.w, vertical: 16.h),
                                        //                   decoration: BoxDecoration(
                                        //                       borderRadius: BorderRadius.circular(8),
                                        //                       border: Border.all(
                                        //                           width: 1,
                                        //                           color: Theme.of(context)
                                        //                               .colorScheme
                                        //                               .inverseSurface)),
                                        //                   child: Row(
                                        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //                     crossAxisAlignment: CrossAxisAlignment.center,
                                        //                     children: [
                                        //                       Column(
                                        //                         crossAxisAlignment: CrossAxisAlignment.start,
                                        //                         children: [
                                        //                           Text(
                                        //                             model.makePaymentCardList[index].cardName,
                                        //                             style: TextStyle(
                                        //                                 fontFamily: StringUtils.appFont,
                                        //                                 color: Theme.of(context)
                                        //                                     .primaryColorDark,
                                        //                                 fontWeight: FontWeight.w600,
                                        //                                 fontSize: 14.t),
                                        //                           ),
                                        //                           SizedBox(
                                        //                             height: 4.h,
                                        //                           ),
                                        //                           Text(
                                        //                             model.makePaymentCardList[index].cardNo,
                                        //                             style: TextStyle(
                                        //                                 fontFamily: StringUtils.appFont,
                                        //                                 color: Theme.of(context)
                                        //                                     .colorScheme
                                        //                                     .inversePrimary,
                                        //                                 fontWeight: FontWeight.w600,
                                        //                                 fontSize: 12.t),
                                        //                           ),
                                        //                           SizedBox(
                                        //                             height: 16.h,
                                        //                           ),
                                        //                           Text(
                                        //                             "${model.makePaymentCardList[index].amt.toStringAsFixed(3)}  ${model.makePaymentCardList[index].currency}",
                                        //                             style: TextStyle(
                                        //                                 fontFamily: StringUtils.appFont,
                                        //                                 color: Theme.of(context)
                                        //                                     .primaryColorDark,
                                        //                                 fontWeight: FontWeight.w600,
                                        //                                 fontSize: 14.t),
                                        //                           ),
                                        //                         ],
                                        //                       ),
                                        //                       (data?[index].isSelected ?? false)
                                        //                           ? Container(
                                        //                               height: 40.w,
                                        //                               width: 40.w,
                                        //                               child: Padding(
                                        //                                 padding:
                                        //                                     EdgeInsetsDirectional.all(10),
                                        //                                 child: AppSvg.asset(AssetUtils.check,
                                        //                                     color: AppColor.black),
                                        //                               ),
                                        //                               decoration: BoxDecoration(
                                        //                                   color:
                                        //                                       Theme.of(context).canvasColor,
                                        //                                   borderRadius:
                                        //                                       BorderRadius.circular(100),
                                        //                                   border: Border.all(
                                        //                                       width: 1,
                                        //                                       color: Theme.of(context)
                                        //                                           .colorScheme
                                        //                                           .inverseSurface)),
                                        //                             )
                                        //                           : Container(
                                        //                               height: 40.w,
                                        //                               width: 40.w,
                                        //                               decoration: BoxDecoration(
                                        //                                   borderRadius:
                                        //                                       BorderRadius.circular(100),
                                        //                                   border: Border.all(
                                        //                                       width: 1,
                                        //                                       color: Theme.of(context)
                                        //                                           .colorScheme
                                        //                                           .inverseSurface)),
                                        //                             )
                                        //                     ],
                                        //                   )),
                                        //             )
                                        //           : Center(
                                        //               child: Text(
                                        //                 'No Data Found',
                                        //                 style: TextStyle(
                                        //                     fontFamily: StringUtils.appFont,
                                        //                     fontSize: 14.t,
                                        //                     fontWeight: FontWeight.w400,
                                        //                     color: Theme.of(context).colorScheme.tertiary),
                                        //               ),
                                        //             );
                                        //     },
                                        //     separatorBuilder: (BuildContext context, int index) {
                                        //       return SizedBox(
                                        //         height: 16,
                                        //       );
                                        //     },
                                        //   ),
                                        // ),

                                        Visibility(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(top: 16.0.h),
                                            child: AppStreamBuilder<Account>(
                                                initialData: Account(
                                                    accountNo: "",
                                                    accountTitle: "",
                                                    availableBalance: "",
                                                    nickName: ""),
                                                stream: model.selectedFromAccountStream,
                                                dataBuilder: (context, selectedFromAccount) {
                                                  return InkWell(
                                                    onTap: () {
                                                      SelectAccountListDialog.show(
                                                        context,
                                                        title: S.current.payFrom,
                                                        accountList: ProviderScope.containerOf(context)
                                                            .read(appHomeViewModelProvider)
                                                            .getAllMyAccounts(),
                                                        onDismissed: () => Navigator.pop(context),
                                                        onConfirm: (value) {
                                                          Navigator.pop(context);
                                                          model.validateIfEmpty();
                                                          model.addFromAccountData(selectedAccount: value);
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: EdgeInsetsDirectional.all(16.h),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: (Theme.of(context)
                                                                .inputDecorationTheme
                                                                .enabledBorder!
                                                                .borderSide
                                                                .color)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Expanded(
                                                            flex: 7,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  S.current.payFrom,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 10.0.t,
                                                                      color:
                                                                          Theme.of(context).primaryColorDark,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                SizedBox(height: 8.h),
                                                                Text(
                                                                  "Main Account - Primary",
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 14.0.t,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .shadow,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                                SizedBox(height: 4.h),
                                                                Text(
                                                                  "8698689689",
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 12.0.t,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .surfaceTint,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                                SizedBox(height: 16.h),
                                                                Text(
                                                                  "89,988.00 JOD",
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 14.0.t,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .shadow,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                                height: 16.h,
                                                                width: 16.w,
                                                                padding:
                                                                    EdgeInsets.symmetric(horizontal: 7.w),
                                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                                    color:
                                                                        Theme.of(context).primaryColorDark)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            AppStreamBuilder<bool>(
                                              initialData: false,
                                              stream: model.showButtonSubjectStream,
                                              dataBuilder: (BuildContext context, data) {
                                                return Visibility(
                                                  // visible: data!,s
                                                  child: AppPrimaryButton(
                                                    text: S.of(context).next,
                                                    onPressed: () {
                                                      // model.rjOtpValidate();
                                                      ProviderScope.containerOf(context)
                                                          .read(rjFlightBookingDetailViewModelProvider)
                                                          .nextPage();
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 31.h,
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: InkWell(
                                                onTap: () {
                                                  ProviderScope.containerOf(context)
                                                      .read(rjFlightBookingDetailViewModelProvider)
                                                      .previousPage();
                                                },
                                                child: Text(
                                                  S.of(context).back,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                    fontSize: 14.t,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          });
                    }));
          }),
    );
  }
}
