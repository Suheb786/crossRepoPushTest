import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/model/cliq/getAlias/account_list.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AliasCardList extends StatelessWidget {
  final String aliasName;
  final String aliasType;
  final String status;
  final List<AccountList> accountList;
  final CliqAliasIdStatusEnum cliqAliasIdStatusEnum;
  final Function()? onTapAlias;
  final Function(AccountList)? onTapAccount;
  final Resource<GetAlias>? data;

  const AliasCardList({
    Key? key,
    required this.aliasName,
    required this.aliasType,
    required this.status,
    this.data,
    required this.accountList,
    required this.onTapAlias,
    required this.onTapAccount,
    this.cliqAliasIdStatusEnum = CliqAliasIdStatusEnum.NONE,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 8.0, start: 24.w, end: 24.w),
      child: Container(
        width: 327.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 24, color: Color(0x14000000), offset: Offset(0, 8), spreadRadius: 0)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                onTapAlias?.call();
              },
              title: Text(
                aliasName,
                style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w700),
              ),
              subtitle: Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  aliasType,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12.t,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark_gray_1,
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                        color: cliqAliasIdStatusEnum == CliqAliasIdStatusEnum.ACTIVE
                            ? AppColor.darkModerateLimeGreen
                            : AppColor.dark_orange,
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Icon(
                    Icons.more_horiz_rounded,
                    color: AppColor.black,
                  )
                ],
              ),
            ),
            Visibility(
              visible: accountList.isNotEmpty,
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
                        color: Color(0x00000000).withOpacity(0.08),
                        offset: Offset(
                          0,
                          8,
                        ),
                        spreadRadius: 0,
                        blurRadius: 24),
                  ],
                ),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    throw "";
                  },
                  child: ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 10),
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Color(0xffDDDDDD),
                        );
                      },
                      itemCount: accountList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            onTap: () {
                              onTapAccount?.call(accountList[i]);
                            },
                            dense: false,
                            title: Padding(
                              padding: const EdgeInsetsDirectional.only(top: 10.0),
                              child: Text(
                                S.of(context).savingAccountList(i + 1),
                                style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.t, fontWeight: FontWeight.w700),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsetsDirectional.only(top: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${accountList[i].acciban}",
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        color: AppColor.dark_gray_1,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // Text(
                                  //   "${accountList[i].recordId}",
                                  //   style: TextStyle(
                                  //       fontFamily: StringUtils.appFont,
                                  //       fontSize: 12.t,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 6.0),
                                    child: Visibility(
                                      visible: accountList[i].isDefault ?? false,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(start: 8.w, end: 8.w, bottom: 4.h, top: 8.h),
                                          child: Text(
                                            S.of(context).defaultWord,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 12.t,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Icon(
                              Icons.more_horiz_rounded,
                              color: AppColor.black,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(CliqAliasIdStatusEnum value) {
    switch (value) {
      case CliqAliasIdStatusEnum.ACTIVE:
        return AppColor.darkModerateLimeGreen;
      case CliqAliasIdStatusEnum.SUSPEND:
        return AppColor.dark_orange;
      default:
        return AppColor.dark_orange;
    }
  }
}
