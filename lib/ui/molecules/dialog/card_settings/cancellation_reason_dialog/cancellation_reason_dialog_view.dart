import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/cancellation_reason_dialog/cancellation_reason_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CancellationReasonDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;
  final List<String> reasons;

  const CancellationReasonDialogView({required this.reasons, this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return cancelReasonCardDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CancellationReasonDialogModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 204.h),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
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
                                S.of(context).reasonOfCancellation,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14.t,
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
                                    color: AppColor.vividYellow,
                                  ),
                                ),
                              ),
                              AppScrollableListViewWidget(
                                key: ValueKey(reasons.length),
                                child: ClickableListWheelScrollView(
                                  scrollController: model.scrollController,
                                  itemHeight: 64.h,
                                  itemCount: reasons.length,
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
                                          childCount: reasons.length,
                                          builder: (BuildContext context, int index) {
                                            return ListScrollWheelListWidget(
                                              label: reasons[index],
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
                            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 42.h),
                            child: AppPrimaryButton(
                              onPressed: () {
                                onSelected!.call(reasons[currentIndex!]);
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
