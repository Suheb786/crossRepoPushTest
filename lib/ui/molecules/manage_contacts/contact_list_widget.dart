import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ContactListWidget extends StatelessWidget {
  final Beneficiary? beneficiary;
  final Function()? onTap;

  const ContactListWidget({Key? key, this.beneficiary, this.onTap})
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
              beneficiary!.imageUrl.toString().isNotEmpty
                  ? CircleAvatar(
                      radius: 25,
                      backgroundImage: Image.memory(
                        beneficiary!.imageUrl,
                        fit: BoxFit.cover,
                      ).image,
                    )
                  : CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        ///TODO:check whether full name
                        StringUtils.getFirstInitials(beneficiary!.fullName),
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
                  (beneficiary!.nickName != null &&
                          beneficiary!.nickName!.isNotEmpty)
                      ? beneficiary!.nickName!
                      : beneficiary!.fullName!,
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
