// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/constants/enum/cliq_alias_type_enum.dart';
import 'package:domain/constants/enum/cliq_list_action_type_enum.dart';
import 'package:domain/model/cliq/change_default_account/change_default_account_otp.dart';
import 'package:domain/model/cliq/delete_cliq_id/delete_cliq_id_otp.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/model/cliq/re_activate_cliq_id/re_activate_cliq_id_otp.dart';
import 'package:domain/model/cliq/suspend_cliq_id/suspend_cliq_id_otp.dart';
import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_cliq_id_mobile_no/edit_cliq_id_mobile_no_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/link_account/link_account_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_information_dialog/cliq_information_dialog.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/alias_card_list_widget.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/manage_cliq_bottom_sheet_selection_widget.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/update_cliq_info_bottom_sheet_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

import 'otp_for_cliq_id_list/otp_for_cliq_id_page.dart';

class CliqIdListPageView extends BasePageViewWidget<CliqIdListPageViewModel> {
  CliqIdListPageView(ProviderBase model) : super(model);

  void _shareFiles(
    BuildContext context, {
    required String s,
    required String s2,
  }) async {
    // final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      S.of(context).hereMyCliqDetails + '${s}' + S.of(context).getYourBlinkAccountTodayBlinkNow + "\n$s2",

      subject: S.current.shareAccountInfo,
      // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    );
  }

  @override
  Widget build(BuildContext context, CliqIdListPageViewModel model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        int sensitivity = 8;
        if (details.primaryVelocity! > sensitivity) {
          Navigator.pop(context);
        } else if (details.primaryVelocity! < -sensitivity) {}
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
              height: 4.h,
              width: 64.w,
              decoration: BoxDecoration(color: AppColor.white_gray, borderRadius: BorderRadius.circular(4)),
            ),
            AppStreamBuilder<Resource<GetAlias>>(
              initialData: Resource.none(),
              stream: model.getAliasStream,
              dataBuilder: (context, getAliasSnapshot) {
                return AppStreamBuilder<Resource<ChangeDefaultAccountOtp>>(
                    stream: model.changeDefaultCliqIdOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        if (data.data != null) {
                          Navigator.pushNamed(context, RoutePaths.OtpForCliqIdListPage,
                              arguments: OtpForCliqIdListPageArguments(
                                  cliqListActionTypeEnum: CliqListActionTypeEnum.DEFAULT,
                                  aliasId: model.aliasId,
                                  accountId: model.accountId,
                                  aliasName: model.aliasName,
                                  mobileCode: data.data?.mobileCode ?? '',
                                  mobileNumber: data.data?.mobileNumber ?? ''));
                        }
                      }
                    },
                    dataBuilder: (context, snapshot) {
                      return AppStreamBuilder<Resource<ReActivateCliqIdOtp>>(
                        initialData: Resource.none(),
                        stream: model.reactivateCliqIDOtpStream,
                        onData: (value) {
                          if (value.status == Status.SUCCESS) {
                            if (value.data != null) {
                              Navigator.pushNamed(context, RoutePaths.OtpForCliqIdListPage,
                                  arguments: OtpForCliqIdListPageArguments(
                                      cliqListActionTypeEnum: CliqListActionTypeEnum.REACTIVATED,
                                      aliasId: model.aliasId,
                                      accountId: model.accountId,
                                      aliasName: model.aliasName,
                                      mobileCode: value.data?.mobileCode ?? '',
                                      mobileNumber: value.data?.mobileNumber ?? ''));
                            }
                          }
                        },
                        dataBuilder: (context, reactivateSnapshot) {
                          return AppStreamBuilder<Resource<SuspendCliqIdOtp>>(
                            initialData: Resource.none(),
                            stream: model.suspandCliqIdOtpStream,
                            onData: (value) {
                              if (value.status == Status.SUCCESS) {
                                if (value.data != null) {
                                  Navigator.pushNamed(context, RoutePaths.OtpForCliqIdListPage,
                                      arguments: OtpForCliqIdListPageArguments(
                                          cliqListActionTypeEnum: CliqListActionTypeEnum.SUSPENDEDCLIQ,
                                          aliasId: model.aliasId,
                                          accountId: model.accountId,
                                          aliasName: model.aliasName,
                                          mobileCode: value.data?.mobileCode ?? '',
                                          mobileNumber: value.data?.mobileNumber ?? ''));
                                }
                              }
                            },
                            dataBuilder: (context, suspnadSnapshot) {
                              return AppStreamBuilder<Resource<DeleteCliqIdOtp>>(
                                initialData: Resource.none(),
                                stream: model.deleteCliqIdOtpStream,
                                onData: (value) {
                                  if (value.status == Status.SUCCESS) {
                                    if (value.data != null) {
                                      Navigator.pushNamed(context, RoutePaths.OtpForCliqIdListPage,
                                          arguments: OtpForCliqIdListPageArguments(
                                              cliqListActionTypeEnum: CliqListActionTypeEnum.DELETECLIQ,
                                              aliasId: model.aliasId,
                                              accountId: model.accountId,
                                              aliasName: model.aliasName,
                                              mobileNumber: value.data?.mobileNumber ?? '',
                                              mobileCode: value.data?.mobileCode ?? ''));
                                    }
                                  }
                                },
                                dataBuilder: (context, deleteSnapshot) {
                                  return AppStreamBuilder<Resource<UnlinkCliqIdOtp>>(
                                    initialData: Resource.none(),
                                    stream: model.unlinkCliqIdOtpStream,
                                    onData: (unlinkData) {
                                      if (unlinkData.status == Status.SUCCESS) {
                                        if (unlinkData.data != null) {
                                          Navigator.pushNamed(context, RoutePaths.OtpForCliqIdListPage,
                                              arguments: OtpForCliqIdListPageArguments(
                                                  cliqListActionTypeEnum: CliqListActionTypeEnum.UNLINKCLIQ,
                                                  aliasId: model.aliasId,
                                                  accountId: model.accountId,
                                                  aliasName: model.aliasName,
                                                  mobileCode: unlinkData.data?.mobileCode ?? '',
                                                  mobileNumber: unlinkData.data?.mobileNumber ?? ''));
                                        }
                                      }
                                    },
                                    dataBuilder: (context, data) {
                                      switch (getAliasSnapshot?.status) {
                                        case Status.SUCCESS:
                                          return ((getAliasSnapshot?.data?.aliases ?? []).isNotEmpty)
                                              ? Expanded(
                                                  child: ListView.separated(
                                                    physics: ClampingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (context, index) {
                                                      return AliasCardList(
                                                        cliqAliasIdStatusEnum:
                                                            getAliasSnapshot!.data!.aliases?[index].status ??
                                                                CliqAliasIdStatusEnum.NONE,
                                                        accountList: (getAliasSnapshot
                                                                .data?.aliases?[index].accounts ??
                                                            []),
                                                        aliasName:
                                                            "${getAliasSnapshot.data?.aliases?[index].aliasName ?? ""}",
                                                        aliasType:
                                                            "${getAliasSnapshot.data?.aliases?[index].aliasType?.fromCliqAliasString()}",
                                                        status: model.getStatus(
                                                            getAliasSnapshot.data?.aliases?[index].status,
                                                            context),
                                                        // "${getAliasSnapshot.data?.aliases?[index].status}",
                                                        onTapAccount: (accountData) {
                                                          ///for checking active aliases and default account status
                                                          if (getAliasSnapshot.data?.aliases?[index].status ==
                                                                  CliqAliasIdStatusEnum.ACTIVE &&
                                                              !(accountData.isDefault ?? false)) {
                                                            ManageCliqBottomSheetSelectionWidget.show(context,
                                                                showSetAsDefault: !(accountData.isDefault ??
                                                                    false), setAsDefault: () {
                                                              Navigator.pop(context);
                                                              CliqInformationDialog.show(context,
                                                                  image: AssetUtils.walletIcon,
                                                                  title: S.of(context).changeDefaultAccount,
                                                                  description: S
                                                                      .of(context)
                                                                      .areYourToChangeDefaultAccountOfYourCliqId,
                                                                  subDescription: S
                                                                      .of(context)
                                                                      .whenAcceptingCreationOfYourCliqId,
                                                                  onSelected: () {
                                                                model.aliasId = (getAliasSnapshot
                                                                        .data?.aliases?[index].aliasID) ??
                                                                    "";
                                                                model.accountId =
                                                                    (accountData.recordId) ?? "";
                                                                model.aliasName = '';
                                                                Navigator.pop(context);
                                                                model.confirmChangeDefaultCliqIdOtp(
                                                                  aliasId: model.aliasId,
                                                                  acc: model.accountId,
                                                                );
                                                              }, onDismissed: () {
                                                                Navigator.pop(context);
                                                              });
                                                            }, unlinkAccount: () {
                                                              Navigator.pop(context);
                                                              InformationDialog.show(context,
                                                                  image: AssetUtils.unlinkIcon,
                                                                  title: S.current.unLinkAccountWithCliqId,
                                                                  descriptionWidget: Text(
                                                                    S.current.areYouSureToUnlinkAccount,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.t,
                                                                        color: AppColor.veryDarkGray1,
                                                                        fontWeight: FontWeight.w400),
                                                                  ),
                                                                  onSelected: () {
                                                                    model.aliasId = (getAliasSnapshot
                                                                            .data?.aliases?[index].aliasID) ??
                                                                        "";
                                                                    model.accountId =
                                                                        (accountData.recordId) ?? "";

                                                                    model.aliasName = '';
                                                                    Navigator.pop(context);
                                                                    model.unlinkCliqIdOtp(
                                                                      getToken: true,
                                                                      aliasId: model.aliasId,
                                                                      accountId: model.accountId,
                                                                    );
                                                                  },
                                                                  isSwipeToCancel: true,
                                                                  onDismissed: () {
                                                                    Navigator.pop(context);
                                                                  });
                                                            }, onCancelled: () {
                                                              Navigator.pop(context);
                                                            }, title: S.of(context).pleaseSelectYourAction);
                                                          } else {}
                                                        },
                                                        onTapAlias: () {
                                                          UpdateCliqInfoBottomSheetSelectionWidget.show(
                                                              context,
                                                              showLinkAccount: (getAliasSnapshot
                                                                                  .data
                                                                                  ?.aliases?[index]
                                                                                  .accounts ??
                                                                              [])
                                                                          .length ==
                                                                      0
                                                                  ? true
                                                                  : false,
                                                              cliqAliasIdStatusEnum: getAliasSnapshot
                                                                      .data?.aliases?[index].status ??
                                                                  CliqAliasIdStatusEnum.NONE, onLinkId: () {
                                                            Navigator.pop(context);
                                                            Navigator.pushNamed(
                                                                context, RoutePaths.LinkAccountPage,
                                                                arguments: LinkAccountPageArgument(
                                                                    aliasId: getAliasSnapshot
                                                                            .data?.aliases?[index].aliasID ??
                                                                        '',
                                                                    aliasValue: getAliasSnapshot.data
                                                                            ?.aliases?[index].aliasName ??
                                                                        '',
                                                                    isAlias: getAliasSnapshot.data
                                                                            ?.aliases?[index].aliasType ==
                                                                        CliqAliasTypeEnum.ALIAS,
                                                                    getToken: true,
                                                                    linkType: (getAliasSnapshot.data
                                                                                ?.aliases?[index].aliasType ==
                                                                            CliqAliasTypeEnum.ALIAS)
                                                                        ? 'A'
                                                                        : 'M'));
                                                          }, onActivatId: () {
                                                            Navigator.pop(context);
                                                            CliqInformationDialog.show(context,
                                                                isSwipeToCancel: true,
                                                                image: AssetUtils.reactivateIcon,
                                                                title: S.current.reactivateCliqId,
                                                                description: S
                                                                    .of(context)
                                                                    .areYourToChangeDefaultAccountOfYourCliqId,
                                                                subDescription: S
                                                                    .of(context)
                                                                    .whenAcceptingCreationOfYourCliqId,
                                                                onSelected: () {
                                                              Navigator.pop(context);
                                                              model.aliasName = getAliasSnapshot
                                                                      .data?.aliases?[index].aliasName ??
                                                                  '';
                                                              model.aliasId = (getAliasSnapshot
                                                                      .data?.aliases?[index].aliasID) ??
                                                                  "";
                                                              model.accountId = '';
                                                              model.reactivatetCliqIDOtp(
                                                                aliasId: (getAliasSnapshot
                                                                        .data?.aliases?[index].aliasID) ??
                                                                    "",
                                                                getToken: true,
                                                              );
                                                            }, onDismissed: () {
                                                              Navigator.pop(context);
                                                            });
                                                          }, onEditId: () {
                                                            Navigator.pop(context);
                                                            if (getAliasSnapshot
                                                                    .data?.aliases?[index].aliasType ==
                                                                CliqAliasTypeEnum.MOBL) {
                                                              Navigator.pushNamed(
                                                                  context, RoutePaths.EditCliqIDMobileNoPage,
                                                                  arguments: EditCliqIDMobileNoPageArguments(
                                                                      aliasID: (getAliasSnapshot.data
                                                                              ?.aliases?[index].aliasID) ??
                                                                          "",
                                                                      aliasName: (getAliasSnapshot.data
                                                                              ?.aliases?[index].aliasName) ??
                                                                          ""));
                                                            } else if (getAliasSnapshot
                                                                    .data?.aliases?[index].aliasType ==
                                                                CliqAliasTypeEnum.ALIAS) {
                                                              Navigator.pushNamed(
                                                                  context, RoutePaths.EditAlias,
                                                                  arguments: EditAliasPageArguments(
                                                                      aliasID: (getAliasSnapshot.data
                                                                              ?.aliases?[index].aliasID) ??
                                                                          "",
                                                                      aliasName: (getAliasSnapshot.data
                                                                              ?.aliases?[index].aliasName) ??
                                                                          ""));
                                                            }
                                                          }, onShareId: () {
                                                            Platform.isAndroid
                                                                ? _shareFiles(context,
                                                                    s:
                                                                        "${S.of(context).cliqIdType} - ${getAliasSnapshot.data?.aliases?[index].aliasType?.fromCliqAliasString()} \n${S.of(context).cliqID} - ${getAliasSnapshot.data?.aliases?[index].aliasName}",
                                                                    s2:
                                                                        "${AppConstantsUtils.PLAY_STORE_URL} ")
                                                                : Platform.isIOS
                                                                    ? _shareFiles(context,
                                                                        s: "${S.of(context).cliqIdType} - ${getAliasSnapshot.data?.aliases?[index].aliasType?.fromCliqAliasString()} \n${S.of(context).cliqID} - ${getAliasSnapshot.data?.aliases?[index].aliasName}",
                                                                        s2: "${AppConstantsUtils.APP_STORE_URL}")
                                                                    : "";
                                                          }, onCancelled: () {
                                                            Navigator.pop(context);
                                                          }, onDeleteId: () {
                                                            Navigator.pop(context);
                                                            InformationDialog.show(
                                                              context,
                                                              isSwipeToCancel: true,
                                                              onDismissed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              image: AssetUtils.deleteIcon,
                                                              title: S.current.confirmDelete,
                                                              descriptionWidget: Text.rich(TextSpan(
                                                                  text: S.current.areYouSureWantToDelete,
                                                                  style: TextStyle(
                                                                      color: AppColor.veryDarkGray1,
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 14.t,
                                                                      fontWeight: FontWeight.w400),
                                                                  children: [
                                                                    TextSpan(
                                                                        text: getAliasSnapshot
                                                                            .data?.aliases?[index].aliasName,
                                                                        style: TextStyle(
                                                                            color: AppColor.veryDarkGray1,
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 14.t,
                                                                            fontWeight: FontWeight.w600),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: S
                                                                                  .current.fromYourCliqIdList,
                                                                              style: TextStyle(
                                                                                  color:
                                                                                      AppColor.veryDarkGray1,
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontSize: 14.t,
                                                                                  fontWeight:
                                                                                      FontWeight.w400))
                                                                        ])
                                                                  ])),
                                                              onSelected: () {
                                                                Navigator.pop(context);
                                                                model.aliasName = getAliasSnapshot
                                                                        .data?.aliases?[index].aliasName ??
                                                                    "";
                                                                model.aliasId = (getAliasSnapshot
                                                                        .data?.aliases?[index].aliasID) ??
                                                                    "";
                                                                model.accountId = '';
                                                                model.deleteCliqIdOtp(
                                                                    true,
                                                                    (getAliasSnapshot
                                                                            .data?.aliases?[index].aliasID) ??
                                                                        "");
                                                              },
                                                            );
                                                          }, onSuspendId: () {
                                                            Navigator.pop(context);
                                                            InformationDialog.show(
                                                              context,
                                                              onDismissed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              image: AssetUtils.suspandIcon,
                                                              title: S.current.suspandClidId,
                                                              descriptionWidget: Text(
                                                                  S.current.areYouSureToSuspandCliqId,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 14.t,
                                                                      color: AppColor.veryDarkGray1,
                                                                      fontWeight: FontWeight.w400)),

                                                              onSelected: () {
                                                                Navigator.pop(context);
                                                                model.aliasName = getAliasSnapshot
                                                                        .data?.aliases?[index].aliasName ??
                                                                    '';
                                                                model.aliasId = (getAliasSnapshot
                                                                        .data?.aliases?[index].aliasID) ??
                                                                    "";
                                                                model.accountId = '';

                                                                model.suspandCliqIDOtp(
                                                                    getToken: true, aliasId: model.aliasId);
                                                              },
                                                              //  image: ,
                                                              isSwipeToCancel: true,
                                                            );
                                                          }, title: S.current.pleaseSelectYourAction);
                                                        },
                                                      );
                                                    },
                                                    itemCount: (getAliasSnapshot?.data?.aliases ?? []).length,
                                                    separatorBuilder: (BuildContext context, int i) {
                                                      return SizedBox(height: 10.h);
                                                    },
                                                  ),
                                                )
                                              : Expanded(
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                height: 96.h,
                                                                width: 96.w,
                                                                margin: EdgeInsets.only(bottom: 16.h),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    border: Border.all(
                                                                        color: Theme.of(context)
                                                                            .inputDecorationTheme
                                                                            .hintStyle!
                                                                            .color!)),
                                                                child: Container(
                                                                    padding: EdgeInsets.all(32),
                                                                    child: AppSvg.asset(AssetUtils.cliqLogo)),
                                                              ),
                                                              Text(
                                                                S.of(context).NoCliqContactYet,
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 14.t,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional.bottomCenter,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              Navigator.pushNamed(
                                                                  context, RoutePaths.CreateCliqId);

                                                              ///LOG EVENT TO FIREBASE
                                                              await FireBaseLogUtil.fireBaseLog(
                                                                  "navigation_alias_creation",
                                                                  {"navigated_alias_creation": true});
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: 24, vertical: 20),
                                                              padding: EdgeInsets.all(18),
                                                              height: 56,
                                                              width: double.maxFinite,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(100),
                                                                color: Theme.of(context)
                                                                    .accentTextTheme
                                                                    .bodyText1
                                                                    ?.color,
                                                              ),
                                                              child: Center(
                                                                child: Text(S.of(context).createCliqId,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w600,
                                                                        letterSpacing: 1,
                                                                        color:
                                                                            Theme.of(context).accentColor)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );

                                        default:
                                          return Container();
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
