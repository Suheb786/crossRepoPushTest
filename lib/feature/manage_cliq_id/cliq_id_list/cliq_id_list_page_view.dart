import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CliqIdListPageView extends BasePageViewWidget<CliqIdListPageViewModel> {
  CliqIdListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CliqIdListPageViewModel model) {
    return GestureDetector(
      // onVerticalDragEnd: (details) {
      //   int sensitivity = 8;
      //   if (details.primaryVelocity! > sensitivity) {
      //     Navigator.pop(context);
      //   } else if (details.primaryVelocity! < -sensitivity) {}
      // },
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
                  return (data!.data!.aliases!.isNotEmpty ||
                          data.data!.aliases != null)
                      ? Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, i) {
                                return Container(
                                  height: 200,
                                  width: 327,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              AppColor.black.withOpacity(0.08),
                                          offset: Offset(
                                            0,
                                            8,
                                          ),
                                          spreadRadius: 0,
                                          blurRadius: 24),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          "${data.data?.aliases?[i].aliasName ?? ""}",
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(
                                          "${data.data?.aliases?[i].aliasType}",
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${data.data?.aliases?[i].status}",
                                              style: TextStyle(
                                                  color: AppColor
                                                      .darkModerateLimeGreen,
                                                  fontFamily:
                                                      StringUtils.appFont,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 18,
                                            ),
                                            Icon(
                                              Icons.more_horiz_rounded,
                                              color: AppColor.black,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.zero,
                                              topRight: Radius.zero,
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16),
                                            ),
                                            color: Color(0xffF8F8F8),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x00000000)
                                                      .withOpacity(0.08),
                                                  offset: Offset(
                                                    0,
                                                    8,
                                                  ),
                                                  spreadRadius: 0,
                                                  blurRadius: 24),
                                            ],
                                          ),
                                          child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  color: Color(0xffDDDDDD),
                                                );
                                              },
                                              itemCount: data.data!.aliases![i]
                                                  .accounts!.length,
                                              itemBuilder: (context, i) {
                                                return ListTile(
                                                  dense: true,
                                                  title: Text(
                                                    "${data.data?.aliases?[i].accounts?[i].identifier}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            StringUtils.appFont,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${data.data?.aliases?[i].accounts?[i].accountID}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                StringUtils
                                                                    .appFont,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Visibility(
                                                        visible: data
                                                                .data
                                                                ?.aliases?[i]
                                                                .accounts?[i]
                                                                .isDefault ??
                                                            false,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        5),
                                                            child: Text(
                                                              "Default",
                                                              style: TextStyle(
                                                                  color: AppColor
                                                                      .white,
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  trailing: Icon(
                                                    Icons.more_horiz_rounded,
                                                    color: AppColor.black,
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, i) {
                                return SizedBox(height: 16);
                              },
                              itemCount: data.data!.aliases!.length),
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
                                            fontSize: 14,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                }),
          ],
        ),
      ),
    );
  }
}
