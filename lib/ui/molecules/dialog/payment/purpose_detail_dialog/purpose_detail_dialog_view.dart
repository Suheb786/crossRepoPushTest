import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/payment_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PurposeDetailDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(PurposeDetail)? onSelected;
  final List<PurposeDetail>? purposeDetailList;

  const PurposeDetailDialogView(
      {this.onDismissed, this.onSelected, this.purposeDetailList});

  ProviderBase providerBase() {
    return purposeDetailDialogViewModelProvider.call(purposeDetailList!);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PurposeDetailDialogViewModel>(
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
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Center(
                          child: Text(
                            S.of(context).purposeDetailSmall,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
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
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                          ),
                          AppScrollableListViewWidget(
                            key: ValueKey(model.purposeDetailList!.length),
                            child: ClickableListWheelScrollView(
                              scrollController: model.scrollController,
                              itemHeight: 64,
                              itemCount: model.purposeDetailList!.length,
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
                                  childDelegate: ListWheelChildBuilderDelegate(
                                      childCount:
                                          model.purposeDetailList!.length,
                                      builder:
                                          (BuildContext context, int index) {
                                            return PaymentScrollWheelWidget(
                                          label: model.purposeDetailList![index]
                                              .labelEn!,
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
                          onSelected!
                              .call(model.purposeDetailList![currentIndex!]);
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
                  );
                },
              ));
        },
        providerBase: providerBase());
  }
}
