import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ContactWidget extends StatelessWidget {
  final Beneficiary? beneficiary;
  final Function()? onTap;

  const ContactWidget({Key? key, this.beneficiary, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            child: Row(
              children: [
                beneficiary!.imageUrl.toString().isNotEmpty
                    ? CircleAvatar(
                        radius: 25.w,
                        backgroundImage: Image.memory(
                          beneficiary!.imageUrl,
                          fit: BoxFit.cover,
                        ).image,
                      )
                    : CircleAvatar(
                        radius: 25.w,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          beneficiary!.fullName!.split(" ").length > 1
                              ? StringUtils.getFirstInitials(beneficiary!.fullName)
                              : beneficiary!.fullName![0],
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.t,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                SizedBox(
                  width: 14.w,
                ),
                Expanded(
                  child: Text(
                    (beneficiary!.nickName != null && beneficiary!.nickName!.isNotEmpty)
                        ? beneficiary!.nickName!
                        : beneficiary!.fullName!,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h),
          child: Container(
            height: 1,
            color: AppColor.light_grayish_violet,
          ),
        ),
      ],
    );
  }
}
