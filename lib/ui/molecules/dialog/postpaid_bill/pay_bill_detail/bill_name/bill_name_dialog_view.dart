import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'bill_name_dialog_view_model.dart';

class PayBillDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(BillerDetailsList)? onSelected;
  final String? title;
  bool _keyboardVisible = false;
  final List<BillerDetailsList>? billerDetailsList;

  PayBillDialogView({this.onDismissed, this.onSelected, this.title, this.billerDetailsList});

  ProviderBase providerBase() {
    return payBillDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<PayBillDialogViewModel>(
        onModelReady: (model) {
          model.loadingStream.listen((value) {
            if (value) {
              AppProgress(context);
            } else {
              Navigator.pop(context);
            }
          });
          model.billerDetailsList = this.billerDetailsList!;
        },
        builder: (context, model, child) {
          return AppStreamBuilder<Resource<GetBillerLookUpList>>(
            stream: model!.getBillerLookupStream,
            initialData: Resource.none(),
            onData: (value) {
              if (value.status == Status.SUCCESS) {}
            },
            dataBuilder: (context, snapshot) {
              return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  insetPadding: EdgeInsets.only(
                      left: 24.w, right: 24.w, bottom: 36.h, top: _keyboardVisible ? 36.h : 204.h),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      AppStreamBuilder<int>(
                        stream: model.currentIndexStream,
                        initialData: 0,
                        dataBuilder: (BuildContext context, index) {
                          return AppStreamBuilder<List<BillerDetailsList>>(
                            stream: model.searchBillNameStream,
                            initialData: model.billerDetailsList,
                            dataBuilder: (BuildContext context, billList) {
                              return AppKeyBoardHide(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ///title
                                    _titleWidget(),
                                    _searchWidget(model, context, billList),
                                    _billerListWidget(model, context, billList),
                                    _tickWidget(context, billList, index),
                                  ],
                                ),
                              );
                            },
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
          );
        },
        providerBase: providerBase());
  }

  _titleWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 32.0.h),
      child: Center(
        child: Text(
          title!,
          style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  ///search widget
  _searchWidget(PayBillDialogViewModel model, BuildContext context, List<BillerDetailsList>? billList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: AppTextField(
        labelText: '',
        controller: model.searchBillNameController,
        textFieldBorderColor: AppColor.gray_1,
        hintTextColor: AppColor.gray_2,
        textColor: AppColor.black,
        hintText: S.of(context).searchBill,
        containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        onChanged: (value) {
          model.searchBillName(value);
        },
        suffixIcon: (value, data) {
          return InkWell(
            onTap: () async {},
            child: Container(
                height: 16.h,
                width: 16.w,
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
          );
        },
      ),
    );
  }

  ///biller list widget
  _billerListWidget(PayBillDialogViewModel model, BuildContext context, List<BillerDetailsList>? billList) {
    return billList != null && billList.isNotEmpty
        ? Expanded(
            child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.vividYellow,
                  ),
                ),
              ),
              AppScrollableListViewWidget(
                key: ValueKey(billList.length),
                child: ClickableListWheelScrollView(
                  scrollController: model.scrollController,
                  itemHeight: 78,
                  itemCount: billList.length,
                  //   itemCount: data.data!.length,
                  onItemTapCallback: (index) {
                    debugPrint('onItemTapCallback----->$index');
                  },
                  child: ListWheelScrollView.useDelegate(
                      controller: model.scrollController,
                      itemExtent: 78,
                      onSelectedItemChanged: (int index) {
                        model.currentIndexUpdate(index);
                      },
                      physics: FixedExtentScrollPhysics(),
                      perspective: 0.0000000001,
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: billList.length,
                          builder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              padding:
                                  EdgeInsetsDirectional.only(start: 24.w, end: 20.w, top: 20.h, bottom: 20.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16), color: Colors.transparent),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                      child: Text(
                                        !StringUtils.isDirectionRTL(context)
                                            ? billList[index].billerNameEn!
                                            : billList[index].billerNameAr!,
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
          );
  }

  ///tick widget
  _tickWidget(BuildContext context, List<BillerDetailsList>? billList, int? index) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
      child: AppPrimaryButton(
        onPressed: () {
          if (billList != null && billList.length > 0) {
            onSelected!.call(billList[index ?? 0]);
          }
          Navigator.pop(context);
        },
        text: S.of(context).confirm,
      ),
    );
  }
}
