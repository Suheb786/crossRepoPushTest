import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BeneficiaryListWidget extends StatelessWidget {
  final Beneficiary? beneficiary;
  final Function()? onTap;

  const BeneficiaryListWidget({Key? key, this.beneficiary, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Row(
              children: [
                beneficiary?.imageUrl.isNotEmpty
                    ? Stack(clipBehavior: Clip.none, textDirection: TextDirection.rtl, children: [
                        CircleAvatar(
                          radius: 25.w,
                          backgroundImage: Image.memory(
                            beneficiary!.imageUrl,
                            fit: BoxFit.cover,
                          ).image,
                        ),
                      ])
                    : Stack(clipBehavior: Clip.none, textDirection: TextDirection.rtl, children: [
                        CircleAvatar(
                          radius: 25.w,
                          backgroundColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            StringUtils.getFirstInitials(beneficiary?.fullName),
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.t,
                                color: Theme.of(context).scaffoldBackgroundColor),
                          ),
                        ),
                      ]),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      beneficiary?.fullName ?? '',
                      style: TextStyle(
                          color: AppColor.black,
                          fontFamily: StringUtils.appFont,
                          fontSize: 16.t,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
                SizedBox(
                  width: 16.w,
                ),
                AppSvg.asset(AssetUtils.blueStar, matchTextDirection: true)
              ],
            ),
          ),
          AppDivider(),
        ],
      ),
    );
  }
}
