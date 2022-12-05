import 'package:domain/model/cliq/getAlias/account_list.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AliasCardList extends StatelessWidget {
  final String aliasName;
  final String aliasType;
  final String status;
  final List<AccountList> accountList;

  final Resource<GetAlias>? data;

  const AliasCardList({
    Key? key,
    required this.aliasName,
    required this.aliasType,
    required this.status,
    this.data,
    required this.accountList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: 327.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {},
              title: Text(
                aliasName,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                aliasType,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12.t,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                        color: AppColor.darkModerateLimeGreen,
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.more_horiz_rounded,
                      color: AppColor.black,
                    ),
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
                child: ListView.separated(
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
                          dense: false,
                          title: Text(
                            "${accountList[i].identifier}",
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.t,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${accountList[i].accountID}",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w600),
                              ),
                              Visibility(
                                visible: accountList[i].isDefault ?? false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 4, top: 5),
                                    child: Text(
                                      "Default",
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
