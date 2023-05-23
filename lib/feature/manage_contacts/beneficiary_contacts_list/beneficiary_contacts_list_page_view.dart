import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/beneficiary_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'beneficiary_contacts_list_page_view_model.dart';

class BeneficiaryContactListPageView extends BasePageViewWidget<BeneficiaryContactListPageViewModel> {
  BeneficiaryContactListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BeneficiaryContactListPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [searchContact(context, model), listItem(context, model)],
      ),
    );
  }

  searchContact(context, BeneficiaryContactListPageViewModel model) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
          height: 4.h,
          width: 64.w,
          decoration: BoxDecoration(color: AppColor.white_gray, borderRadius: BorderRadius.circular(4)),
        ),
        AppTextField(
          labelText: '',
          controller: model.contactSearchController,
          textFieldBorderColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
          hintTextColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
          textColor: Theme.of(context).primaryColorDark,
          hintText: S.of(context).searchContacts,
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
      ],
    );
  }

  listItem(context, BeneficiaryContactListPageViewModel model) {
    return AppStreamBuilder<Resource<List<Beneficiary>>>(
        stream: model.getBeneficiaryListStream,
        initialData: Resource.none(),
        dataBuilder: (context, beneficiaryList) {
          switch (beneficiaryList?.status) {
            case Status.SUCCESS:
              return (beneficiaryList?.data ?? []).isNotEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 16.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        ///send data from api response once updated
                                        return BeneficiaryListWidget(
                                          beneficiary: beneficiaryList?.data![index],
                                          onTap: () async {
                                            var result = await Navigator.pushNamed(
                                                context, RoutePaths.BeneficiaryContactDetailsPage,
                                                arguments: beneficiaryList?.data![index]);

                                            // if (result != null) {
                                            //   model.getBeneficiaryList();
                                            // }
                                          },
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: beneficiaryList?.data?.length,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : noDataFound(context, model);
            default:
              return Container();
          }
        });
  }

  noDataFound(context, BeneficiaryContactListPageViewModel model) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 96.h,
                  width: 96.w,
                  margin: EdgeInsetsDirectional.only(bottom: 12.h),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).inputDecorationTheme.hintStyle!.color!)),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                      child: AppSvg.asset(AssetUtils.contacts)),
                ),
                Text(
                  S.of(context).youDontHaveAnyContactAddYourFirstNow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12.t,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, RoutePaths.AddContactsIBANManageContactsPage);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16.h),
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).accentTextTheme.bodyText1?.color,
                    ),
                    child: Text(S.of(context).addContact,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 12.t,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
