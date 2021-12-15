import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/contact_list_widget.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ManageContactListPageView
    extends BasePageViewWidget<ManageContactListPageViewModel> {
  ManageContactListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ManageContactListPageViewModel model) {
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
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 24),
              height: 4,
              width: 64,
              decoration: BoxDecoration(
                  color: AppColor.whiteGray,
                  borderRadius: BorderRadius.circular(4)),
            ),
            AppTextField(
              labelText: '',
              controller: model.contactSearchController,
              textFieldBorderColor:
                  Theme.of(context).textTheme.bodyText1!.color,
              hintTextColor: Theme.of(context).textTheme.bodyText1!.color,
              textColor: Theme.of(context).primaryColorDark,
              hintText: S.of(context).searchContacts,
              onChanged: (value) {},
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
            SizedBox(
              height: 16,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                    color: AppColor.vividYellow,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  S.of(context).addingContactsDesc,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark),
                )),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.08),
                        blurRadius: 20.0,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {
                    return ContactListWidget(
                      contactsListModel: model.contactList[index],
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutePaths.ManageContactsDetail,
                            arguments: model.contactList[index]);
                      },
                    );
                  },
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: model.contactList.length,
                ),
              ),
            )
          ],
        ));
  }
}
