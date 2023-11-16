import 'dart:io';
import 'dart:typed_data';

import 'package:data/di/local_module.dart';
import 'package:data/helper/antelop_helper.dart';
import 'package:data/helper/encrypt_decrypt_promo_code.dart';
import 'package:data/helper/key_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/constants/enum/evoucher_landing_page_navigation_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/evoucher/evoucher/evoucher_page.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contacts_list/beneficiary_contacts_list_page.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/card_item_widget.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../feature/account_settings/account_settings_page.dart';
import '../../../../../feature/manage_cliq_id/cliq_id_list/cliq_id_list_page.dart';
import '../../../../../main/navigation/cutom_route.dart';

class SettingsDialogView extends StatefulWidget {
  @override
  State<SettingsDialogView> createState() => _SettingsDialogViewState();
}

class _SettingsDialogViewState extends State<SettingsDialogView> {
  ProviderBase providerBase() {
    return settingsDialogViewModelProvider;
  }

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.3);

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
                SecureStorageHelper.instance.clearToken();
                ProviderScope.containerOf(appLevelKey.currentState!.context)
                    .read(localSessionService)
                    .stopTimer();
                if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
                  AntelopHelper.walletDisconnect();
                }
                Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding, (route) => false);
              }
            },
            dataBuilder: (context, data) {
              return AppStreamBuilder<Resource<User>>(
                  stream: model.currentUser,
                  initialData: Resource.none(),
                  onData: (currentUserData) async {
                    var currentPages = [
                      ///Bill payments
                      PagesWidget(
                          key: 'BILL_PAYMENTS',
                          onTap: () async {
                            ///LOG EVENT TO FIREBASE
                            await FirebaseAnalytics.instance
                                .logEvent(name: "payments_opened", parameters: {"is_payment_opened": "true"});
                            Navigator.pop(context);
                            Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                arguments: NavigationType.DASHBOARD);
                          },
                          child: SettingsMenuWidget(
                            model: model,
                            title: S.of(context).billsAndPayments,
                            image: AssetUtils.sendMoneyIcon,
                            mKey: 'BILL_PAYMENTS',
                          )),

                      ///Refer a friend
                      PagesWidget(
                        onTap: () {
                          InformationDialog.show(context,
                              image: AssetUtils.referIcon,
                              title: S.of(context).referFriend,
                              btnTitle: S.of(context).invite,
                              descriptionWidget: Text(
                                S.of(context).referFriendDescription("100"),
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .focusedBorder
                                        ?.borderSide
                                        .color),
                              ), onSelected: () async {
                            String userPromoCode = ProviderScope.containerOf(context)
                                    .read(appHomeViewModelProvider)
                                    .dashboardDataContent
                                    .userPromoCode ??
                                "";
                            String encryptPromoCode = EncryptDecryptPromoCode.encryptReferLink(
                                plainText: userPromoCode, keyString: KeyHelper.DECRYPTION_KEY);

                            model.getReferCode(userPromoCode: encryptPromoCode);

                            Navigator.pop(context);
                          }, onDismissed: () {
                            Navigator.pop(context);
                          });
                        },
                        key: 'REFER_A_FRIEND',
                        child: SettingsMenuWidget(
                          model: model,
                          title: S.of(context).referFriend,
                          image: AssetUtils.referIcon,
                          mKey: 'REFER_A_FRIEND',
                        ),
                      ),

                      ///Offers
                      PagesWidget(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(CustomRoute.swipeUpRoute(OfferForYouPage()));
                        },
                        key: 'OFFERS',
                        child: SettingsMenuWidget(
                          model: model,
                          title: S.of(context).forYou,
                          image: AssetUtils.forYou,
                          mKey: 'OFFERS',
                        ),
                      ),

                      ///E-VOUCHERS
                      PagesWidget(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            CustomRoute.swipeUpRoute(
                                EvoucherPage(EvoucherPageArguments(
                                    EvoucherLandingPageNavigationType.NORMAL_EVOUCHER_LANDING)),
                                routeName: RoutePaths.Evoucher),
                          );
                        },
                        key: 'E-VOUCHERS',
                        child: SettingsMenuWidget(
                          model: model,
                          title: S.of(context).eVouchers,
                          image: AssetUtils.e_voucher,
                          mKey: 'E-VOUCHERS',
                        ),
                      ),

                      ///Manage Contacts
                      PagesWidget(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(CustomRoute.swipeUpRoute(
                              BeneficiaryContactListPage(navigationType: NavigationType.SEND_MONEY)));
                        },
                        key: 'MANAGE_CONTACTS',
                        child: SettingsMenuWidget(
                          model: model,
                          mKey: 'MANAGE_CONTACTS',
                          title: S.of(context).manageContactsSettings,
                          image: AssetUtils.contacts,
                        ),
                      ),

                      ///CLIQ
                      PagesWidget(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                              CustomRoute.swipeUpRoute(CliqIdListPage(), routeName: RoutePaths.CliqIdList));
                        },
                        key: 'CLIQ',
                        child: SettingsMenuWidget(
                          model: model,
                          mKey: 'CLIQ',
                          image: AssetUtils.cliqLogoSvg,
                          title: S.of(context).manageCliqIdRoute,
                        ),
                      ),

                      ///Profile settings
                      PagesWidget(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(CustomRoute.swipeUpRoute(AccountSettingPage(),
                              routeName: RoutePaths.AccountSetting));
                        },
                        key: 'SettingsMenuWidget',
                        child: SettingsMenuWidget(
                          model: model,
                          mKey: 'SettingsMenuWidget',
                          title: S.of(context).profileSettings,
                          image: AssetUtils.dummyProfile,
                          dynamicChild: (currentUserData.data?.localProfileImageDB == null ||
                                  currentUserData.data?.localProfileImageDB?.isEmpty)
                              ? Center(
                                  child: Container(
                                    child: AppStreamBuilder<int>(
                                        stream: model.menuTappedIndexStream,
                                        initialData: -1,
                                        dataBuilder: (context, tappedMenuIndex) {
                                          return AppStreamBuilder<int>(
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
                                                            color: (currentValue == tappedMenuIndex &&
                                                                    "SettingsMenuWidget" ==
                                                                        model.getKeyByIndex(
                                                                            tappedMenuIndex ?? -1))
                                                                ? Theme.of(context).colorScheme.secondary
                                                                : Theme.of(context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color!),
                                                      );
                                                    });
                                              });
                                        }),
                                  ),
                                )
                              : AppStreamBuilder<Uint8List>(
                                  stream: model.showProfileImage,
                                  initialData: Uint8List(0),
                                  dataBuilder: (context, image) {
                                    return (image != null && (image).isNotEmpty)
                                        ? CircleAvatar(
                                            radius: 48,
                                            backgroundImage: Image.memory(
                                              image,
                                              fit: BoxFit.cover,
                                            ).image,
                                          )
                                        : Container();
                                  }),
                        ),
                      ),

                      ///logout
                      PagesWidget(
                        onTap: () {
                          model.logout();
                        },
                        key: 'LOGOUT',
                        child: SettingsMenuWidget(
                          model: model,
                          image: AssetUtils.logout,
                          title: S.of(context).logout,
                          mKey: 'LOGOUT',
                        ),
                      ),
                    ];
                    model.updateShowPages(context: context, pages: currentPages);

                    /// Main List
                  },
                  dataBuilder: (context, userData) {
                    return AppStreamBuilder<Resource<ProfileInfoResponse>>(
                        stream: model.getProfileInfoStream,
                        initialData: Resource.none(),
                        onData: (profileData) {
                          /// Main List
                          var currentPages = [
                            ///Bill payments
                            PagesWidget(
                                key: 'BILL_PAYMENTS',
                                onTap: () async {
                                  ///LOG EVENT TO FIREBASE
                                  await FirebaseAnalytics.instance.logEvent(
                                      name: "payments_opened", parameters: {"is_payment_opened": "true"});
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                      arguments: NavigationType.DASHBOARD);
                                },
                                child: SettingsMenuWidget(
                                  model: model,
                                  title: S.of(context).billsAndPayments,
                                  image: AssetUtils.sendMoneyIcon,
                                  mKey: 'BILL_PAYMENTS',
                                )),

                            ///Refer a friend
                            PagesWidget(
                              onTap: () {
                                InformationDialog.show(context,
                                    image: AssetUtils.referIcon,
                                    title: S.of(context).referFriend,
                                    btnTitle: S.of(context).invite,
                                    descriptionWidget: Text(
                                      S.of(context).referFriendDescription("100"),
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .inputDecorationTheme
                                              .focusedBorder
                                              ?.borderSide
                                              .color),
                                    ), onSelected: () async {
                                  String userPromoCode = ProviderScope.containerOf(context)
                                          .read(appHomeViewModelProvider)
                                          .dashboardDataContent
                                          .userPromoCode ??
                                      "";

                                  String encryptPromoCode = EncryptDecryptPromoCode.encryptReferLink(
                                      plainText: userPromoCode, keyString: KeyHelper.DECRYPTION_KEY);

                                  model.getReferCode(userPromoCode: encryptPromoCode);

                                  Navigator.pop(context);
                                }, onDismissed: () {
                                  Navigator.pop(context);
                                });
                              },
                              key: 'REFER_A_FRIEND',
                              child: SettingsMenuWidget(
                                model: model,
                                title: S.of(context).referFriend,
                                image: AssetUtils.referIcon,
                                mKey: 'REFER_A_FRIEND',
                              ),
                            ),

                            ///Offers
                            PagesWidget(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(CustomRoute.swipeUpRoute(OfferForYouPage()));
                              },
                              key: 'OFFERS',
                              child: SettingsMenuWidget(
                                model: model,
                                title: S.of(context).forYou,
                                image: AssetUtils.forYou,
                                mKey: 'OFFERS',
                              ),
                            ),

                            ///E-VOUCHERS
                            PagesWidget(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  CustomRoute.swipeUpRoute(
                                      EvoucherPage(EvoucherPageArguments(
                                          EvoucherLandingPageNavigationType.NORMAL_EVOUCHER_LANDING)),
                                      routeName: RoutePaths.Evoucher),
                                );
                              },
                              key: 'E-VOUCHERS',
                              child: SettingsMenuWidget(
                                model: model,
                                title: S.of(context).eVouchers,
                                image: AssetUtils.e_voucher,
                                mKey: 'E-VOUCHERS',
                              ),
                            ),

                            ///Manage Contacts
                            PagesWidget(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(CustomRoute.swipeUpRoute(
                                    BeneficiaryContactListPage(navigationType: NavigationType.SEND_MONEY)));
                              },
                              key: 'MANAGE_CONTACTS',
                              child: SettingsMenuWidget(
                                model: model,
                                mKey: 'MANAGE_CONTACTS',
                                title: S.of(context).manageContactsSettings,
                                image: AssetUtils.contacts,
                              ),
                            ),

                            ///CLIQ
                            PagesWidget(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(CustomRoute.swipeUpRoute(CliqIdListPage(),
                                    routeName: RoutePaths.CliqIdList));
                              },
                              key: 'CLIQ',
                              child: SettingsMenuWidget(
                                model: model,
                                mKey: 'CLIQ',
                                image: AssetUtils.cliqLogoSvg,
                                title: S.of(context).manageCliqIdRoute,
                              ),
                            ),

                            ///Profile settings
                            PagesWidget(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(CustomRoute.swipeUpRoute(AccountSettingPage(),
                                    routeName: RoutePaths.AccountSetting));
                              },
                              key: 'SettingsMenuWidget',
                              child: SettingsMenuWidget(
                                model: model,
                                mKey: 'SettingsMenuWidget',
                                title: S.of(context).profileSettings,
                                image: AssetUtils.dummyProfile,
                                dynamicChild: (profileData.data?.content?.localProfileImageDB == null ||
                                        profileData.data?.content?.localProfileImageDB.isEmpty)
                                    ? Center(
                                        child: Container(
                                          child: AppStreamBuilder<int>(
                                              stream: model.menuTappedIndexStream,
                                              initialData: -1,
                                              dataBuilder: (context, tappedMenuIndex) {
                                                return AppStreamBuilder<int>(
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
                                                                  color: (currentValue == tappedMenuIndex &&
                                                                          "SettingsMenuWidget" ==
                                                                              model.getKeyByIndex(
                                                                                  tappedMenuIndex ?? -1))
                                                                      ? Theme.of(context)
                                                                          .colorScheme
                                                                          .secondary
                                                                      : Theme.of(context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .color!),
                                                            );
                                                          });
                                                    });
                                              }),
                                        ),
                                      )
                                    : AppStreamBuilder<Uint8List>(
                                        stream: model.showProfileImage,
                                        initialData: Uint8List(0),
                                        dataBuilder: (context, image) {
                                          return (image != null && (image).isNotEmpty)
                                              ? CircleAvatar(
                                                  radius: 48,
                                                  backgroundImage: Image.memory(
                                                    image,
                                                    fit: BoxFit.cover,
                                                  ).image,
                                                )
                                              : Container();
                                        }),
                              ),
                            ),

                            ///logout
                            PagesWidget(
                              onTap: () {
                                model.logout();
                              },
                              key: 'LOGOUT',
                              child: SettingsMenuWidget(
                                model: model,
                                image: AssetUtils.logout,
                                title: S.of(context).logout,
                                mKey: 'LOGOUT',
                              ),
                            ),
                          ];
                          model.updateShowPages(context: context, pages: currentPages);
                        },
                        dataBuilder: (context, profileData) {
                          return AppStreamBuilder<Resource<String>>(
                              initialData: Resource.none(),
                              stream: model.referDynamicLinkStream,
                              onData: (data) async {
                                if (data.status == Status.SUCCESS) {
                                  if (data.data != null) {
                                    await Share.share(S.of(context).shareReferDescription(data.data ?? ''),
                                        subject: S.of(context).referralLink);
                                  }
                                }
                              },
                              dataBuilder: (context, snapshot) {
                                return AppStreamBuilder<int>(
                                    stream: model.currentStep,
                                    initialData: 0,
                                    dataBuilder: (context, currentValue) {
                                      int itemCount = model.showPages.length;
                                      return Dialog(
                                        elevation: 0.0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.4),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: itemCount <= 6 ? 350.h : 540.h,
                                              width: double.maxFinite,
                                              child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(),
                                                child: Wrap(
                                                  runSpacing: 8.h,
                                                  spacing: 8.w,
                                                  alignment: WrapAlignment.center,
                                                  children: List.generate(itemCount, (index) {
                                                    return Container(
                                                      height: 147.h,
                                                      child: _cards(index, model, model.showPages[index],
                                                          currentValue ?? -1),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(15),
                                                height: 56.w,
                                                width: 56.w,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  // border: Border.all(
                                                  //     color: Theme.of(context).primaryColorDark, width: 12),
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
                              });
                        });
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
            SecureStorageHelper.instance.clearToken();
            AppConstantsUtils.resetCacheLists();
            ProviderScope.containerOf(appLevelKey.currentState!.context)
                .read(localSessionService)
                .stopTimer();
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

  _cards(int index, SettingsDialogViewModel model, PagesWidget pageWidget, int currentPage) {
    return CardItemWidget(
      model,
      pageWidget,
      index,
      key: ValueKey(index),
    ); /*AppStreamBuilder<bool>(
        stream: model.onClickStream,
        initialData: false,
        dataBuilder: (context, onClick) {
          return GestureDetector(
            onTap: (onClick ?? false)
                ? () async {
                    model.tappedIndex = index;
                    model.menuTapped(index);
                    animationController.forward();
                    await Future.delayed(const Duration(milliseconds: 100), () {
                      model.tappedIndex = -1;
                      model.menuTapped(-1);
                      animationController.reverse();
                      pageWidget.onTap?.call();
                    });
                  }
                : null,
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: index == currentPage ? 0.95 : 1)
                  .animate(animationController),
              child: pageWidget.child,
            ),
          );
        })*/
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}

class PagesWidget {
  final String key;
  final Widget child;
  int? index;
  Function()? onTap;

  PagesWidget({required this.key, required this.child, this.index = 0, this.onTap});
}
