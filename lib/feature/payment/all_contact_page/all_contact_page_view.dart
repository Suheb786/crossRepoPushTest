import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/contact_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class AllContactPageView extends BasePageViewWidget<AllContactPageViewModel> {
  AllContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AllContactPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          SizedBox(height: 24),
          AppTextField(
            labelText: '',
            controller: model.contactSearchController,
            textFieldBorderColor:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.3),
            hintTextColor:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
            textColor: Theme.of(context).primaryColorDark,
            hintText: S.of(context).searchContacts,
            onChanged: (value) {
              model.searchBeneficiary(value);
            },
            suffixIcon: (value, data) {
              return InkWell(
                onTap: () async {},
                child: Container(
                    height: 16,
                    width: 16,
                    padding: EdgeInsets.only(right: 8),
                    child: AppSvg.asset(AssetUtils.search,
                        color: Theme.of(context).primaryColorDark)),
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
                              height: 16,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 24),
                                decoration: BoxDecoration(
                                    color: AppColor.vividYellow,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Text(
                                  S.of(context).addingContactsDesc,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                )),
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  itemBuilder: (context, index) {
                                    return ContactWidget(
                                      beneficiary: beneficiaryList.data![index],
                                      onTap: () async {
                                        if (model
                                                .arguments
                                                .beneficiaryList[index]
                                                .beneType ==
                                            "SM") {
                                          Navigator.pushNamed(context,
                                              RoutePaths.SendAmountToContact,
                                              arguments: model.arguments
                                                  .beneficiaryList[index]);
                                        } else if (model
                                                .arguments
                                                .beneficiaryList[index]
                                                .beneType ==
                                            "RTP") {
                                          Navigator.pushNamed(
                                              context,
                                              RoutePaths
                                                  .RequestAmountFromContact,
                                              arguments: model.arguments
                                                  .beneficiaryList[index]);
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
                                height: 96,
                                width: 96,
                                margin: EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle!
                                            .color!)),
                                child: Container(
                                    padding: EdgeInsets.all(32),
                                    child: AppSvg.asset(AssetUtils.contacts)),
                              ),
                              Text(
                                S.of(context).noContactsYetDesc,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
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
