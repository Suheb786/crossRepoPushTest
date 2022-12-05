import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/getAlias/account_list.dart';
import 'package:domain/model/cliq/getAlias/alias_list.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
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
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:share_plus/share_plus.dart';

class CliqIdListPageView extends BasePageViewWidget<CliqIdListPageViewModel> {
  CliqIdListPageView(ProviderBase model) : super(model);

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
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 24),
              height: 4,
              width: 64,
              decoration: BoxDecoration(
                  color: AppColor.white_gray,
                  borderRadius: BorderRadius.circular(4)),
            ),
//*-----------------------------------List of Cliq IDs--------------------------------------->>>>>>>>
            AppStreamBuilder<Resource<GetAlias>>(
              initialData: Resource.none(),
              stream: model.getAliasStream,
              dataBuilder: (context, data) {
                return ((data?.data?.aliases ?? []).isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return AliasCardList(
                              accountList:
                                  (data?.data?.aliases?[index].accounts ?? []),
                              aliasName:
                                  "${data!.data?.aliases?[index].aliasName ?? ""}",
                              aliasType:
                                  "${data.data?.aliases?[index].aliasType}",
                              status: "${data.data?.aliases?[index].status}",
                              onTapAccount: (accountData) {
                                ManageCliqBottomSheetSelectionWidget.show(
                                    context, setAsDefault: () {
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
                                    model.changeDefaultCliqId(
                                      aliasId: (data
                                              .data?.aliases?[index].aliasID) ??
                                          "",
                                      getToken: true,
                                      linkType: "A",
                                      otpCode: "576824",
                                      identifier: (data.data?.aliases?[index]
                                              .accounts?[index].identifier) ??
                                          "",
                                    );
                                    // model.changeDefaultCliqId(getToken, aliasId, linkType, otpCode, identifier)
                                  }, onDismissed: () {
                                    Navigator.pop(context);
                                  });
                                }, unlinkAccount: () {
                                  CliqInformationDialog.show(context,
                                      description:
                                          "Are you sure you want to unlink the account with your CliQ ID?",
                                      subDescription: '',
                                      title: "Unlink account with CliQ ID");
                                },
                                    onCancelled: () {},
                                    title: "Please select your action");
                              },
                              onTapAlias: () {
                                UpdateCliqInfoBottomSheetSelectionWidget.show(
                                    context,onLinkId: () {
                                      
                                    },
                                    onActivatId: () {
                                      Navigator.pop(context);
                                      CliqInformationDialog.show(context,
                                          // image: AssetUtils.walletIcon,
                                          title: "Reactivate CliQ ID",
                                          description: S
                                              .of(context)
                                              .areYourToChangeDefaultAccountOfYourCliqId,
                                          subDescription: S
                                              .of(context)
                                              .whenAcceptingCreationOfYourCliqId,
                                          onSelected: () {
                                        Navigator.pop(context);
                                        model.reactivatetCliqID(
                                          aliasId: (data.data?.aliases?[index]
                                                  .aliasID) ??
                                              "",
                                          getToken: true,
                                        );
                                        // model.changeDefaultCliqId(getToken, aliasId, linkType, otpCode, identifier)
                                      }, onDismissed: () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    onEditId: () {},
                                    onShareId: () {},
                                    onCancelled: () {},
                                    onDeleteId: () {
                                      Navigator.pop(context);
                                      InformationDialog.show(
                                        context,
                                        title: "Confirm Delete?",
                                        descriptionWidget: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  "Are you sure you want to delete "),
                                          TextSpan(
                                              text: (data.data?.aliases?[index]
                                                      .aliasName) ??
                                                  ""),
                                          TextSpan(
                                              text: " from your CliQ ID list?")
                                        ])),

                                        onSelected: () {
                                          model.deleteCliqId(
                                              true,
                                              (data.data?.aliases?[index]
                                                      .aliasID) ??
                                                  "");
                                        },
                                        //  image: ,
                                        isSwipeToCancel: true,
                                      );
                                    },
                                    onSuspendId: () {
                                      Navigator.pop(context);
                                      InformationDialog.show(
                                        context,
                                        title: "Suspend CliQ ID",
                                        descriptionWidget: Text(
                                            "Are you sure you want to suspend your CliQ ID?"),

                                        onSelected: () {
                                          model.suspandCliqID(
                                              getToken: true,
                                              aliasId: (data
                                                      .data
                                                      ?.aliases?[index]
                                                      .aliasID) ??
                                                  "");
                                        },
                                        //  image: ,
                                        isSwipeToCancel: true,
                                      );
                                    },
                                    title: "Please select your action");
                              },
                            );
                          },
                          itemCount: (data?.data?.aliases ?? []).length,
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
                                          child: AppSvg.asset(
                                              AssetUtils.cliqLogo)),
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
                                              color: Theme.of(context)
                                                  .accentColor)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  // void _shareFiles(CliqIdListPageViewModel model, BuildContext context,
  //     AliasList alias) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   await Share.share(
  //       'Hello! Here are my Blink account details: \n\n${alias.accountTitle ?? ''} \n${account.iban ?? '-'}\n\nOpen your Blink account today.',
  //       subject: 'Share account info',
  //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  // }
}
