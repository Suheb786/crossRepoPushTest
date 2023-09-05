import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/account_selection/account_selection_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

class LinkBankAccountCliqIdPageView extends BasePageViewWidget<LinkBankAccountCliqIdPageViewModel> {
  LinkBankAccountCliqIdPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<bool>(
        stream: model.errorDetectorStream,
        initialData: false,
        dataBuilder: (context, isValid) {
          return ShakeAnimatedWidget(
            enabled: isValid ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: AppStreamBuilder<Resource<CreateCliqOtp>>(
                stream: model.createCliqIdOtpStream,
                initialData: Resource.none(),
                onData: (otpResponse) {
                  if (otpResponse.status == Status.SUCCESS) {
                    model.mobileNumber = otpResponse.data?.mobileNumber ?? '';
                    model.mobileCode = otpResponse.data?.mobileCode ?? '';
                    ProviderScope.containerOf(context).read(enterOtpFortCliqIdViewModelProvider).updateTime();
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).nextPage();
                  }
                },
                dataBuilder: (context, otpResponse) {
                  return AppStreamBuilder<Resource<bool>>(
                      stream: model.linkBankAccountCliqIdValidationStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.makeOtpRequest(
                            accountNumber: model.selectedAccount?.accountNo ?? '',
                            isAlias: ProviderScope.containerOf(context)
                                    .read(cliqIdTypeSelectionViewModelProvider)
                                    .cliqIdTypeSubject
                                    .value ==
                                CliqIdTypeEnum.ALIAS,
                            aliasValue: (ProviderScope.containerOf(context)
                                        .read(cliqIdTypeSelectionViewModelProvider)
                                        .cliqIdTypeSubject
                                        .value ==
                                    CliqIdTypeEnum.ALIAS)
                                ? ProviderScope.containerOf(context)
                                    .read(cliqIdTypeSelectionViewModelProvider)
                                    .aliasController
                                    .text
                                : ProviderScope.containerOf(context)
                                    .read(cliqIdTypeSelectionViewModelProvider)
                                    .mobileNumberController
                                    .text,
                            getToken: true,
                          );

                          //
                        }
                      },
                      dataBuilder: (context, snapshot) {
                        return Column(
                          children: [
                            Expanded(
                              child: Card(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                            ? 0
                                            : MediaQuery.of(context).viewInsets.bottom - 48),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: FadingEdgeScrollView.fromSingleChildScrollView(
                                                gradientFractionOnEnd: 0.2,
                                                gradientFractionOnStart: 0.2,
                                                child: SingleChildScrollView(
                                                  controller: model.controller,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        S.of(context).linkedAccount,
                                                        style: TextStyle(
                                                            fontSize: 14.t,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: StringUtils.appFont),
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                      AppStreamBuilder<Account>(
                                                          stream: model.selectedAccountValue,
                                                          initialData: Account(
                                                              isSubAccount: false,
                                                              nickName: '',
                                                              accountNo: '',
                                                              accountTitle: '',
                                                              availableBalance: ''),
                                                          dataBuilder: (context, selectedAccount) {
                                                            return InkWell(
                                                              onTap: () {
                                                                AccountSelectionDialog.show(context,
                                                                    title: S.of(context).linkedAccount,
                                                                    onDismissed: () {
                                                                  Navigator.pop(context);
                                                                }, onSelected: (selectedAccount) {
                                                                  model
                                                                      .updateSelectedAccount(selectedAccount);
                                                                  Navigator.pop(context);
                                                                },
                                                                    showBalance: false,
                                                                    accountList:
                                                                        model.linkBankAccountCliqIdList);
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets.only(bottom: 20.0.h),
                                                                child: Container(
                                                                  width: double.infinity,
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal: 16.w, vertical: 16.h),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onBackground,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(8.w)),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            selectedAccount?.isSubAccount ==
                                                                                    false
                                                                                ? (selectedAccount
                                                                                                ?.nickName ==
                                                                                            null ||
                                                                                        selectedAccount
                                                                                                ?.nickName ==
                                                                                            ""
                                                                                    ? (S.current.mainAccount)
                                                                                    : (S.current.mainAccount +
                                                                                        " - " +
                                                                                        (selectedAccount
                                                                                                ?.nickName ??
                                                                                            "")))
                                                                                : (selectedAccount
                                                                                                ?.nickName ==
                                                                                            null ||
                                                                                        selectedAccount
                                                                                                ?.nickName ==
                                                                                            ""
                                                                                    ? (S.current.subAccount)
                                                                                    : (S.current.subAccount +
                                                                                        " - " +
                                                                                        (selectedAccount
                                                                                                ?.nickName ??
                                                                                            ""))),
                                                                            style: TextStyle(
                                                                                fontSize: 14.t,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily:
                                                                                    StringUtils.appFont),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 4.h,
                                                                          ),
                                                                          Text(
                                                                            selectedAccount?.accountNo ?? '-',
                                                                            style: TextStyle(
                                                                                fontSize: 12.t,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily:
                                                                                    StringUtils.appFont),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 7.w),
                                                                          child: AppSvg.asset(
                                                                              AssetUtils.downArrow,
                                                                              color: Theme.of(context)
                                                                                  .primaryColorDark))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                      AppStreamBuilder<bool>(
                                                          stream: model.switchValue,
                                                          initialData: model.isSetDefault,
                                                          dataBuilder: (context, isActive) {
                                                            return AppSwitchLabelWidget(
                                                              label: S.of(context).setAsCliqDefaultAccount,
                                                              inActiveText: S.of(context).no.toUpperCase(),
                                                              activeText: S.of(context).yes.toUpperCase(),
                                                              onToggle: (value) {
                                                                model.updateSwitchValue(value);
                                                              },
                                                              isActive: isActive,
                                                            );
                                                          }),
                                                      AppStreamBuilder<bool>(
                                                        initialData: false,
                                                        stream: model.isSelectedStream,
                                                        dataBuilder: (BuildContext context, isSelected) {
                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                if (isSelected!)
                                                                  InkWell(
                                                                    onTap: () {
                                                                      model.termAndConditionSelected(false);
                                                                    },
                                                                    child: Container(
                                                                      width: 40.0.w,
                                                                      height: 40.0.w,
                                                                      child: Padding(
                                                                        padding: EdgeInsetsDirectional.only(
                                                                            start: 10.w,
                                                                            end: 10.w,
                                                                            bottom: 10.h,
                                                                            top: 10.h),
                                                                        child: AppSvg.asset(AssetUtils.tick,
                                                                            color: AppColor.black),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                        color: AppColor.vividYellow,
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                      ),
                                                                    ),
                                                                  )
                                                                else
                                                                  InkWell(
                                                                    onTap: () {
                                                                      model.termAndConditionSelected(true);
                                                                    },
                                                                    child: Container(
                                                                      width: 40.0.w,
                                                                      height: 40.0.w,
                                                                      decoration: BoxDecoration(
                                                                        border:
                                                                            Border.all(color: AppColor.gray1),
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(100.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                  width: 16.w,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    S
                                                                        .of(context)
                                                                        .whenAcceptingCreationOfYourCliqId,
                                                                    style: TextStyle(
                                                                      color: AppColor.veryDarkGray2,
                                                                      fontSize: 12.t,
                                                                      fontWeight: FontWeight.w700,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                AppStreamBuilder<bool>(
                                                  stream: model.isSelectedStream,
                                                  initialData: false,
                                                  dataBuilder: (BuildContext context, data) {
                                                    return AppPrimaryButton(
                                                      text: S.of(context).next,
                                                      isDisabled: !data!,
                                                      onPressed: () {
                                                        model.validate();
                                                      },
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 24.h,
                                                ),
                                                Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      ProviderScope.containerOf(context)
                                                          .read(createCliqIdViewModelProvider)
                                                          .appSwiperController
                                                          .previousPage(
                                                              duration: Duration(seconds: 1),
                                                              curve: Curves.linear);
                                                    },
                                                    child: Text(
                                                      S.of(context).back,
                                                      style: TextStyle(
                                                        color: AppColor.brightBlue,
                                                        fontSize: 14.t,
                                                        letterSpacing: 1.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    )),
                              ),
                            ),
                          ],
                        );
                      });
                }),
          );
        });
  }
}
