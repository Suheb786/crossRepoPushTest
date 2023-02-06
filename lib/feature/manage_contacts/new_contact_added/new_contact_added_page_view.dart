import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
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
        padding: EdgeInsets.only(top: 106.0.h, left: 20.w, right: 24.w, bottom: 45.h),
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
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      minRadius: 48,
                    ),
                    Text(
                      "Abdullah Ali",
                      style: TextStyle(
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600,
                        color: AppColor.gray_black,
                      ),
                    ),
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

                      //Todo : + add exclamation icon
                    ),
                    SizedBox(height: 40.0.h),
                    Row(
                      children: [
                        Image.asset(
                          AssetUtils.requestMoneyIcon,
                          scale: 1.5,
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
