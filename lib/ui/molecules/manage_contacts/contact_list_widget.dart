import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ContactListWidget extends StatelessWidget {
  final Beneficiary? beneficiary;
  final Function()? onTap;

  const ContactListWidget({Key? key, this.beneficiary, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Row(
            children: [
              beneficiary!.imageUrl.toString().isNotEmpty
                  ? Stack(clipBehavior: Clip.none, textDirection: TextDirection.rtl, children: [
                      CircleAvatar(
                        radius: 25.w,
                        backgroundImage: Image.memory(
                          beneficiary!.imageUrl,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                      Positioned(
                        top: 35.h,
                        child: AppSvg.asset(
                          AssetUtils.blueStar,
                        ),
                      ),
                    ])
                  : Stack(clipBehavior: Clip.none, textDirection: TextDirection.rtl, children: [
                      CircleAvatar(
                        radius: 25.w,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          ///TODO:check whether full name
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
                      Positioned(
                        top: 35.h,
                        child: AppSvg.asset(
                          AssetUtils.blueStar,
                        ),
                      ),
                    ]),
              SizedBox(
                width: 14.w,
              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    (beneficiary!.nickName != null && beneficiary!.nickName!.isNotEmpty)
                        ? beneficiary!.nickName!
                        : beneficiary!.fullName!,
                    style: TextStyle(
                        color: AppColor.black,
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    (beneficiary!.nickName != null && beneficiary!.nickName!.isNotEmpty)
                        ? beneficiary!.nickName!
                        : beneficiary!.fullName!,
                    style: TextStyle(
                        color: AppColor.gray1,
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
              InkWell(
                onTap: () {
                  onTap?.call();
                },
                child: AppSvg.asset(AssetUtils.rightChevron,
                    width: 18.w,
                    height: 18.h,
                    matchTextDirection: true,
                    color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
              )
            ],
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
