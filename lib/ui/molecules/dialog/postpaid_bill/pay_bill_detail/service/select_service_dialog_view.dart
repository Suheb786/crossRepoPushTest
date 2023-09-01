import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
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

  SelectServiceDialogView({this.onDismissed, this.onSelected, this.title, this.billerService});

  ProviderBase providerBase() {
    return selectServiceDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<SelectServiceDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(
                  left: 24.w, right: 24.w, bottom: 36.h, top: _keyboardVisible ? 36.h : 204.h),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  AppStreamBuilder<int>(
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
                                        key: ValueKey(billerService!.length),
                                        child: ClickableListWheelScrollView(
                                          scrollController: model.scrollController,
                                          itemHeight: 75,
                                          itemCount: billerService!.length,
                                          //   itemCount: data.data!.length,
                                          onItemTapCallback: (index) {
                                            debugPrint('onItemTapCallback----->$index');
                                          },

                                          child: ListWheelScrollView.useDelegate(
                                              controller: model.scrollController,
                                              itemExtent: 75,
                                              onSelectedItemChanged: (int index) {
                                                debugPrint('onSelectedItemChanged----->$index');
                                                model.currentIndexUpdate(index);
                                              },
                                              physics: FixedExtentScrollPhysics(),
                                              perspective: 0.0000000001,
                                              childDelegate: ListWheelChildBuilderDelegate(
                                                  childCount: billerService!.length,
                                                  builder: (BuildContext context, int index) {
                                                    return Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 24.w, end: 20.w, top: 20.h, bottom: 20.h),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16),
                                                          color: Colors.transparent),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.symmetric(horizontal: 16.0.w),
                                                              child: Text(
                                                                !StringUtils.isDirectionRTL(context)
                                                                    ? billerService![index]
                                                                        .serviceDescriptionEn!
                                                                    : billerService![index]
                                                                        .serviceDescriptionAr!,
                                                                //  data.data![index],
                                                                softWrap: true,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontSize: 14.t,
                                                                  fontWeight: FontWeight.w400,
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
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
                              child: AppPrimaryButton(
                                onPressed: () {
                                  if (billerService != null && billerService!.length > 0) {
                                    onSelected!.call(billerService![selectedIndex ?? 0]);
                                  }
                                  Navigator.pop(context);
                                },
                                text: S.of(context).confirm,
                              ),
                            )
                          ],
                        ),
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
