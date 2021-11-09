import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class TaxPayerDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final TaxPayerTypeEnum? taxPayerTypeEnum;

  const TaxPayerDialogView(
      {this.onDismissed, this.onSelected, this.taxPayerTypeEnum});

  ProviderBase providerBase() {
    return taxPayerDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaxPayerDialogViewModel>(
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
                            S.of(context).whichTaxPayerAreYouSmall,
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
                                color: AppColor.dark_violet_3,
                              ),
                            ),
                          ),
                          AppScrollableListViewWidget(
                            child: ClickableListWheelScrollView(
                              scrollController: model.scrollController,
                              itemHeight: 64,
                              itemCount:
                                  model.getList(taxPayerTypeEnum!).length,
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
                                      childCount: model
                                          .getList(taxPayerTypeEnum!)
                                          .length,
                                      builder:
                                          (BuildContext context, int index) {
                                        return ListScrollWheelListWidget(
                                          label: model.getList(
                                              taxPayerTypeEnum!)[index],
                                          textColor: currentIndex == index
                                              ? AppColor.white
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
                          onSelected!.call(
                              model.getList(taxPayerTypeEnum!)[currentIndex!]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 57,
                          width: 57,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.dark_violet_4),
                          child: AppSvg.asset(AssetUtils.tick),
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
