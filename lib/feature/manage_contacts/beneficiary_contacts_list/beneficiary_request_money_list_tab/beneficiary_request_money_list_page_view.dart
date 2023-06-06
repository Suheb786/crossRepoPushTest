import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contacts_list/beneficiary_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/beneficiary_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../utils/navgition_type.dart';

class BeneficiaryRequestMoneyListPageView extends BasePageViewWidget<BeneficiaryContactListPageViewModel> {
  BeneficiaryRequestMoneyListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BeneficiaryContactListPageViewModel model) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0.w,
        right: 24.0.w,
        top: 24.h,
      ),
      child: Column(
        children: [searchContact(context, model), listItem(context, model)],
      ),
    );
  }

  searchContact(context, BeneficiaryContactListPageViewModel model) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AppTextField(
                  labelText: '',
                  controller: model.sendMoneySearchController,
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
              ),
              SizedBox(
                width: 8.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.AddContactsIBANManageContactsPage,
                      arguments: NavigationType.REQUEST_MONEY);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0.w)),
                      border: Border.all(color: Theme.of(context).colorScheme.shadow.withOpacity(0.3))),
                  child: AppSvg.asset(AssetUtils.plusIcon,
                      color: Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              )
            ],
          ),
        )
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 2,
                              shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              margin: EdgeInsets.only(top: 16.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.w, top: 24.h),
                                      child: Text(S.of(context).favourites,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.t,
                                              color: Theme.of(context).textTheme.bodyMedium!.color)),
                                    ),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        ///send data from api response once updated
                                        return BeneficiaryListWidget(
                                          beneficiary: beneficiaryList?.data![index],
                                          onTap: () async {
                                            var result = await Navigator.pushNamed(
                                                context, RoutePaths.BeneficiaryContactDetailsPage,
                                                arguments: beneficiaryList?.data![index]);

                                            if (result != null) {
                                              // model.getBeneficiaryList();
                                            }
                                          },
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: beneficiaryList?.data?.length,
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.w),
                                      child: Text(S.of(context).others,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.t,
                                              color: Theme.of(context).textTheme.bodyMedium!.color)),
                                    ),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        ///send data from api response once updated
                                        return BeneficiaryListWidget(
                                          beneficiary: beneficiaryList?.data![index],
                                          onTap: () async {
                                            var result = await Navigator.pushNamed(
                                                context, RoutePaths.BeneficiaryContactDetailsPage,
                                                arguments: beneficiaryList?.data![index]);

                                            if (result != null) {
                                              // model.getBeneficiaryList();
                                            }
                                          },
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: beneficiaryList?.data?.length,
                                    ),
                                    SizedBox(
                                      height: 56.h,
                                    )
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
    return Expanded(
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
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.AddContactsIBANManageContactsPage,
                    arguments: NavigationType.REQUEST_MONEY);
              },
              child: Container(
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                child: Text(S.of(context).addContact,
                    textAlign: TextAlign.center,
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
    );
  }
}
