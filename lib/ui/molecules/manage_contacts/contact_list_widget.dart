import 'package:flutter/material.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ContactListWidget extends StatelessWidget {
  final ContactsListModel? contactsListModel;
  final Function()? onTap;

  const ContactListWidget({Key? key, this.contactsListModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Row(
            children: [
              contactsListModel!.imageUrl!.isNotEmpty
                  ? CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(contactsListModel!.imageUrl!))
                  : CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        StringUtils.getFirstInitials(contactsListModel!.name),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
              SizedBox(
                width: 14,
              ),
              Expanded(
                child: Text(
                  contactsListModel!.name!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  onTap?.call();
                },
                child: AppSvg.asset(AssetUtils.rightChevron,
                    width: 18,
                    height: 18,
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .hintStyle!
                        .color),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            height: 1,
            color: AppColor.light_grayish_violet,
          ),
        ),
      ],
    );
  }
}
