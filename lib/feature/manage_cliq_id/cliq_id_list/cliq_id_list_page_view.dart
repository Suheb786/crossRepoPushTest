import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/constants/enum/cliq_alias_type_enum.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_cliq_id_mobile_no/edit_cliq_id_mobile_no_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_information_dialog/cliq_information_dialog.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/alias_card_list_widget.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/manage_cliq_bottom_sheet_selection_widget.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/update_cliq_info_bottom_sheet_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

class CliqIdListPageView extends BasePageViewWidget<CliqIdListPageViewModel> {
  CliqIdListPageView(ProviderBase model) : super(model);

  void _shareFiles(
    BuildContext context,
    String s,
  ) async {
    // final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      S.of(context).helloHereMyBlinkAccount + '\n\n${s}' + S.of(context).getYourBlinkAccountTodayBlinkNow,
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
        padding: EdgeInsets.symmetric(horizontal: 24),
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
//*-----------------------------------List of Cliq IDs--------------------------------------->>>>>>>>
            AppStreamBuilder<Resource<GetAlias>>(
              initialData: Resource.none(),
              stream: model.getAliasStream,
              dataBuilder: (context, getAliasSnapshot) {
                return AppStreamBuilder<Resource<bool>>(
                  initialData: Resource.none(),
                  stream: model.linkCliqIdStream,
                  dataBuilder: (context, linkAccountSnapshot) {
                    return AppStreamBuilder<Resource<bool>>(
                      initialData: Resource.none(),
                      stream: model.reactivateCliqIDStream,
                      onData: (value) {
                        if (value.status == Status.SUCCESS) {
                          model.showSuccessToast(S.current.accountActivatedSuccessfully);
                          model.getAlias(true);
                        }
                      },
                      dataBuilder: (context, reactivateSnapshot) {
                        return AppStreamBuilder<Resource<bool>>(
                          initialData: Resource.none(),
                          stream: model.suspandCliqIDStream,
                          onData: (value) {
                            if (value.status == Status.SUCCESS) {
                              model.showSuccessToast(S.of(context).accountSuspendedSuccessfully);
                              model.getAlias(true);
                            }
                          },
                          dataBuilder: (context, suspnadSnapshot) {
                            return AppStreamBuilder<Resource<bool>>(
                              initialData: Resource.none(),
                              stream: model.deleteCliqIdStream,
                              onData: (value) {
                                if (value.status == Status.SUCCESS) {
                                  model.showSuccessToast(
                                    S.of(context).accountDeletedSuccessfully,
                                  );
                                  model.getAlias(true);
                                }
                              },
                              dataBuilder: (context, deleteSnapshot) {
                                return AppStreamBuilder<Resource<bool>>(
                                  initialData: Resource.none(),
                                  stream: model.unlinkCliqIdStream,
                                  onData: (unlinkData) {
                                    if (unlinkData.status == Status.SUCCESS) {
                                      model.showSuccessToast(
                                        (S.of(context).accountSuccessfullyUnlinked),
                                      );
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
                                                      accountList:
                                                          (getAliasSnapshot.data?.aliases?[index].accounts ??
                                                              []),
                                                      aliasName:
                                                          "${getAliasSnapshot.data?.aliases?[index].aliasName ?? ""}",
                                                      aliasType:
                                                          "${getAliasSnapshot.data?.aliases?[index].aliasType}",
                                                      status:
                                                          "${getAliasSnapshot.data?.aliases?[index].status}",
                                                      onTapAccount: (accountData) {
                                                        ManageCliqBottomSheetSelectionWidget.show(context,
                                                            setAsDefault: () {
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
                                                            model.confirmChangeDefaultCliqId(
                                                              GetToken: true,
                                                            );
                                                            // model.changeDefaultCliqId(getToken, aliasId, linkType, otpCode, identifier)
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
                                                              ),
                                                              onSelected: () {
                                                                model.unlinkCliqId(
                                                                  getToken: true,
                                                                  aliasId: (getAliasSnapshot
                                                                          .data?.aliases?[index].aliasID) ??
                                                                      "",
                                                                  accountId: (getAliasSnapshot
                                                                          .data
                                                                          ?.aliases?[index]
                                                                          .accounts?[index]
                                                                          .recordId) ??
                                                                      "",
                                                                );
                                                                Navigator.pop(context);
                                                              },
                                                              isSwipeToCancel: true,
                                                              onDismissed: () {
                                                                Navigator.pop(context);
                                                              });
                                                        },
                                                            onCancelled: () {},
                                                            title: S.of(context).pleaseSelectYourAction);
                                                      },
                                                      onTapAlias: () {
                                                        UpdateCliqInfoBottomSheetSelectionWidget.show(context,
                                                            cliqAliasIdStatusEnum: getAliasSnapshot
                                                                    .data?.aliases?[index].status ??
                                                                CliqAliasIdStatusEnum.NONE,
                                                            onLinkId: () {}, onActivatId: () {
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
                                                          if (getAliasSnapshot
                                                                  .data?.aliases?[index].aliasType ==
                                                              CliqAliasTypeEnum.MOBL) {
                                                            Navigator.pushNamed(
                                                                context, RoutePaths.EditCliqIDMobileNoPage,
                                                                arguments: EditCliqIDMobileNoPageArguments(
                                                                    aliasID: (getAliasSnapshot
                                                                            .data?.aliases?[index].aliasID) ??
                                                                        "",
                                                                    aliasName: (getAliasSnapshot.data
                                                                            ?.aliases?[index].aliasName) ??
                                                                        ""));
                                                          } else if (getAliasSnapshot
                                                                  .data?.aliases?[index].aliasType ==
                                                              CliqAliasTypeEnum.ALIAS) {
                                                            Navigator.pushNamed(context, RoutePaths.EditAlias,
                                                                arguments: EditAliasPageArguments(
                                                                    aliasID: (getAliasSnapshot
                                                                            .data?.aliases?[index].aliasID) ??
                                                                        "",
                                                                    aliasName: (getAliasSnapshot.data
                                                                            ?.aliases?[index].aliasName) ??
                                                                        ""));
                                                          }
                                                        }, onShareId: () {
                                                          _shareFiles(
                                                              context,
                                                              (getAliasSnapshot
                                                                      .data?.aliases?[index].aliasID) ??
                                                                  "");
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
                                                            descriptionWidget: Text(S
                                                                    .current.areYouSureWantToDelete +
                                                                "${(getAliasSnapshot.data?.aliases?[index].aliasName) ?? ""}" +
                                                                S.current.fromYourCliqIdList),
                                                            onSelected: () {
                                                              Navigator.pop(context);
                                                              model.deleteCliqId(
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
                                                            descriptionWidget:
                                                                Text(S.current.areYouSureToSuspandCliqId),

                                                            onSelected: () {
                                                              Navigator.pop(context);
                                                              model.suspandCliqID(
                                                                  getToken: true,
                                                                  aliasId: (getAliasSnapshot
                                                                          .data?.aliases?[index].aliasID) ??
                                                                      "");
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
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                                context, RoutePaths.CreateCliqId);
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
                                                                      color: Theme.of(context).accentColor)),
                                                            ),
                                                          ),
                                                        ),
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
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
