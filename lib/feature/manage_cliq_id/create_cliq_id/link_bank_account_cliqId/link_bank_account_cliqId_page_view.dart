import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/link_account_dialog/link_account_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/link_account_dialog/link_account_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class LinkBankAccountCliqIdPageView extends BasePageViewWidget<LinkBankAccountCliqIdPageViewModel> {
  LinkBankAccountCliqIdPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (ProviderScope.containerOf(context)
                      .read(createCliqIdViewModelProvider)
                      .appSwiperController
                      .page ==
                  1.0) {
                FocusScope.of(context).unfocus();
                if (StringUtils.isDirectionRTL(context)) {
                  if (!details.primaryVelocity!.isNegative) {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).nextPage();
                  } else {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).previousPage();
                  }
                } else {
                  if (details.primaryVelocity!.isNegative) {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).nextPage();
                  } else {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).previousPage();
                  }
                }
              }
            },
            child: Card(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                          ? 0
                          : MediaQuery.of(context).viewInsets.bottom - 48),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    child: FadingEdgeScrollView.fromSingleChildScrollView(
                      gradientFractionOnEnd: 0.2,
                      gradientFractionOnStart: 0.2,
                      child: SingleChildScrollView(
                        controller: model.controller,
                        child: AppStreamBuilder<List<LinkBankAccountData>>(
                          stream: model.linkBankAccountCliqIdListStream,
                          initialData: model.linkBankAccountCliqIdList,
                          dataBuilder: (BuildContext context, data) {
                            return Column(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    S.of(context).linkedAccount,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14.t,
                                        fontWeight: FontWeight.w600),
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
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: AppColor.whiteGrey),
                                                borderRadius: BorderRadius.circular(8.0)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].accountType),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(data[index].accountNo),
                                                    Icon(
                                                      Icons.more_horiz_outlined,
                                                      size: 25,
                                                      color: Color(0xFF5F6368),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0.w, vertical: 10.0.h),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.black,
                                                      borderRadius: BorderRadius.circular(100.0)),
                                                  child: Text(
                                                    'Default',
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.white,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 8.h,
                                        );
                                      },
                                      itemCount: data.length),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                AddIncomeWidget(
                                  label: S.of(context).addIncome,
                                  onTap: () {
                                    LinkAccountDialog.show(context, label: S.of(context).addLinkAccount,
                                        onSelected: (linkBankAccountItemSelected) {
                                      Navigator.pop(context);
                                      model.updateLinkAccount(linkBankAccountItemSelected);
                                    }, onDismissed: () {
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                                AppStreamBuilder<bool>(
                                  initialData: false,
                                  stream: model.isSelectedStream,
                                  dataBuilder: (BuildContext context, isSelected) {
                                    return Visibility(
                                      visible: data.length > 0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (isSelected!)
                                              InkWell(
                                                onTap: () {
                                                  model.termAndConditionSelected(false);
                                                },
                                                child: Container(
                                                  height: 42.h,
                                                  width: 40.w,
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 10.w, end: 10.w, bottom: 10.h, top: 10.h),
                                                    child:
                                                        AppSvg.asset(AssetUtils.tick, color: AppColor.black),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.vividYellow,
                                                    borderRadius: BorderRadius.circular(100),
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
                                                  height: 42.0.h,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: AppColor.gray1),
                                                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                                  ),
                                                ),
                                              ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Text(
                                                S.of(context).whenAcceptingCreationOfYourCliqId,
                                                style: TextStyle(
                                                  color: AppColor.veryDarkGray2,
                                                  fontSize: 12.t,
                                                  fontWeight: FontWeight.w600,
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
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                  children: [
                                    AppStreamBuilder<bool>(
                                      stream: model.isSelectedStream,
                                      initialData: false,
                                      dataBuilder: (BuildContext context, data) {
                                        return Visibility(
                                          visible: data!,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 0.0.h),
                                            child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                          ),
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
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
