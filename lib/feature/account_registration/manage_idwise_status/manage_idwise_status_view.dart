import 'package:flutter/material.dart';
import 'package:neo_bank/feature/account_registration/manage_idwise_status/manage_idwise_status_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:riverpod/src/framework.dart';

import '../../../base/base_page.dart';
import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/account/idwise_processing_status_widget.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/string_utils.dart';
import '../../register/register_page.dart';

class ManageIDWiseStatusView extends BasePageViewWidget<ManageIDWiseStatusViewModel> {
  ManageIDWiseStatusView(ProviderBase providerBase) : super(providerBase);

  @override
  Widget build(BuildContext context, ManageIDWiseStatusViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 92.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AssetUtils.line,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 111.37.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.vividYellow,
                    ),
                    child: Center(child: AppSvg.asset(AssetUtils.right)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 56.h,
          ),
          Text(
            S.of(context).processingIDWiseStatus,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w500,
                fontSize: 24.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 16.h,
          ),
          AppStreamBuilder<bool>(
              stream: model.verifyNationalIDStream,
              initialData: false,
              onData: (passwordData) {},
              dataBuilder: (context, data) {
                return IDWiseProcessingStatusWidget(
                  label: S.of(context).verifyingYourNationalID,
                  isActivated: data!,
                );
              }),
          SizedBox(
            height: 16.h,
          ),
          AppStreamBuilder<bool>(
              stream: model.verifySelfieStream,
              initialData: false,
              onData: (passwordData) {
                if (passwordData) {
                 /* Future.delayed(Duration(milliseconds: 2000), () {
                    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.Registration, (route) => false,
                        arguments: RegisterPageParams());
                  });*/
                }
              },
              dataBuilder: (context, data) {
                return IDWiseProcessingStatusWidget(
                  label: S.of(context).validatingYourSelfie,
                  isActivated: data!,
                );
              }),
          Spacer(),
          Row(children: [
            AppSvg.asset(AssetUtils.info, color: Theme.of(context).colorScheme.secondary),
            Flexible(
              child: Text(
                S.of(context).donotLeavePage,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.t,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ])
        ],
      ),
    );
  }
}

/*
NationalIDStatusDialog.show(context,
isSwipeToCancel: false,
image:  AssetUtils.infoBlack,
title: S.current.unableVerifyYourID,
descriptionWidget: Text(
S.current.unableVerifyYourIDDescription,
style: TextStyle(
fontFamily: StringUtils.appFont,
fontSize: 14.t,
fontWeight: FontWeight.w400),
),
onDismissed: () {}, onSelected: () {
Navigator.pop(context);
});*/
