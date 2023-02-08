import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';

import 'new_contact_added_page_view_model.dart';

class NewContactAddedPageView extends BasePageViewWidget<NewContactAddedPageViewModel> {
  NewContactAddedPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, NewContactAddedPageViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.only(top: 106.0.h, left: 20.w, right: 24.w, bottom: 55.h),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                    ? 0
                    : MediaQuery.of(context).viewInsets.bottom - 48),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          minRadius: 48,
                          child: Text(
                            StringUtils.getFirstInitials("Abdullah Ali"),
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 22.t,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // SizedBox(width: 69),
                        Icon(
                          Icons.star_border_outlined,
                          color: AppColor.sky_blue_mid,
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Abdullah Ali",
                      style: TextStyle(
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600,
                        color: AppColor.gray_black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Tap to edit photo",
                        style: TextStyle(
                          fontSize: 12.t,
                          fontWeight: FontWeight.w600,
                          color: AppColor.gray1,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    AppTextField(
                      labelText: S.current.nameOfBeneficiary.toUpperCase(),
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 16.0.h),
                    AppTextField(
                      labelText: S.current.emailAddress.toUpperCase(),
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 16.0.h),
                    AppTextField(
                      labelText: S.current.ibanORaccountORmobileORalias.toUpperCase(),
                      readOnly: true, enabled: false,
                      labelIcon: () {
                        return InkWell(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5.0.w),
                            child: Container(
                                height: 14.h,
                                width: 14.w,
                                child: AppSvg.asset(AssetUtils.info,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .focusedBorder!
                                        .borderSide
                                        .color)),
                          ),
                        );
                      },

                      //Todo : + add exclamation icon
                    ),
                    SizedBox(height: 40.0.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 64.h,
                              width: 64.h,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: AppSvg.asset(
                                  AssetUtils.viewHistoryIcon,
                                  color: AppColor.sky_blue_mid,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColor.sky_blue_mid,
                                  width: 1.5.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                "View History",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.t,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.gray_black,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 64.h,
                              width: 64.h,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: AppSvg.asset(
                                  AssetUtils.requestMoneyIcon,
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.sky_blue_mid,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColor.sky_blue_mid,
                                  width: 1.5.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                "Request Money",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.t,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.gray_black,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 64.h,
                              width: 64.h,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: AppSvg.asset(
                                  AssetUtils.sendMoneyIcon,
                                  color: AppColor.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.sky_blue_mid,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColor.sky_blue_mid,
                                  width: 1.5.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                "Send Money",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.t,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.gray_black,
                                ),
                              ),
                            )
                          ],
                        ),
                        // Image.asset(AssetUtils.requestMoneyIcon),
                        // Image.asset(AssetUtils.sendMoneyIcon),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
