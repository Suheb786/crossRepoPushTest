import 'dart:ui';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_detail/pay_bill_detail_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/card/postpaid_setting_title_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/postpaid_bill/pay_bill_detail/bill_name/bill_name_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/postpaid_bill/pay_bill_detail/service/select_service_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayBillDetailPageView extends BasePageViewWidget<PayBillDetailPageViewModel> {
  PayBillDetailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (ProviderScope.containerOf(context)
                          .read(payBillPageViewModelProvider)
                          .appSwiperController
                          .page ==
                      0.0) {
                    if (StringUtils.isDirectionRTL(context)) {
                      if (details.primaryVelocity!.isNegative) {
                        ProviderScope.containerOf(context).read(payBillPageViewModelProvider).previousPage();
                      } else {
                        ProviderScope.containerOf(context).read(payBillPageViewModelProvider).nextPage();
                      }
                    } else {
                      if (details.primaryVelocity!.isNegative) {
                        ProviderScope.containerOf(context).read(payBillPageViewModelProvider).nextPage();
                      } else {
                        ProviderScope.containerOf(context).read(payBillPageViewModelProvider).previousPage();
                      }
                    }
                  }
                },
                child: Card(
                  //  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.zero,
                  child: FadingEdgeScrollView.fromSingleChildScrollView(
                    gradientFractionOnEnd: 0.2,
                    gradientFractionOnStart: 0.2,
                    child: SingleChildScrollView(
                      controller: model.controller,
                      child: AppStreamBuilder<bool>(
                        initialData: false,
                        stream: model.totalBillAmtDueStream,
                        dataBuilder: (BuildContext context, isSwitchActive) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(S.of(context).billDetails,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.t,
                                        color: AppColor.gray_black)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: PostPaidSettingTitleWidget(
                                      title: ProviderScope.containerOf(context)
                                          .read(newBillsPageViewModelProvider)
                                          .title,
                                      tileIcon: ProviderScope.containerOf(context)
                                          .read(newBillsPageViewModelProvider)
                                          .titleIcon,
                                    ),
                                  )
                                ],
                              ),
                              AppTextField(
                                labelText: S.of(context).billName.toUpperCase(),
                                hintText: S.of(context).pleaseSelect,
                                controller: model.billNameController,
                                readOnly: true,
                                onPressed: () {
                                  PayBillDialog.show(context, title: S.of(context).billName, onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: (value) {
                                    // Navigator.pop(context);
                                    model.billNameController.text = value;
                                  });
                                },
                                suffixIcon: (value, data) {
                                  return Container(
                                      height: 16.h,
                                      width: 16.w,
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0.h),
                                child: AppTextField(
                                  labelText: S.of(context).services.toUpperCase(),
                                  hintText: S.of(context).pleaseSelect,
                                  controller: model.serviceController,
                                  readOnly: true,
                                  onPressed: () {
                                    SelectServiceDialog.show(context, title: S.of(context).services,
                                        onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: (value) {
                                      // Navigator.pop(context);
                                      model.serviceController.text = value;
                                    });
                                  },
                                  suffixIcon: (value, data) {
                                    return Container(
                                        height: 16.h,
                                        width: 16.w,
                                        padding: EdgeInsets.only(right: 8.w),
                                        child:
                                            AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0.h),
                                child: AppTextField(
                                  labelText: S.of(context).referenceNo.toUpperCase(),
                                  hintText: S.of(context).pleaseEnter,
                                  controller: model.refNoController,
                                  inputType: TextInputType.number,
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0.h),
                                child: AppTextField(
                                  labelText: S.of(context).payFrom,
                                  hintText: S.of(context).searchBill,
                                  controller: model.payFromController,
                                  readOnly: true,
                                  onPressed: () {},
                                  suffixIcon: (value, data) {
                                    return Container(
                                        height: 16.h,
                                        width: 16.w,
                                        padding: EdgeInsets.only(right: 8.w),
                                        child:
                                            AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 24.0.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.of(context).addThisBillToSaveList,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.t,
                                            color: AppColor.gray_black)),
                                    FlutterSwitch(
                                        height: 40.h,
                                        width: 70.w,
                                        padding: 8,
                                        activeTextFontWeight: FontWeight.w500,
                                        showOnOff: true,
                                        valueFontSize: 10.t,
                                        inactiveColor: AppColor.gray1,
                                        activeColor: AppColor.brightBlue,
                                        activeText: S.of(context).yes.toUpperCase(),
                                        inactiveText: S.of(context).no.toUpperCase(),
                                        activeTextColor: AppColor.white,
                                        inactiveTextColor: AppColor.darkGray,
                                        value: isSwitchActive ?? false,
                                        onToggle: (isActive) {
                                          model.switchStatus(isActive);
                                        })
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: isSwitchActive ?? false,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 16.0.h),
                                  child: AppTextField(
                                    labelText: S.of(context).nickName.toUpperCase(),
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.nickNameController,
                                    onChanged: (data) {},
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 32.0.h),
                                child: GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (details.primaryVelocity!.isNegative) {
                                      ProviderScope.containerOf(context)
                                          .read(payBillPageViewModelProvider)
                                          .nextPage();
                                    } else {
                                      ProviderScope.containerOf(context)
                                          .read(payBillPageViewModelProvider)
                                          .previousPage();
                                    }
                                  },
                                  child: AnimatedButton(
                                    buttonText: S.of(context).swipeToProceed,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 23.0.h,
                                  ),
                                  child: Text(S.of(context).backToPayments,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.t,
                                          color: AppColor.brightBlue)),
                                ),
                              )
                            ]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
