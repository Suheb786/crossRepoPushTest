// ignore_for_file: deprecated_member_use

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/payment/get_rejection_reason/get_rejection_reason_response.dart';
import 'package:domain/model/payment/get_rejection_reason/reject_reasons_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/return_reasons_dialog/return_reason_payment_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ReturnReasonPaymentDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(ReturnReasonsPayment)? onSelected;
  final GetRejectionReasonResponseModel? returnReasonsPayment;
  final String title;

  const ReturnReasonPaymentDialogView(
      {this.onDismissed, this.onSelected, required this.title, required this.returnReasonsPayment});

  ProviderBase providerBase() {
    return returnReasonsPaymentDialogPageViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReturnReasonsPaymentDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  AppStreamBuilder<int>(
                    stream: model!.currentIndexStream,
                    initialData: 0,
                    dataBuilder: (context, currentIndex) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 32.0.h),
                            child: Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 16.t,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                child: Container(
                                  height: 64.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ),
                              AppScrollableListViewWidget(
                                key: ValueKey(returnReasonsPayment?.rejectReasons.length),
                                child: ClickableListWheelScrollView(
                                  scrollController: model.scrollController,
                                  itemHeight: 64.h,
                                  itemCount: returnReasonsPayment!.rejectReasons.length,
                                  onItemTapCallback: (index) {
                                    model.currentIndexUpdate(index);
                                  },
                                  child: ListWheelScrollView.useDelegate(
                                      controller: model.scrollController,
                                      itemExtent: 64.h,
                                      onSelectedItemChanged: (int index) {
                                        model.currentIndexUpdate(index);
                                      },
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.0000000001,
                                      childDelegate: ListWheelChildBuilderDelegate(
                                          childCount: returnReasonsPayment!.rejectReasons.length,
                                          builder: (BuildContext context, int index) {
                                            return ListScrollWheelListWidget(
                                              label: returnReasonsPayment!.rejectReasons[index].description,
                                              textColor: currentIndex == index
                                                  ? Theme.of(context).primaryColorDark
                                                  : AppColor.dark_gray_1,
                                              widgetColor: Colors.transparent,
                                            );
                                          })),
                                ),
                              ),
                            ],
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h, top: 16),
                            child: AppPrimaryButton(
                              onPressed: () {
                                onSelected!.call(returnReasonsPayment!.rejectReasons[currentIndex!]);
                              },
                              text: S.of(context).confirm,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Positioned(
                    bottom: -24.h,
                    child: InkWell(
                      onTap: () {
                        onDismissed?.call();
                      },
                      child: Container(
                          height: 48.h,
                          width: 48.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.secondary),
                          child: Image.asset(
                            AssetUtils.close_bold,
                            scale: 3.5,
                          )),
                    ),
                  )
                ],
              ));
        },
        providerBase: providerBase());
  }
}
