import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class TaxPayerDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String, String)? onSelected;
  final TaxPayerTypeEnum? taxPayerTypeEnum;

  const TaxPayerDialogView({this.onDismissed, this.onSelected, this.taxPayerTypeEnum});

  ProviderBase providerBase() {
    return taxPayerDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaxPayerDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 32.0.h),
                            child: Center(
                              child: Text(
                                S.of(context).whichTaxPayerAreYouSmall,
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
                                    borderRadius: BorderRadius.circular(16.w),
                                    color: AppColor.vividYellow,
                                  ),
                                ),
                              ),
                              AppScrollableListViewWidget(
                                key: ValueKey(model.getList(taxPayerTypeEnum!).length),
                                child: ClickableListWheelScrollView(
                                  scrollController: model.scrollController,
                                  itemHeight: 64.h,
                                  itemCount: model.getList(taxPayerTypeEnum!).length,
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
                                          childCount: model.getList(taxPayerTypeEnum!).length,
                                          builder: (BuildContext context, int index) {
                                            return ListScrollWheelListWidget(
                                              label: model.getList(taxPayerTypeEnum!)[index],
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
                            padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                            child: AppPrimaryButton(
                              isDisabled: false,
                              onPressed: () {
                                onSelected!.call(
                                    model.getList(taxPayerTypeEnum!)[currentIndex!],
                                    taxPayerTypeEnum == TaxPayerTypeEnum.W8
                                        ? model.taxPayerListW8[currentIndex]
                                        : model.taxPayerListW9[currentIndex]);
                              },
                              text: S.of(context).confirm,
                            ),
                          ),
                          SizedBox(height: 40.h),

                          // InkWell(
                          //   onTap: () {
                          //     onSelected!.call(
                          //         model.getList(taxPayerTypeEnum!)[currentIndex!],
                          //         taxPayerTypeEnum == TaxPayerTypeEnum.W8
                          //             ? model.taxPayerListW8[currentIndex]
                          //             : model.taxPayerListW9[currentIndex]);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          //     height: 57.h,
                          //     width: 57.w,
                          //     decoration: BoxDecoration(
                          //         shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge!.color!),
                          //     child:
                          //         AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                          //   child: Center(
                          //     child: Text(
                          //       S.of(context).swipeDownToCancel,
                          //       style: TextStyle(
                          //           fontFamily: StringUtils.appFont,
                          //           fontSize: 10.t,
                          //           fontWeight: FontWeight.w400,
                          //           color: AppColor.dark_gray_1),
                          //     ),
                          //   ),
                          // ),
                        ],
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
                      ),
                    ],
                  );
                },
              ));
        },
        providerBase: providerBase());
  }
}
