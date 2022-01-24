import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/cancellation_reason_dialog/cancellation_reason_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CancellationReasonDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;
  final List<String> reasons;

  const CancellationReasonDialogView(
      {required this.reasons, this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return cancelReasonCardDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CancellationReasonDialogModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        Navigator.pop(context);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Center(
                            child: Text(
                              S.of(context).reasonOfCancellation,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                height: 64,
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
                                itemHeight: 64,
                                itemCount: reasons.length,
                                onItemTapCallback: (index) {
                                  model.currentIndexUpdate(index);
                                },
                                child: ListWheelScrollView.useDelegate(
                                    controller: model.scrollController,
                                    itemExtent: 64,
                                    onSelectedItemChanged: (int index) {
                                      model.currentIndexUpdate(index);
                                    },
                                    physics: FixedExtentScrollPhysics(),
                                    perspective: 0.0000000001,
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                            childCount: reasons.length,
                                            builder: (BuildContext context,
                                                int index) {
                                              return ListScrollWheelListWidget(
                                                label: reasons[index],
                                                textColor: currentIndex == index
                                                    ? Theme.of(context)
                                                        .primaryColorDark
                                                    : AppColor.dark_gray_1,
                                                widgetColor: Colors.transparent,
                                              );
                                            })),
                              ),
                            ),
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            onSelected!.call(reasons[currentIndex!]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .bodyText1!
                                    .color!),
                            child: AppSvg.asset(AssetUtils.tick,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark_gray_1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
        },
        providerBase: providerBase());
  }
}
