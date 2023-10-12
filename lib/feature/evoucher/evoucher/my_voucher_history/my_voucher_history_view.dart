import 'package:domain/model/e_voucher/get_voucher_details.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher/evoucher_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog.dart';
import 'package:neo_bank/ui/molecules/evoucher/my_voucher_history_widget_view.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/no_data_widget.dart';
import '../../evoucher_detail/evoucher_detail_page.dart';

class MyVoucherHistoryView extends BasePageViewWidget<EvoucherViewModel> {
  MyVoucherHistoryView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: ListView(
        controller: model.scrollController,
        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
        children: [
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: (focus) {
                    if (!focus) {
                      if (model.myVoucherHistorySearchController.text.isNotEmpty) {
                        model.myVoucherHistoryList = [];
                        model.pageNo = 1;

                        model.getVoucherHistory(
                            pageNo: model.pageNo,
                            rangeOfMonths: model.filterDay,
                            searchPhrase: model.myVoucherHistorySearchController.text);
                      }
                    }
                  },
                  child: AppTextField(
                    labelText: "",
                    controller: model.myVoucherHistorySearchController,
                    hintText: S.of(context).eVoucherSearchLabel,
                    containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    onChanged: (value) {
                      if (model.myVoucherHistorySearchController.text.isEmpty) {
                        model.myVoucherHistoryList = [];
                        model.pageNo = 1;
                        FocusManager.instance.primaryFocus?.unfocus();
                        model.getVoucherHistory(
                            pageNo: model.pageNo,
                            rangeOfMonths: model.filterDay,
                            searchPhrase: model.myVoucherHistorySearchController.text);
                      }
                    },
                    suffixIcon: (value, data) {
                      return InkWell(
                        onTap: () async {},
                        child: Container(
                            height: 16.0.h,
                            width: 16.0.w,
                            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                            child:
                                AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              InkWell(
                onTap: () {
                  FilterTransactionDialog.show(
                    context,
                    onDismissed: () => Navigator.pop(context),
                    onSelected: (value) {
                      Navigator.pop(context);
                      model.filterDay = model.getFilterDays(value);
                      model.myVoucherHistoryList = [];
                      model.pageNo = 1;

                      model.getVoucherHistory(
                        pageNo: model.pageNo,
                        rangeOfMonths: model.getFilterDays(value),
                      );
                    },
                  );
                },
                child: AppSvg.asset(
                  AssetUtils.filter,
                  color: Theme.of(context).colorScheme.shadow,
                  height: 24.h,
                  width: 24.w,
                ),
              )
            ],
          ),
          SizedBox(height: 32.h),
          getMyVouchers(model, context),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget getMyVouchers(EvoucherViewModel model, BuildContext context) {
    return AppStreamBuilder<Resource<GetVoucherDetails>>(
        initialData: Resource.none(),
        stream: model.getvoucherDetiailsStream,
        onData: (value) {
          if (value.status == Status.SUCCESS) {
            Navigator.pushNamed(context, RoutePaths.EvoucherDetail,
                arguments: EvoucherDetailPageArgument(
                    selectedVoucherData: value.data, voucherDetail: model.historyData));
          }
        },
        dataBuilder: (context, voucherDetails) {
          return AppStreamBuilder<Resource<List<VouchersByDate>>>(
              initialData: Resource.none(),
              stream: model.voucherHistoryResponseStream,
              dataBuilder: (context, voucherHistory) {
                switch (voucherHistory?.status) {
                  case Status.SUCCESS:
                    return (voucherHistory?.data ?? []).isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      TimeUtils.convertDateTimeToDateMonth(
                                          voucherHistory?.data?[index].date ?? ''),
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).colorScheme.shadow,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ), //title
                                  SizedBox(height: 16.h),
                                  Card(
                                    color: Theme.of(context).colorScheme.secondary,
                                    elevation: 16,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, childIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            model.historyData = voucherHistory!.data![index].data[childIndex];

                                            model.getVoucherDetailCall(
                                                OrderIdentifier: voucherHistory.data?[index].data[childIndex]
                                                    .lineItems.first.cardItemId);
                                          },
                                          child: MyVoucherHistoryWidget(
                                              (voucherHistory?.data?[index].data ?? [])[childIndex]),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox();
                                      },
                                      itemCount: (voucherHistory?.data?[index].data ?? []).length,
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 32.h);
                            },
                            itemCount: (voucherHistory?.data ?? []).length,
                          )
                        : Center(child: NoDataWidget());

                  default:
                    return Container();
                }
              });
        });
  }
}
