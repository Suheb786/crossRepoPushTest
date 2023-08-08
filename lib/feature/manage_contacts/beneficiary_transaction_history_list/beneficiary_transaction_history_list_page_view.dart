import 'package:domain/model/manage_contacts/beneficiary_transaction_history_content.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/beneficiary_transacton_history_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import 'beneficiary_transaction_history_list_page_view_model.dart';

class BeneficiaryTransactionHistoryListPageView
    extends BasePageViewWidget<BeneficiaryTransactionHistoryListPageViewModel> {
  BeneficiaryTransactionHistoryListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BeneficiaryTransactionHistoryListPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
      child: Column(
        children: [searchContact(context, model), listItem(context, model)],
      ),
    );
  }

  searchContact(context, BeneficiaryTransactionHistoryListPageViewModel model) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8.h, bottom: 36.h),
          height: 4.h,
          width: 64.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: Theme.of(context).colorScheme.inverseSurface),
        ),
        Row(
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (hasChanged) {
                  if (!hasChanged) {
                    if (model.contactSearchController.text.isNotEmpty) {
                      model.allDataList = [];
                      model.pageNo = 1;
                      model.getTransactions(
                        beneficiaryId: model.arguments.beneficiaryId,
                        filterDays: model.filterDay,
                        searchText: model.contactSearchController.text,
                      );
                      //  model.contactSearchController.clear();
                    }
                  }
                },
                child: AppTextField(
                  labelText: '',
                  controller: model.contactSearchController,
                  textFieldBorderColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                  hintTextColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                  textColor: Theme.of(context).primaryColorDark,
                  hintText: S.of(context).lookingFor,
                  inputType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
                  ],
                  onChanged: (value) {
                    //   model.searchBeneficiary(value);
                    if (model.contactSearchController.text.isEmpty) {
                      model.pageNo = 1;
                      model.allDataList = [];
                      FocusManager.instance.primaryFocus?.unfocus();
                      model.getTransactions(beneficiaryId: model.arguments.beneficiaryId);
                    }
                  },
                  suffixIcon: (value, data) {
                    return InkWell(
                      onTap: () async {},
                      child: Container(
                          height: 16.h,
                          width: 16.w,
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 24.0.w),
              child: InkWell(
                  onTap: () {
                    FilterTransactionDialog.show(
                      context,
                      onDismissed: () => Navigator.pop(context),
                      onSelected: (value) {
                        Navigator.pop(context);
                        model.filterDay = model.getFilterDays(value);
                        model.allDataList = [];
                        model.pageNo = 1;
                        model.getTransactions(
                          beneficiaryId: model.arguments.beneficiaryId,
                          filterDays: model.getFilterDays(value),
                          searchText: model.contactSearchController.text,
                        );
                      },
                    );
                  },
                  child: AppSvg.asset(AssetUtils.filter, width: 24.w, height: 24.h)),
            )
          ],
        ),
      ],
    );
  }

  listItem(context, BeneficiaryTransactionHistoryListPageViewModel model) {
    return AppStreamBuilder<Resource<BeneficiaryTransactionHistoryResponse>>(
        stream: model.getBeneficiaryListStream,
        initialData: Resource.none(),
        onData: (data) async {
          if (data.status == Status.SUCCESS) {
            ///LOG EVENT TO FIREBASE
            await FireBaseLogUtil.fireBaseLog("beneficiary_transaction_history_success",
                {"is_beneficiary_transaction_history_success": true});
          } else if (data.status == Status.ERROR) {
            ///LOG EVENT TO FIREBASE
            await FireBaseLogUtil.fireBaseLog("beneficiary_transaction_history_failed",
                {"is_beneficiary_transaction_history_failed": true});
          }
        },
        dataBuilder: (context, beneficiaryList) {
          switch (beneficiaryList!.status) {
            case Status.SUCCESS:
              return (beneficiaryList.data?.beneficiaryTransactionHistoryContent ?? []).length > 0
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              child: SingleChildScrollView(
                                controller: model.listController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return BeneficiaryTransactionWidget(
                                          content: beneficiaryList
                                                  .data?.beneficiaryTransactionHistoryContent?[index] ??
                                              BeneficiaryTransactionHistoryContent(),
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          (beneficiaryList.data?.beneficiaryTransactionHistoryContent ?? [])
                                              .length,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          S.of(context).noDataFound,
                          style: TextStyle(color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    );
            case Status.ERROR:
              return Expanded(
                child: Center(
                  child: Text(
                    S.of(context).noDataFound,
                  ),
                ),
              );
            default:
              return Container();
          }
        });
  }
}
