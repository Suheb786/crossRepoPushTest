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
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/custom_svg_image.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_menu_widget.dart';
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
import 'dart:math' as math;

class SettingsDialogView extends StatefulWidget {
  @override
  State<SettingsDialogView> createState() => _SettingsDialogViewState();
}

class _SettingsDialogViewState extends State<SettingsDialogView> with SingleTickerProviderStateMixin {
  ProviderBase providerBase() {
    return settingsDialogViewModelProvider;
  }

  late PageController pageController;
  late AnimationController animationController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.3);
    animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingsDialogViewModel>(
      builder: (context, model, child) {
        return AppStreamBuilder<Resource<LogoutResponse>>(
            stream: model!.logoutStream,
            initialData: Resource.none(),
            onData: (response) {
              if (response.status == Status.SUCCESS) {
                AppConstantsUtils.resetCacheLists();
                if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
                  AppConstantsUtils.isApplePayPopUpShown = false;
                  AntelopHelper.walletDisconnect();
                }
                Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding, (route) => false);
              }
            },
            dataBuilder: (context, data) {
              return AppStreamBuilder<Resource<ProfileInfoResponse>>(
                  stream: model.getProfileInfoStream,
                  initialData: Resource.none(),
                  onData: (profileData) {
                    /// Main List
                    var currentPages = [
                      ///Bill payments
                      PagesWidget(
                          key: 'BILL_PAYMENTS',
                          child: SettingsMenuWidget(
                            model: model,
                            title: S.of(context).billsAndPayments,
                            image: AssetUtils.paymentCircle,
                            mKey: 'BILL_PAYMENTS',
                            onTap: () async {
                              ///LOG EVENT TO FIREBASE
                              await FirebaseAnalytics.instance.logEvent(
                                  name: "payments_opened", parameters: {"is_payment_opened": "true"});
                              Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                  arguments: NavigationType.DASHBOARD);
                            },
                          )),

                      ///Activity home
                      PagesWidget(
                        key: 'ACTIVITY',
                        child: SettingsMenuWidget(
                          model: model,
                          title: S.of(context).activity,
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.ActivityHome);
                          },
                          image: AssetUtils.activityCircle,
                          mKey: 'ACTIVITY',
                        ),
                      ),

                      ///Manage Contacts
                      PagesWidget(
                        key: 'MANAGE_CONTACTS',
                        child: SettingsMenuWidget(
                          model: model,
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.BeneficiaryContactsList,
                                arguments: NavigationType.SEND_MONEY);
                          },
                          mKey: 'MANAGE_CONTACTS',
                          title: S.of(context).manageContactsSettings,
                          image: AssetUtils.contacts,
                        ),
                      ),

                      ///CLIQ
                      PagesWidget(
                        key: 'CLIQ',
                        child: SettingsMenuWidget(
                          model: model,
                          mKey: 'CLIQ',
                          image: AssetUtils.cliqLogoSvg,
                          title: S.of(context).manageCliqIdRoute,
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.CliqIdList);
                          },
                        ),
                      ),

                      ///E-VOUCHERS
                      PagesWidget(
                        key: 'E-VOUCHERS',
                        child: SettingsMenuWidget(
                          model: model,
                          title: S.of(context).eVouchers,
                          image: AssetUtils.e_voucher,
                          mKey: 'E-VOUCHERS',
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.Evoucher);
                          },
                        ),
                      ),

                      ///Profile settings
                      PagesWidget(
                        key: 'SettingsMenuWidget',
                        child: SettingsMenuWidget(
                          model: model,
                          mKey: 'SettingsMenuWidget',
                          title: S.of(context).profileSettings,
                          image: AssetUtils.dummyProfile,
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.AccountSetting);
                          },
                          dynamicChild: (profileData.data?.content?.profileImage == null ||
                                  profileData.data?.content?.profileImage.isEmpty)
                              ? Center(
                                  child: Container(
                                    child: AppStreamBuilder<int>(
                                        stream: model.currentStep,
                                        initialData: 0,
                                        dataBuilder: (context, currentValue) {
                                          return AppStreamBuilder<String>(
                                              stream: model.textStream,
                                              initialData: "",
                                              dataBuilder: (context, text) {
                                                return Text(
                                                  StringUtils.getFirstInitials(text),
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 18.0.t,
                                                      color: model.getKeyByIndex(currentValue ?? 0) ==
                                                              'SettingsMenuWidget'
                                                          ? Theme.of(context).colorScheme.secondary
                                                          : Theme.of(context).primaryColorDark),
                                                );
                                              });
                                        }),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 48,
                                  backgroundImage: Image.memory(
                                    profileData.data!.content!.profileImage!,
                                    fit: BoxFit.cover,
                                  ).image,
                                ),
                        ),
                      ),

                      ///logout
                      PagesWidget(
                        key: 'LOGOUT',
                        child: SettingsMenuWidget(
                          model: model,
                          image: AssetUtils.logout,
                          title: S.of(context).logout,
                          mKey: 'LOGOUT',
                          onTap: () {
                            model.logout();
                          },
                        ),
                      ),
                    ];
                    model.updateShowPages(context: context, pages: currentPages);
                  },
                  dataBuilder: (context, profileData) {
                    return AppStreamBuilder<int>(
                        stream: model.currentStep,
                        initialData: 0,
                        dataBuilder: (context, currentValue) {
                          print('Show pages length----->${model.showPages.length}');
                          return Dialog(
                            elevation: 0.0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 180.h,
                                  child: PageView.builder(
                                    itemCount: (model.showPages).length,
                                    controller: pageController,
                                    physics: const ClampingScrollPhysics(),
                                    onPageChanged: (int value) {
                                      print('index------>$value');
                                      model.updatePage(value);
                                    },
                                    itemBuilder: (context, index) {
                                      print(
                                          'item builder index------>$index-----${model.showPages[index].key}');
                                      return AnimatedBuilder(
                                        animation: pageController,
                                        builder: (context, child) {
                                          double value = 0;

                                          ///Y coordinate
                                          double translateValue = 0;

                                          ///CheckipageController is ready to use
                                          if (pageController.position.hasContentDimensions) {
                                            ///For current page value = 0, so rotation and translation value is zero
                                            double indexFinal = index.toDouble();
                                            value = indexFinal - (pageController.page ?? 0);
                                            value = (value * 0.01);

                                            if (value.abs() >= 0.02) {
                                              translateValue = value.abs() * 500;
                                            } else if (value.abs() >= 0.018) {
                                              translateValue = value.abs() * 460;
                                            } else if (value.abs() >= 0.016) {
                                              translateValue = value.abs() * 420;
                                            } else if (value.abs() >= 0.014) {
                                              translateValue = value.abs() * 380;
                                            } else if (value.abs() >= 0.012) {
                                              translateValue = value.abs() * 340;
                                            } else {
                                              translateValue = value.abs() * 300;
                                            }
                                          }
                                          return Transform.rotate(
                                            angle: (math.pi * value),
                                            child: Transform.translate(
                                              offset: Offset(0, translateValue),
                                              child: _cards(currentValue ?? 0, model,
                                                  model.showPages[currentValue ?? 0].child),
                                            ),
                                          );
                                        },
                                      );
                                      // return _cards(
                                      //     0, model, model.showPages[0].child);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: 80.w,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondary,
                                      border:
                                          Border.all(color: Theme.of(context).primaryColorDark, width: 12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: AppSvg.asset(AssetUtils.close,
                                        color: Theme.of(context).textTheme.bodyLarge?.color),
                                  ),
                                ),
                                SizedBox(
                                  height: 24.0.h,
                                ),
                              ],
                            ),
                          );
                        });
                    ;
                  });
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

  int tappedMainMenuIndex = 0;
  Color tappedMainMenuColor = Colors.white;
  Color tappedMainMenuContentColor = Colors.black;

  _cards(int index, SettingsDialogViewModel model, Widget child) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   tappedMainMenuIndex = index;
        //   tappedMainMenuColor = AppColor.brightBlue;
        //   tappedMainMenuContentColor = Colors.white;
        // });
        // animationController.forward();
        // Future.delayed(const Duration(milliseconds: 50), () {
        //   setState(() {
        //     tappedMainMenuColor = Colors.white;
        //     tappedMainMenuContentColor = Colors.black;
        //   });
        //   animationController.reverse();
        //
        //   // Future.delayed(const Duration(milliseconds: 50),() {layoutViewModel.onClickMainMenu(index, context);});
        // });
      },
      onPanDown: (_) {
        // setState(() {
        //   tappedMainMenuIndex = index;
        //   tappedMainMenuColor = AppColor.brightBlue;
        //   tappedMainMenuContentColor = Colors.white;
        // });
        // animationController.forward();
      },
      onPanCancel: () {
        // setState(() {
        //   tappedMainMenuColor = Colors.white;
        //   tappedMainMenuContentColor = Colors.black;
        // });
        // animationController.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: index == tappedMainMenuIndex ? 0.95 : 1)
            .animate(animationController),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }
}

class PagesWidget {
  final String key;
  final Widget child;
  int? index;

  PagesWidget({required this.key, required this.child, this.index = 0});
}
