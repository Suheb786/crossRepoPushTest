import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class SettingsDialogView extends StatelessWidget {
  List<dynamic> pages = [];

  ProviderBase providerBase() {
    return settingsDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingsDialogViewModel>(
        builder: (context, model, child) {
          return AppStreamBuilder<int>(
            stream: model!.currentStep,
            initialData: 0,
            dataBuilder: (context, currentStep) {
              pages = [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.PaymentHome);
                  },
                  child: Container(
                    height: 174,
                    width: 112,
                    decoration: BoxDecoration(
                        color: currentStep == 0
                            ? Theme.of(context).accentTextTheme.bodyText1!.color
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 64,
                            width: 64,
                            padding: EdgeInsets.all(14),
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor.whiteGrey, width: 1)),
                            child: AppSvg.asset(AssetUtils.paymentCircle,
                                color: currentStep == 0
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColorDark)),
                        Text(
                          S.of(context).payments,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: currentStep == 0
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColorDark,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.ActivityHome);
                  },
                  child: Container(
                    height: 174,
                    width: 112,
                    decoration: BoxDecoration(
                        color: currentStep == 1
                            ? Theme.of(context).accentTextTheme.bodyText1!.color
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 64,
                            width: 64,
                            padding: EdgeInsets.all(14),
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor.whiteGrey, width: 1)),
                            child: AppSvg.asset(AssetUtils.activityCircle,
                                color: currentStep == 1
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColorDark)),
                        Text(
                          S.of(context).activity,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: currentStep == 1
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColorDark,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.ManageContactsList);
                  },
                  child: Container(
                    height: 174,
                    width: 112,
                    decoration: BoxDecoration(
                        color: currentStep == 2
                            ? Theme.of(context).accentTextTheme.bodyText1!.color
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 64,
                            width: 64,
                            padding: EdgeInsets.all(14),
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor.whiteGrey, width: 1)),
                            child: AppSvg.asset(AssetUtils.contacts,
                                color: currentStep == 2
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColorDark)),
                        Text(
                          S.of(context).manageContactsSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: currentStep == 2
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColorDark,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.AccountSetting);
                  },
                  child: Container(
                    height: 174,
                    width: 112,
                    decoration: BoxDecoration(
                        color: currentStep == 3
                            ? Theme.of(context).accentTextTheme.bodyText1!.color
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 64,
                            width: 64,
                            // padding: EdgeInsets.all(14),
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor.whiteGrey, width: 1)),
                            child: Image.asset(
                              AssetUtils.dummyProfile,
                              // color: currentStep == 1
                              //     ? Theme.of(context).accentColor
                              //     : Theme.of(context)
                              //         .primaryColorDark
                            )),
                        Text(
                          S.of(context).profileSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: currentStep == 3
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColorDark,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 174,
                  width: 112,
                  decoration: BoxDecoration(
                      color: currentStep == 4
                          ? Theme.of(context).accentTextTheme.bodyText1!.color
                          : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 64,
                          width: 64,
                          padding: EdgeInsets.all(14),
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.whiteGrey, width: 1)),
                          child: AppSvg.asset(AssetUtils.logout,
                              color: currentStep == 4
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColorDark)),
                      Text(
                        S.of(context).logout,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: currentStep == 4
                                ? Theme.of(context).accentColor
                                : Theme.of(context).primaryColorDark,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ];
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
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: AppTiltCard(
                                pageViewIndex: pageViewIndex,
                                degree: 8,
                                currentPage: currentStep,
                                child: pages[itemIndex]),
                          ),
                          options: CarouselOptions(
                            height: 180,
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
                      height: 41.45,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AppSvg.asset(AssetUtils.close,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            },
          );
        },
        providerBase: providerBase());
  }
}
