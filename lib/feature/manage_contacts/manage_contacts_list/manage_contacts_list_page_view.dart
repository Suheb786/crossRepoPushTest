import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/contact_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageContactListPageView extends BasePageViewWidget<ManageContactListPageViewModel> {
  ManageContactListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ManageContactListPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          // Container(
          //   margin: EdgeInsetsDirectional.only(top: 8, bottom: 24),
          //   height: 4,
          //   width: 64,
          //   decoration: BoxDecoration(
          //       color: AppColor.whiteGray,
          //       borderRadius: BorderRadius.circular(4)),
          // ),
          AppTextField(
            labelText: '',
            controller: model.contactSearchController,
            textFieldBorderColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.3),
            hintTextColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
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
          AppStreamBuilder<Resource<List<Beneficiary>>>(
              stream: model.getBeneficiaryListStream,
              initialData: Resource.none(),
              dataBuilder: (context, beneficiaryList) {
                return beneficiaryList!.data!.length > 0
                    ? Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                                decoration: BoxDecoration(
                                    color: AppColor.vividYellow, borderRadius: BorderRadius.circular(16.w)),
                                child: Text(
                                  S.of(context).addingContactsDesc,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColorDark),
                                )),
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 16.h),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  itemBuilder: (context, index) {
                                    ///send data from api response once updated
                                    return ContactListWidget(
                                      beneficiary: beneficiaryList.data![index],
                                      onTap: () async {
                                        var result = await Navigator.pushNamed(
                                            context, RoutePaths.ManageContactsDetail,
                                            arguments: beneficiaryList.data![index]);

                                        if (result != null) {
                                          model.getBeneficiaryList();
                                        }
                                      },
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: beneficiaryList.data!.length,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
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
                                    border: Border.all(
                                        color: Theme.of(context).inputDecorationTheme.hintStyle!.color!)),
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                                    child: AppSvg.asset(AssetUtils.contacts)),
                              ),
                              Text(
                                S.of(context).noContactsYetDesc,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      );
              })
        ],
      ),
    );
  }
}
