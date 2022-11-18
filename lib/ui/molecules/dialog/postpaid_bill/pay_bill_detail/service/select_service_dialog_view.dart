import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'select_service_dialog_view_model.dart';

class SelectServiceDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(BillerService)? onSelected;
  final String? title;
  bool _keyboardVisible = false;
  List<BillerService>? billerService;

  SelectServiceDialogView(
      {this.onDismissed, this.onSelected, this.title, this.billerService});

  ProviderBase providerBase() {
    return selectServiceDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<SelectServiceDialogViewModel>(
        // onModelReady: (model) {
        //   model.serviceList = [
        //     'Internet Bill Payment',
        //     'Deactivate Internet Service',
        //     'Deactivate T.F Service',
        //   ];
        // },
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  bottom: 36.h,
                  top: _keyboardVisible ? 36.h : 204.h),
              child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      onDismissed?.call();
                    }
                  },
                  child: AppStreamBuilder<int>(
                    initialData: 0,
                    stream: model!.currentIndexStream,
                    dataBuilder: (BuildContext context, selectedIndex) {
                      return AppKeyBoardHide(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 32.0.h),
                              child: Center(
                                child: Text(
                                  title!,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            billerService!.isNotEmpty
                                ? Expanded(
                                    child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0.w),
                                        child: Container(
                                          height: 64.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: AppColor.vividYellow,
                                          ),
                                        ),
                                      ),
                                      AppScrollableListViewWidget(
                                        key: ValueKey(billerService!.length),
                                        child: ClickableListWheelScrollView(
                                          scrollController:
                                              model.scrollController,
                                          itemHeight: 72,
                                          itemCount: billerService!.length,
                                          //   itemCount: data.data!.length,
                                          onItemTapCallback: (index) {
                                            print(
                                                'onItemTapCallback----->$index');
                                          },

                                          child:
                                              ListWheelScrollView.useDelegate(
                                                  controller:
                                                      model.scrollController,
                                                  itemExtent: 72,
                                                  onSelectedItemChanged:
                                                      (int index) {
                                                    print(
                                                        'onSelectedItemChanged----->$index');
                                                    model.currentIndexUpdate(
                                                        index);
                                                  },
                                                  physics:
                                                      FixedExtentScrollPhysics(),
                                                  perspective: 0.0000000001,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          childCount:
                                                              billerService!
                                                                  .length,
                                                          builder: (BuildContext
                                                                  context,
                                                              int index) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16.w),
                                                              padding: EdgeInsetsDirectional
                                                                  .only(
                                                                      start:
                                                                          24.w,
                                                                      end: 20.w,
                                                                      top: 20.h,
                                                                      bottom:
                                                                          20.h),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                  color: Colors
                                                                      .transparent),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              16.0.w),
                                                                      child:
                                                                          Text(
                                                                        AppConstantsUtils.LANGUAGE_KEY ==
                                                                                "EN"
                                                                            ? billerService![index].serviceDescriptionEn!
                                                                            : billerService![index].serviceDescriptionAr!,
                                                                        //  data.data![index],
                                                                        softWrap:
                                                                            true,
                                                                        maxLines:
                                                                            2,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              StringUtils.appFont,
                                                                          fontSize:
                                                                              14.t,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          // color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.very_dark_violet
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          })),
                                        ),
                                      ),
                                    ],
                                  ))
                                : Expanded(
                                    child: Center(
                                      child: Container(
                                        child: Text(S.of(context).noDataFound),
                                      ),
                                    ),
                                  ),
                            InkWell(
                              onTap: () {
                                if (billerService != null &&
                                    billerService!.length > 0) {
                                  onSelected!
                                      .call(billerService![selectedIndex ?? 0]);
                                }
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.h, horizontal: 16.w),
                                height: 57.h,
                                width: 57.w,
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
                              padding:
                                  EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    onDismissed?.call();
                                  },
                                  child: Text(
                                    S.of(context).swipeDownToCancel,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10.t,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.dark_gray_1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )));
        },
        providerBase: providerBase());
  }
}
