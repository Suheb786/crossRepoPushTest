import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../ui/molecules/textfield/app_textfield.dart';

class MyAccountPageViewWidget extends StatelessWidget {
  Account account;

  MyAccountPageViewWidget(this.account);

  TextEditingController accountTextController = TextEditingController();

  ValueNotifier<bool> nameEditableNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return AppKeyBoardHide(
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).primaryColorDark,
          margin: EdgeInsetsDirectional.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: AssetImage(AssetUtils.zigzagRed),
                  alignment: AlignmentDirectional.topEnd,
                  scale: 1,
                  matchTextDirection: true),
            ),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppStreamBuilder<List>(
                  stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).pageStream,
                  initialData: [Container()],
                  dataBuilder: (context, pagesList) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 32.h),
                          child: Text(
                            account.isSubAccount == false
                                ? ((account.nickName ?? "").isNotEmpty
                                    ? (account.nickName ?? "")
                                    : S.current.mainAccount)
                                : (account.nickName ?? "").isNotEmpty
                                    ? (account.nickName ?? "")
                                    : S.current.subAccount,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.t,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
                          child: IntrinsicWidth(
                            child: AppTextField(
                              labelText: "",
                              readOnly: false,
                              fontSize: 12.t,
                              hintText:
                                  accountTextController.text == "" ? S.current.addNickName.toTitleCase() : "",
                              controller: accountTextController,
                              textCapitalization: TextCapitalization.words,
                              inputType: TextInputType.name,
                              containerPadding:
                                  EdgeInsets.only(left: 12.w, right: 3.w, top: 3.h, bottom: 0.h),
                              textColor: Theme.of(context).colorScheme.secondary,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              textFieldBorderColor: Theme.of(context).colorScheme.surface,
                              hintTextColor: Theme.of(context).colorScheme.secondary,
                              textFieldFocusBorderColor: Theme.of(context).colorScheme.surface,
                              onChanged: (p0) {
                                nameEditableNotifier.value = true;
                              },
                              suffixIcon: (selectedCard, value) {
                                if (nameEditableNotifier.value &&
                                    accountTextController.text != account.nickName &&
                                    accountTextController.text.isNotEmpty) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      nameEditableNotifier.value = false;
                                      Future.delayed(Duration(milliseconds: 200), () {
                                        ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .updateNickName(
                                                SubAccountNo: account.accountNo ?? "",
                                                NickName: accountTextController.text ?? "");
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 4.0.h, left: 4.h, right: 4.h, top: 2.h),
                                      child: AppSvg.asset(
                                        AssetUtils.check,
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.0.h, left: 8.h, right: 9.h, top: 6.h),
                                    child: AppSvg.asset(
                                      AssetUtils.editNickName,
                                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenHeight * 0.030.h),
                                  // Text(
                                  //   widget.account.accountTitle != null ? widget.account.accountTitle!.replaceAll(' ', '\n') : '',
                                  //   maxLines: 3,
                                  //   style: TextStyle(
                                  //       fontFamily: StringUtils.appFont,
                                  //       fontSize: 16.0.t,
                                  //       fontWeight: FontWeight.w600,
                                  //       color: Theme.of(context).colorScheme.secondary),
                                  // ),
                                  SizedBox(height: screenHeight * 0.05.h),
                                  Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          style: TextStyle(fontSize: 20.t, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                                text: account.availableBalance ?? '0',
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 20.0.t,
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context).colorScheme.secondary)),
                                            TextSpan(
                                                text: " " + S.of(context).JOD,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.0.t,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                        .withOpacity(0.4))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      InkWell(
                                        onTap: () {
                                          ProviderScope.containerOf(context)
                                              .read(appHomeViewModelProvider)
                                              .balenceUpdate();
                                        },
                                        child: Container(
                                            height: 14.0.h,
                                            width: 14.0.w,
                                            child: Image.asset(
                                              AssetUtils.refresh,
                                              color: AppColor.brightBlue,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    S.of(context).availableBalance,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0.t,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
                                  ),
                                  SizedBox(height: screenHeight * 0.02.h),
                                  Row(
                                    children: [
                                      Text(
                                        account.accountNo ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 12.0.t,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).colorScheme.secondary),
                                      ),
                                      SizedBox(width: 8.w),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: account.accountNo ?? ''))
                                              .then((value) =>
                                                  Fluttertoast.showToast(msg: S.of(context).accountNoCopied));
                                        },
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                          child: AppSvg.asset(
                                            AssetUtils.copy,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    S.of(context).accountNo,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                                        fontSize: 10.0.t,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: screenHeight * 0.02.h),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          account.iban ?? '',
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              overflow: TextOverflow.ellipsis,
                                              color: Theme.of(context).colorScheme.secondary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0.t),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: account.accountNo ?? ''))
                                              .then((value) =>
                                                  Fluttertoast.showToast(msg: S.of(context).ibanCopied));
                                        },
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                          child: AppSvg.asset(
                                            AssetUtils.copy,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    S.of(context).iban,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                                        fontSize: 10.0.t,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: screenHeight * 0.075.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w, vertical: 32.h),
                          child: Directionality(
                            textDirection:
                                StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                            child: Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    if (account.isSubAccount ?? false) {
                                      ProviderScope.containerOf(context)
                                          .read(appHomeViewModelProvider)
                                          .showHideSubAccountSettings(true, account: account);
                                    } else {
                                      ProviderScope.containerOf(context)
                                          .read(appHomeViewModelProvider)
                                          .showHideAccountSettings(true, account: account);
                                    }
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.h,
                                    alignment: Alignment.center,
                                    child: AppSvg.asset(AssetUtils.moreMenu,
                                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                                        height: 24.0.h,
                                        width: 24.0.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.black,
                                      border: Border.all(color: AppColor.borderColorNew, width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColor.borderColorNew,
                                          blurRadius: 14,
                                          spreadRadius: 0.6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          )),
    );
  }
}
