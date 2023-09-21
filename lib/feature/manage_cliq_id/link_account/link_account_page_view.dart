import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/cliq_list_action_type_enum.dart';
import 'package:domain/model/cliq/add_link_account/add_link_account_otp.dart';
import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/otp_for_cliq_id_list/otp_for_cliq_id_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/link_account_dialog/link_account_dialog.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'link_account_page_view_model.dart';

class LinkAccountPageView extends BasePageViewWidget<LinkAccountPageViewModel> {
  LinkAccountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 96.0.h, start: 24.w, end: 24.w, bottom: 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).createNewCliqId.toUpperCase(),
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            S.of(context).linkBankAccountToYourNewId,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 32.h,
          ),
          Expanded(
            child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isValid) {
                  return ShakeAnimatedWidget(
                      enabled: isValid ?? false,
                      duration: Duration(milliseconds: 100),
                      shakeAngle: Rotation.deg(z: 1),
                      curve: Curves.easeInOutSine,
                      child: AppStreamBuilder<Resource<AddLinkAccountOtp>>(
                          stream: model.linkCliqIdOtpStream,
                          initialData: Resource.none(),
                          onData: (data) {
                            if (data.status == Status.SUCCESS) {
                              if (data.data != null) {
                                Navigator.pushNamed(context, RoutePaths.OtpForCliqIdListPage,
                                    arguments: OtpForCliqIdListPageArguments(
                                      cliqListActionTypeEnum: CliqListActionTypeEnum.LINKACCOUNT,
                                      aliasId: model.argument.aliasId,
                                      linkType: model.argument.linkType,
                                      accountId: model.accountNumber,
                                      isAlias: model.argument.isAlias,
                                      aliasName: model.argument.aliasValue,
                                      mobileNumber: data.data?.mobileNumber ?? '',
                                      mobileCode: data.data?.mobileCode ?? '',
                                    ));
                              }
                            }
                          },
                          dataBuilder: (context, snapshot) {
                            return AppStreamBuilder<Resource<bool>>(
                                stream: model.linkBankAccountCliqIdValidationStream,
                                initialData: Resource.none(),
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    model.linkCliqIdOtp(
                                      getToken: model.argument.getToken,
                                      aliasId: model.argument.aliasId,
                                      linkType: model.argument.linkType,
                                      accountNumber: model.accountNumber,
                                      isAlias: model.argument.isAlias,
                                      aliasValue: model.argument.aliasValue,
                                    );
                                  }
                                },
                                dataBuilder: (context, snapshot) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onHorizontalDragEnd: (details) {
                                            if (details.primaryVelocity!.isNegative) {
                                              model.validate();
                                            }
                                          },
                                          child: Card(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                                        ? 0
                                                        : MediaQuery.of(context).viewInsets.bottom - 48),
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        FadingEdgeScrollView.fromSingleChildScrollView(
                                                          gradientFractionOnEnd: 0.2,
                                                          gradientFractionOnStart: 0.2,
                                                          child: SingleChildScrollView(
                                                            //   physics: ClampingScrollPhysics(),
                                                            controller: model.controller,
                                                            child: AppStreamBuilder<
                                                                    Resource<List<GetAccountByCustomerId>>>(
                                                                stream: model.getAccountByCustomerIdStream,
                                                                onData: (getAccountByCustomerIdResponse) {
                                                                  if (getAccountByCustomerIdResponse.status ==
                                                                      Status.SUCCESS) {
                                                                    LinkAccountDialog.show(context,
                                                                        label: S.of(context).addLinkAccount,
                                                                        onSelected:
                                                                            (linkBankAccountItemSelected) {
                                                                      model.accountNumber =
                                                                          linkBankAccountItemSelected
                                                                                  .recordId ??
                                                                              '';
                                                                      Navigator.pop(context);
                                                                      model.updateLinkAccount(
                                                                          linkBankAccountItemSelected);
                                                                    }, onDismissed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                        accountsList:
                                                                            getAccountByCustomerIdResponse
                                                                                .data);
                                                                  }
                                                                },
                                                                initialData: Resource.none(),
                                                                dataBuilder: (context,
                                                                    getAccountByCustomerIdResponse) {
                                                                  return AppStreamBuilder<
                                                                      List<GetAccountByCustomerId>>(
                                                                    stream:
                                                                        model.linkBankAccountCliqIdListStream,
                                                                    initialData:
                                                                        model.linkBankAccountCliqIdList,
                                                                    dataBuilder:
                                                                        (BuildContext context, data) {
                                                                      return Column(
                                                                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                                        children: [
                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: Text(
                                                                              S.of(context).linkedAccount,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontSize: 14.t,
                                                                                  fontWeight:
                                                                                      FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 16.h,
                                                                          ),
                                                                          Visibility(
                                                                            visible: data!.length > 0,
                                                                            child: ListView.separated(
                                                                                padding: EdgeInsets.zero,
                                                                                shrinkWrap: true,
                                                                                physics:
                                                                                    NeverScrollableScrollPhysics(),
                                                                                itemBuilder:
                                                                                    (context, index) {
                                                                                  return Container(
                                                                                    padding:
                                                                                        EdgeInsets.all(16.0),
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                            color: AppColor
                                                                                                .whiteGrey),
                                                                                        borderRadius:
                                                                                            BorderRadius
                                                                                                .circular(
                                                                                                    8.0)),
                                                                                    child: Column(
                                                                                      crossAxisAlignment:
                                                                                          CrossAxisAlignment
                                                                                              .start,
                                                                                      children: [
                                                                                        Text(
                                                                                            S.current.account,
                                                                                            style: TextStyle(
                                                                                                fontFamily:
                                                                                                    StringUtils
                                                                                                        .appFont,
                                                                                                fontSize:
                                                                                                    14.t,
                                                                                                color: AppColor
                                                                                                    .black,
                                                                                                fontWeight:
                                                                                                    FontWeight
                                                                                                        .w600)),
                                                                                        Row(
                                                                                          mainAxisAlignment:
                                                                                              MainAxisAlignment
                                                                                                  .spaceBetween,
                                                                                          children: [
                                                                                            Text(
                                                                                              data[index]
                                                                                                      .accountNumber ??
                                                                                                  '',
                                                                                              style: TextStyle(
                                                                                                  fontFamily:
                                                                                                      StringUtils
                                                                                                          .appFont,
                                                                                                  fontSize:
                                                                                                      12.t,
                                                                                                  color: AppColor
                                                                                                      .black,
                                                                                                  fontWeight:
                                                                                                      FontWeight
                                                                                                          .w600),
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons
                                                                                                  .more_horiz_outlined,
                                                                                              size: 25,
                                                                                              color: Color(
                                                                                                  0xFF5F6368),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets
                                                                                              .symmetric(
                                                                                                  horizontal:
                                                                                                      16.0.w,
                                                                                                  vertical:
                                                                                                      10.0.h),
                                                                                          decoration: BoxDecoration(
                                                                                              color: AppColor
                                                                                                  .black,
                                                                                              borderRadius:
                                                                                                  BorderRadius
                                                                                                      .circular(
                                                                                                          100.0)),
                                                                                          child: Text(
                                                                                            S
                                                                                                .of(context)
                                                                                                .Default,
                                                                                            style: TextStyle(
                                                                                                fontFamily:
                                                                                                    StringUtils
                                                                                                        .appFont,
                                                                                                fontSize:
                                                                                                    12.t,
                                                                                                color: AppColor
                                                                                                    .white,
                                                                                                fontWeight:
                                                                                                    FontWeight
                                                                                                        .w600),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                separatorBuilder:
                                                                                    (context, index) {
                                                                                  return SizedBox(
                                                                                    height: 8.h,
                                                                                  );
                                                                                },
                                                                                itemCount: data.length),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 8.h,
                                                                          ),
                                                                          Visibility(
                                                                            visible: data.length <= 0,
                                                                            child: AddIncomeWidget(
                                                                              label: S
                                                                                  .of(context)
                                                                                  .addLinkAccount,
                                                                              onTap: () {
                                                                                model
                                                                                    .getAccountByCustomerId();
                                                                                print(
                                                                                    'ProviderScope----->${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.account?.accountNo ?? ''}');
                                                                              },
                                                                            ),
                                                                          ),
                                                                          AppStreamBuilder<bool>(
                                                                            initialData: false,
                                                                            stream: model.isSelectedStream,
                                                                            dataBuilder:
                                                                                (BuildContext context,
                                                                                    isSelected) {
                                                                              return Padding(
                                                                                padding: EdgeInsets.symmetric(
                                                                                    vertical: 24.0.h),
                                                                                child: Row(
                                                                                  mainAxisAlignment:
                                                                                      MainAxisAlignment
                                                                                          .spaceBetween,
                                                                                  children: [
                                                                                    if (isSelected!)
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          model
                                                                                              .termAndConditionSelected(
                                                                                                  false);
                                                                                        },
                                                                                        child: Container(
                                                                                          width: 40.0.w,
                                                                                          height: 40.0.w,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional
                                                                                                .only(
                                                                                                    start:
                                                                                                        10.w,
                                                                                                    end: 10.w,
                                                                                                    bottom:
                                                                                                        10.h,
                                                                                                    top:
                                                                                                        10.h),
                                                                                            child: AppSvg.asset(
                                                                                                AssetUtils
                                                                                                    .tick,
                                                                                                color: AppColor
                                                                                                    .black),
                                                                                          ),
                                                                                          decoration:
                                                                                              BoxDecoration(
                                                                                            color: AppColor
                                                                                                .vividYellow,
                                                                                            borderRadius:
                                                                                                BorderRadius
                                                                                                    .circular(
                                                                                                        100),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    else
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          model
                                                                                              .termAndConditionSelected(
                                                                                                  true);
                                                                                        },
                                                                                        child: Container(
                                                                                          width: 40.0.w,
                                                                                          height: 40.0.w,
                                                                                          decoration:
                                                                                              BoxDecoration(
                                                                                            border: Border.all(
                                                                                                color: AppColor
                                                                                                    .gray1),
                                                                                            borderRadius: BorderRadius
                                                                                                .all(Radius
                                                                                                    .circular(
                                                                                                        100.0)),
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
                                                                                          color: AppColor
                                                                                              .veryDarkGray2,
                                                                                          fontSize: 12.t,
                                                                                          fontWeight:
                                                                                              FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                    )

                                                                                    /*: Container(
                                                                      width: 40.0.w,
                                                                      height: 40.0.h,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                                        border: Border.all(color: AppColor.gray1),
                                                                      ),
                                                                    ),*/
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            AppStreamBuilder<bool>(
                                                              initialData: false,
                                                              stream: model.isSelectedStream,
                                                              dataBuilder: (BuildContext context, data) {
                                                                return AppStreamBuilder<bool>(
                                                                  stream: model.showButtonStream,
                                                                  initialData: false,
                                                                  dataBuilder:
                                                                      (BuildContext context, isValid) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.only(top: 26.0.h),
                                                                      child: Visibility(
                                                                        visible: (data == true
                                                                            ? (isValid == true ? true : false)
                                                                            : false),
                                                                        child: AnimatedButton(
                                                                            buttonText:
                                                                                S.of(context).swipeToProceed),
                                                                      ),
                                                                    );
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
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Text(
                                                                  S.of(context).backToManageCliq,
                                                                  style: TextStyle(
                                                                    color: AppColor.brightBlue,
                                                                    fontSize: 14.t,
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
                                      ),
                                    ],
                                  );
                                });
                          }));
                }),
          )
        ],
      ),
    );
  }
}
