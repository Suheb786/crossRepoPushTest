import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SettingsDialogView extends StatelessWidget {
  List<dynamic> pages = [];

  ProviderBase providerBase() {
    return settingsDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingsDialogViewModel>(
      builder: (context, model, child) {
        return AppStreamBuilder<bool>(
            stream: model!.onClickStream,
            initialData: false,
            dataBuilder: (context, onClick) {
              return AppStreamBuilder<int>(
                stream: model.currentStep,
                initialData: 0,
                dataBuilder: (context, currentStep) {
                  return AppStreamBuilder<Resource<ProfileInfoResponse>>(
                      stream: model.getProfileInfoStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, profileData) {
                        if (!(ProviderScope.containerOf(context)
                                .read(appHomeViewModelProvider)
                                .dashboardDataContent
                                .dashboardFeatures
                                ?.blinkRetailAppCliqAliasManagement ??
                            false)) {
                          pages = [
                            InkWell(
                              onTap: onClick!
                                  ? () async {
                                      ///LOG EVENT TO FIREBASE
                                      await FirebaseAnalytics.instance.logEvent(
                                          name: "payments_opened",
                                          parameters: {"is_payment_opened": true.toString()});
                                      Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                          arguments: NavigationType.DASHBOARD);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 0
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.paymentCircle,
                                            color: currentStep == 0
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).billsAndPayments,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 0
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onClick
                                  ? () {
                                      Navigator.pushNamed(context, RoutePaths.ActivityHome);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 1
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.activityCircle,
                                            color: currentStep == 1
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).activity,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 1
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onClick
                                  ? () {
                                      Navigator.pushNamed(context, RoutePaths.ManageContactsList);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 2
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.contacts,
                                            color: currentStep == 2
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).manageContactsSettings,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 2
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: onClick
                                    ? () {
                                        Navigator.pushNamed(context, RoutePaths.AccountSetting);
                                      }
                                    : () {},
                                child: Container(
                                  height: 174.0.h,
                                  width: 112.0.w,
                                  decoration: BoxDecoration(
                                      color: currentStep == 3
                                          ? Theme.of(context).textTheme.bodyLarge!.color!
                                          : Theme.of(context).colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 64.0.h,
                                          width: 64.0.w,
                                          padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                          margin: EdgeInsets.only(bottom: 16.0.h),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                          child: (profileData?.data?.content?.profileImage == null ||
                                                  profileData?.data?.content?.profileImage.isEmpty)
                                              ? Center(
                                                  child: Container(
                                                    child: AppStreamBuilder<String>(
                                                        stream: model.textStream,
                                                        initialData: "",
                                                        dataBuilder: (context, text) {
                                                          return Text(
                                                            StringUtils.getFirstInitials(text),
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 18.0.t,
                                                                color: currentStep == 3
                                                                    ? Theme.of(context).colorScheme.secondary
                                                                    : Theme.of(context).primaryColorDark),
                                                          );
                                                        }),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 48,
                                                  backgroundImage: Image.memory(
                                                    profileData?.data!.content!.profileImage!,
                                                    fit: BoxFit.cover,
                                                  ).image,
                                                )),
                                      Text(
                                        S.of(context).profileSettings,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w600,
                                            color: currentStep == 3
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark,
                                            fontSize: 12.0.t),
                                      )
                                    ],
                                  ),
                                )),
                            AppStreamBuilder<Resource<LogoutResponse>>(
                                stream: model.logoutStream,
                                initialData: Resource.none(),
                                onData: (response) {
                                  if (response.status == Status.SUCCESS) {
                                    AppConstantsUtils.resetCacheLists();
                                    if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
                                      AppConstantsUtils.isApplePayPopUpShown = false;
                                      AntelopHelper.walletDisconnect();
                                    }
                                    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding,
                                        ModalRoute.withName(RoutePaths.Splash));
                                  }
                                },
                                dataBuilder: (context, data) {
                                  return InkWell(
                                    onTap: onClick
                                        ? () {
                                            model.logout();
                                          }
                                        : () {},
                                    child: Container(
                                      height: 174.0.h,
                                      width: 112.0.w,
                                      decoration: BoxDecoration(
                                          color: currentStep == 4
                                              ? Theme.of(context).textTheme.bodyLarge!.color!
                                              : Theme.of(context).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 64.0.h,
                                              width: 64.0.w,
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                              margin: EdgeInsets.only(bottom: 16.0.h),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                              child: AppSvg.asset(AssetUtils.logout,
                                                  color: currentStep == 4
                                                      ? Theme.of(context).colorScheme.secondary
                                                      : Theme.of(context).primaryColorDark)),
                                          Text(
                                            S.of(context).logout,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w600,
                                                color: currentStep == 4
                                                    ? Theme.of(context).colorScheme.secondary
                                                    : Theme.of(context).primaryColorDark,
                                                fontSize: 12.0.t),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ];
                        } else {
                          pages = [
                            InkWell(
                              onTap: onClick!
                                  ? () async {
                                      ///LOG EVENT TO FIREBASE
                                      await FirebaseAnalytics.instance.logEvent(
                                          name: "payments_opened", parameters: {"is_payment_opened": "true"});
                                      Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                          arguments: NavigationType.DASHBOARD);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 0
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.paymentCircle,
                                            color: currentStep == 0
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).billsAndPayments,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 0
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onClick
                                  ? () {
                                      Navigator.pushNamed(context, RoutePaths.ActivityHome);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 1
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.activityCircle,
                                            color: currentStep == 1
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).activity,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 1
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onClick
                                  ? () {
                                      Navigator.pushNamed(context, RoutePaths.ManageContactsList);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 2
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.contacts,
                                            color: currentStep == 2
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).manageContactsSettings,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 2
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            ///CLIQ
                            InkWell(
                              onTap: onClick
                                  ? () {
                                      Navigator.pushNamed(context, RoutePaths.CliqIdList);
                                    }
                                  : () {},
                              child: Container(
                                height: 174.0.h,
                                width: 112.0.w,
                                decoration: BoxDecoration(
                                    color: currentStep == 3
                                        ? Theme.of(context).textTheme.bodyLarge!.color!
                                        : Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 64.0.h,
                                        width: 64.0.w,
                                        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                        margin: EdgeInsets.only(bottom: 16.0.h),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                        child: AppSvg.asset(AssetUtils.cliqLogoSvg,
                                            color: currentStep == 3
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark)),
                                    Text(
                                      S.of(context).manageCliqIdRoute,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          color: currentStep == 3
                                              ? Theme.of(context).colorScheme.secondary
                                              : Theme.of(context).primaryColorDark,
                                          fontSize: 12.0.t),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: onClick
                                    ? () {
                                        Navigator.pushNamed(context, RoutePaths.AccountSetting);
                                      }
                                    : () {},
                                child: Container(
                                  height: 174.0.h,
                                  width: 112.0.w,
                                  decoration: BoxDecoration(
                                      color: currentStep == 4
                                          ? Theme.of(context).textTheme.bodyLarge!.color!
                                          : Theme.of(context).colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 64.0.h,
                                          width: 64.0.w,
                                          padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                          margin: EdgeInsets.only(bottom: 16.0.h),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                          child: (profileData?.data?.content?.profileImage == null ||
                                                  profileData?.data?.content?.profileImage.isEmpty)
                                              ? Center(
                                                  child: Container(
                                                    child: AppStreamBuilder<String>(
                                                        stream: model.textStream,
                                                        initialData: "",
                                                        dataBuilder: (context, text) {
                                                          print("got text in stream: $text");
                                                          return Text(
                                                            StringUtils.getFirstInitials(text),
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 18.0.t,
                                                                color: currentStep == 4
                                                                    ? Theme.of(context).colorScheme.secondary
                                                                    : Theme.of(context).primaryColorDark),
                                                          );
                                                        }),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 48,
                                                  backgroundImage: Image.memory(
                                                    profileData?.data!.content!.profileImage!,
                                                    fit: BoxFit.cover,
                                                  ).image,
                                                )),
                                      Text(
                                        S.of(context).profileSettings,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w600,
                                            color: currentStep == 4
                                                ? Theme.of(context).colorScheme.secondary
                                                : Theme.of(context).primaryColorDark,
                                            fontSize: 12.0.t),
                                      )
                                    ],
                                  ),
                                )),
                            AppStreamBuilder<Resource<LogoutResponse>>(
                                stream: model.logoutStream,
                                initialData: Resource.none(),
                                onData: (response) {
                                  if (response.status == Status.SUCCESS) {
                                    AppConstantsUtils.resetCacheLists();
                                    if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
                                      AppConstantsUtils.isApplePayPopUpShown = false;
                                      AntelopHelper.walletDisconnect();
                                    }
                                    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding,
                                        ModalRoute.withName(RoutePaths.Splash));
                                  }
                                },
                                dataBuilder: (context, data) {
                                  return InkWell(
                                    onTap: onClick
                                        ? () {
                                            model.logout();
                                          }
                                        : () {},
                                    child: Container(
                                      height: 174.0.h,
                                      width: 112.0.w,
                                      decoration: BoxDecoration(
                                          color: currentStep == 5
                                              ? Theme.of(context).textTheme.bodyLarge!.color!
                                              : Theme.of(context).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 64.0.h,
                                              width: 64.0.w,
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                                              margin: EdgeInsets.only(bottom: 16.0.h),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: AppColor.whiteGrey, width: 1)),
                                              child: AppSvg.asset(AssetUtils.logout,
                                                  color: currentStep == 5
                                                      ? Theme.of(context).colorScheme.secondary
                                                      : Theme.of(context).primaryColorDark)),
                                          Text(
                                            S.of(context).logout,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w600,
                                                color: currentStep == 5
                                                    ? Theme.of(context).colorScheme.secondary
                                                    : Theme.of(context).primaryColorDark,
                                                fontSize: 12.0.t),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ];
                        }
                        return Dialog(
                          elevation: 0.0,
                          insetPadding: EdgeInsets.zero,
                          // insetPadding: EdgeInsets.only(
                          //     top: 512, bottom: 120, left: 100, right: 100),
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CarouselSlider.builder(
                                    itemCount: pages.length,
                                    carouselController: model.controller,
                                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                        Padding(
                                      padding: EdgeInsets.only(bottom: 5.0.h),
                                      child: AppTiltCard(
                                          pageViewIndex: pageViewIndex,
                                          degree: 8,
                                          currentPage: currentStep,
                                          child: pages[itemIndex]),
                                    ),
                                    options: CarouselOptions(
                                      height: 180.0.h,
                                      pageSnapping: true,
                                      viewportFraction: 0.4,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        model.updatePage(index);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 41.45.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: AppSvg.asset(AssetUtils.close,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                              SizedBox(
                                height: 50.0.h,
                              ),
                            ],
                          ),
                        );
                      });
                },
              );
            });
      },
      providerBase: providerBase(),
      onModelReady: (model) {
        model.loadingStream.listen((value) {
          if (value) {
            AppProgress(context);
          } else {
            Navigator.pop(context);
          }
        });

        model.error.listen((event) {
          if (event.type == ErrorType.UNAUTHORIZED_USER) {
            _showTopError(
                ErrorParser.getLocalisedStringError(
                  error: event,
                  localisedHelper: S.of(context),
                ),
                context);
            Navigator.pushNamedAndRemoveUntil(
                context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
          } else {
            _showTopError(
                ErrorParser.getLocalisedStringError(
                  error: event,
                  localisedHelper: S.of(context),
                ),
                context);
          }
        });
      },
    );
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              decoration: BoxDecoration(color: AppColor.dark_brown, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 16.0.w),
                          child: Text(message,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        reverseAnimationDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 700));
  }
}
