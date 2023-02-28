import 'dart:io';

import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/constants/enum/cliq_alias_type_enum.dart';
import 'package:domain/constants/enum/cliq_list_action_type_enum.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
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

import 'otp_for_cliq_id_list/otp_for_edit_alias_mobile_no_page.dart';

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
              margin: EdgeInsets.only(top: 8, bottom: 24),
              height: 4,
              width: 64,
              decoration: BoxDecoration(color: AppColor.white_gray, borderRadius: BorderRadius.circular(4)),
            ),
            AppStreamBuilder<Resource<GetAlias>>(
              initialData: Resource.none(),
              stream: model.getAliasStream,
              dataBuilder: (context, getAliasSnapshot) {
                return AppStreamBuilder<Resource<bool>>(
                    stream: model.changeDefaultCliqIdStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      ///TODO defaultAccount
                      if (data.status == Status.SUCCESS) {
                        model.showSuccessTitleandDescriptionToast(
                          ToastwithTitleandDescription(
                            title: S.current.cliqIdUpdate,
                            description: S.current.defaultAccountUpdated,
                          ),
                        );
                        // model.showSuccessToast(S.current.defaultAccountUpdated);
                        model.getAlias(true);
                      }
                    },
                    dataBuilder: (context, snapshot) {
                      return AppStreamBuilder<Resource<bool>>(
                        initialData: Resource.none(),
                        stream: model.reactivateCliqIDStream,
                        onData: (value) {
                          ///TODO reactivate
                          if (value.status == Status.SUCCESS) {
                            model.showSuccessTitleandDescriptionToast(
                              ToastwithTitleandDescription(
                                title: S.current.cliqIdUpdate,
                                description: S.current.hasBeenActivated(model.activatedCliq),
                              ),
                            );
                            model.activatedCliq = '';
                            model.getAlias(true);
                          }
                        },
                        dataBuilder: (context, reactivateSnapshot) {
                          return AppStreamBuilder<Resource<bool>>(
                            initialData: Resource.none(),
                            stream: model.suspandCliqIDStream,
                            onData: (value) {
                              ///TODO suspand
                              if (value.status == Status.SUCCESS) {
                                model.showSuccessTitleandDescriptionToast(
                                  ToastwithTitleandDescription(
                                    title: S.current.cliqIdUpdate,
                                    description: S.current.hasbeenSuspended(model.suspendedCliq),
                                  ),
                                );
                                model.suspendedCliq = '';
                                model.getAlias(true);
                              }
                            },
                            dataBuilder: (context, suspnadSnapshot) {
                              return AppStreamBuilder<Resource<bool>>(
                                initialData: Resource.none(),
                                stream: model.deleteCliqIdStream,
                                onData: (value) {
                                  ///TODO delete
                                  if (value.status == Status.SUCCESS) {
                                    model.showSuccessTitleandDescriptionToast(
                                      ToastwithTitleandDescription(
                                        title: S.current.cliqIdUpdate,
                                        description: S.current.hasBeenDeleted(model.deletedCliq),
                                      ),
                                    );
                                    model.deletedCliq = '';
                                    model.getAlias(true);
                                  }
                                },
                                dataBuilder: (context, deleteSnapshot) {
                                  return AppStreamBuilder<Resource<bool>>(
                                    initialData: Resource.none(),
                                    stream: model.unlinkCliqIdStream,
                                    onData: (unlinkData) {
                                      ///TODO unlink

                                      if (unlinkData.status == Status.SUCCESS) {
                                        model.showSuccessTitleandDescriptionToast(
                                          ToastwithTitleandDescription(
                                            title: S.current.cliqIdUpdate,
                                            description: S.current.accountSuccessfullyUnlinked,
                                          ),
                                        );
                                        // model.showSuccessToast(
                                        //   (S.of(context).accountSuccessfullyUnlinked),
                                        // );
                                        model.getAlias(true);
                                      }
                                    },
                                    dataBuilder: (context, data) {
                                      switch (getAliasSnapshot?.status) {
                                        case Status.SUCCESS:
                                          return ((getAliasSnapshot?.data?.aliases ?? []).isNotEmpty)
                                              ? Expanded(
                                                  child: ListView.separated(
                                                    physics: ClampingScrollPhysics(),
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
                                                          ///TODO Account Option

                                                          ManageCliqBottomSheetSelectionWidget.show(context,
                                                              showSetAsDefault: !(accountData.isDefault ??
                                                                  true), setAsDefault: () {
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
                                                              Navigator.pop(context);
                                                              Navigator.pushNamed(
                                                                  context, RoutePaths.OtpForCliqIdListPage,
                                                                  arguments: OtpForCliqIdListPageArguments(
                                                                      cliqListActionTypeEnum:
                                                                          CliqListActionTypeEnum.DEFAULT,
                                                                      aliasId: (getAliasSnapshot.data
                                                                              ?.aliases?[index].aliasID) ??
                                                                          "",
                                                                      accountId: (accountData.recordId) ?? "",
                                                                      aliasName: (getAliasSnapshot.data
                                                                              ?.aliases?[index].aliasName) ??
                                                                          ""));
                                                              // model.confirmChangeDefaultCliqId(
                                                              //   aliasId: (getAliasSnapshot
                                                              //           .data?.aliases?[index].aliasID) ??
                                                              //       "",
                                                              //   acc: (accountData.recordId) ?? "",
                                                              // );
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
                                                                  Navigator.pop(context);
                                                                  Navigator.pushNamed(context,
                                                                      RoutePaths.OtpForCliqIdListPage,
                                                                      arguments:
                                                                          OtpForCliqIdListPageArguments(
                                                                              cliqListActionTypeEnum:
                                                                                  CliqListActionTypeEnum
                                                                                      .UNLINKACCOUNT,
                                                                              aliasId: (getAliasSnapshot
                                                                                      .data
                                                                                      ?.aliases?[index]
                                                                                      .aliasID) ??
                                                                                  "",
                                                                              accountId:
                                                                                  (accountData.recordId) ??
                                                                                      "",
                                                                              aliasName: (getAliasSnapshot
                                                                                      .data
                                                                                      ?.aliases?[index]
                                                                                      .aliasName) ??
                                                                                  ""));

                                                                  // model.unlinkCliqId(
                                                                  //   getToken: true,
                                                                  //   aliasId: (getAliasSnapshot
                                                                  //           .data?.aliases?[index].aliasID) ??
                                                                  //       "",
                                                                  //   accountId: (accountData.recordId) ?? "",
                                                                  // );
                                                                },
                                                                isSwipeToCancel: true,
                                                                onDismissed: () {
                                                                  Navigator.pop(context);
                                                                });
                                                          }, onCancelled: () {
                                                            Navigator.pop(context);
                                                          }, title: S.of(context).pleaseSelectYourAction);
                                                        },

                                                        ///TODO Alias Option

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
                                                            ///TODO onActivatId
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

                                                              // Navigator.pushNamed(
                                                              //     context, RoutePaths.OtpForCliqIdListPage,
                                                              //     arguments: OtpForCliqIdListPageArguments(
                                                              //         cliqListActionTypeEnum:
                                                              //             CliqListActionTypeEnum.ACTIVATED,
                                                              //         aliasId: (getAliasSnapshot.data
                                                              //                 ?.aliases?[index].aliasID) ??
                                                              //             "",
                                                              //         accountId: "",
                                                              //         aliasName: (getAliasSnapshot.data
                                                              //                 ?.aliases?[index].aliasName) ??
                                                              //             ""));

                                                              model.activatedCliq = getAliasSnapshot
                                                                      .data?.aliases?[index].aliasName ??
                                                                  '';
                                                              model.reactivatetCliqID(
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
                                                                        "${S.of(context).cliqIdType} - ${getAliasSnapshot.data?.aliases?[index].aliasType?.fromCliqAliasString()} \n${S.of(context).cliqID} - ${getAliasSnapshot.data?.aliases?[index].aliasID}",
                                                                    s2:
                                                                        "${AppConstantsUtils.PLAY_STORE_URL} ")
                                                                : Platform.isIOS
                                                                    ? _shareFiles(context,
                                                                        s: "${S.of(context).cliqIdType} - ${getAliasSnapshot.data?.aliases?[index].aliasType?.fromCliqAliasString()} \n${S.of(context).cliqID} - ${getAliasSnapshot.data?.aliases?[index].aliasID}",
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
                                                                // model.deletedCliq = getAliasSnapshot
                                                                //         .data?.aliases?[index].aliasName ??
                                                                //     "";
                                                                Navigator.pushNamed(
                                                                    context, RoutePaths.OtpForCliqIdListPage,
                                                                    arguments: OtpForCliqIdListPageArguments(
                                                                        cliqListActionTypeEnum:
                                                                            CliqListActionTypeEnum.DELETECLIQ,
                                                                        aliasId: (getAliasSnapshot.data
                                                                                ?.aliases?[index].aliasID) ??
                                                                            "",
                                                                        accountId: "",
                                                                        aliasName: (getAliasSnapshot
                                                                                .data
                                                                                ?.aliases?[index]
                                                                                .aliasName) ??
                                                                            ""));

                                                                // model.deleteCliqId(
                                                                //     true,
                                                                //     (getAliasSnapshot
                                                                //             .data?.aliases?[index].aliasID) ??
                                                                //         "");
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
                                                                // model.suspendedCliq = getAliasSnapshot
                                                                //         .data?.aliases?[index].aliasName ??
                                                                //     '';

                                                                Navigator.pushNamed(
                                                                    context, RoutePaths.OtpForCliqIdListPage,
                                                                    arguments: OtpForCliqIdListPageArguments(
                                                                        cliqListActionTypeEnum:
                                                                            CliqListActionTypeEnum
                                                                                .SUSPENDEDCLIQ,
                                                                        aliasId: (getAliasSnapshot.data
                                                                                ?.aliases?[index].aliasID) ??
                                                                            "",
                                                                        accountId: "",
                                                                        aliasName: (getAliasSnapshot
                                                                                .data
                                                                                ?.aliases?[index]
                                                                                .aliasName) ??
                                                                            ""));

                                                                // model.suspandCliqID(
                                                                //     getToken: true,
                                                                //     aliasId: (getAliasSnapshot
                                                                //             .data?.aliases?[index].aliasID) ??
                                                                //         "");
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
                                                                height: 96,
                                                                width: 96,
                                                                margin: EdgeInsets.only(bottom: 16),
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
