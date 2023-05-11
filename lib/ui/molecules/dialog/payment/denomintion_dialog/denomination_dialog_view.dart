import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/payment/account_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'denomination_dialog_view_model.dart';

class DenominationsDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(GetPrepaidCategoriesModelData)? onSelected;
  final List<GetPrepaidCategoriesModelData>? getPrePaidCategoriesList;
  final String label;
  final String? billerCode;
  final String? serviceCode;

  DenominationsDialogView(
      {this.onDismissed,
      this.onSelected,
      this.getPrePaidCategoriesList,
      required this.label,
      this.billerCode,
      this.serviceCode});

  ProviderBase providerBase() {
    return dominationDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DenominationsDialogViewModel>(
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
                        onDismissed?.call();
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
                              label,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
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
                              key: ValueKey(getPrePaidCategoriesList!.length),
                              child: ClickableListWheelScrollView(
                                scrollController: model.scrollController,
                                itemHeight: 64,
                                itemCount: getPrePaidCategoriesList!.length,
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
                                            childCount:
                                                getPrePaidCategoriesList!.length,
                                            builder: (BuildContext context,
                                                int index) {
                                              return AccountSelectionWidget(
                                                labelTitle:
                                                    S.of(context).denomination,
                                                label:
                                                    getPrePaidCategoriesList![
                                                                index]
                                                            .description ??
                                                        "",
                                                textColor: currentIndex == index
                                                    ? Theme.of(context)
                                                        .primaryColorDark
                                                    : AppColor.dark_gray_1,
                                                widgetColor: Colors.transparent,
                                                currentIndex: index,
                                              );
                                            })),
                              ),
                            ),
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            onSelected!
                                .call(getPrePaidCategoriesList![currentIndex!]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).textTheme.bodyMedium!.color!),
                            child: AppSvg.asset(AssetUtils.tick,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
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
