import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/beneficiary_transacton_history_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

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
              child: AppTextField(
                labelText: '',
                controller: model.contactSearchController,
                textFieldBorderColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                hintTextColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                textColor: Theme.of(context).primaryColorDark,
                hintText: S.of(context).lookingFor,
                onChanged: (value) {
                  model.searchBeneficiary(value);
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
            Padding(
              padding: EdgeInsetsDirectional.only(start: 24.0.w),
              child: InkWell(
                  onTap: () {
                    FilterTransactionDialog.show(
                      context,
                      onDismissed: () => Navigator.pop(context),
                      onSelected: (value) {
                        Navigator.pop(context);
                        // model.getTransactions(
                        //     cardId: model.cardTransactionArguments.cardId!,
                        //     noOfDays: model.getFilterDays(value));
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
    return AppStreamBuilder<Resource<List<Beneficiary>>>(
        stream: model.getBeneficiaryListStream,
        initialData: Resource.none(),
        dataBuilder: (context, beneficiaryList) {
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemBuilder: (context, index) {
                              ///send data from api response once updated
                              return BeneficiaryTransactionWidget();
                            },
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
