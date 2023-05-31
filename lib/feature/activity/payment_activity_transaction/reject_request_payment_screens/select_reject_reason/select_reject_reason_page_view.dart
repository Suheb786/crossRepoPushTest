import 'dart:developer';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/model/cliq/reuest_to_pay_result_otp/request_to_pay_result_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/select_reject_reason/select_reject_reason_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/reject_reason_inward_request/reject_reason_inward_request_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectRejectReasonPageView extends BasePageViewWidget<SelectRejectReasonPageViewModel> {
  SelectRejectReasonPageView(ProviderBase model) : super(model);

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
                child: AppStreamBuilder<Resource<RequestToPayResultOtp>>(
                    stream: model.rejectOtpStream,
                    initialData: Resource.none(),
                    onData: (data) async {
                      if (data.status == Status.SUCCESS) {
                        model.mobileCode = data.data?.mobileCode ?? '';
                        model.mobileNumber = data.data?.mobileNumber ?? '';
                        log(" model.mobile no is : ${model.mobileNumber}");

                        ProviderScope.containerOf(context)
                            .read(rejectRequestPaymentPageViewModelProvider)
                            .nextPage();
                        ProviderScope.containerOf(context)
                            .read(rejectRequestPaymentOtpPageViewModelProvider)
                            .updateTime();
                      } else if (data.status == Status.ERROR) {}
                    },
                    dataBuilder: (context, rejectOtpResponse) {
                      return AppStreamBuilder<Resource<List<RejectionReasonInward>>>(
                          stream: model.reasonToRejectStream,
                          initialData: Resource.none(),
                          dataBuilder: (context, reasonToRejectResponse) {
                            return AppStreamBuilder<Resource<bool>>(
                                initialData: Resource.none(),
                                stream: model.reasonToRejectValidationStream,
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    model.makeRejectOtpRequest();
                                    // if (data.data!) {
                                    //   // ProviderScope.containerOf(context)
                                    //   //     .read(rejectRequestPaymentOtpPageViewModelProvider)
                                    //   //     .updateTime();
                                    //   ProviderScope.containerOf(context)
                                    //       .read(rejectRequestPaymentPageViewModelProvider)
                                    //       .nextPage();
                                    // }
                                  }
                                },
                                dataBuilder: (context, isValid) {
                                  return GestureDetector(
                                    onVerticalDragEnd: (details) {
                                      int sensitivity = 8;
                                      if (details.primaryVelocity! > sensitivity) {
                                        Navigator.pop(context);
                                      } else if (details.primaryVelocity! < -sensitivity) {}
                                    },
                                    onHorizontalDragEnd: (details) {
                                      if (ProviderScope.containerOf(context)
                                              .read(rejectRequestPaymentPageViewModelProvider)
                                              .appSwiperController
                                              .page ==
                                          0.0) {
                                        FocusScope.of(context).unfocus();
                                        if (StringUtils.isDirectionRTL(context)) {
                                          if (!details.primaryVelocity!.isNegative) {
                                            model.validateUserInput();
                                          }
                                        } else {
                                          if (details.primaryVelocity!.isNegative) {
                                            model.validateUserInput();
                                          }
                                        }
                                      }
                                    },
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                                ? 0
                                                : MediaQuery.of(context).viewInsets.bottom - 48),
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 24.w, right: 24.w, top: 25.h, bottom: 16.h),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    physics: ClampingScrollPhysics(),
                                                    child: Column(
                                                      children: [
                                                        AppTextField(
                                                          labelText:
                                                              S.of(context).reasonToReject.toUpperCase(),
                                                          hintText: S.of(context).pleaseSelect,
                                                          controller: model.reasonToRejectController,
                                                          key: model.reasonToRejectKey,
                                                          readOnly: true,
                                                          onPressed: () {
                                                            if (reasonToRejectResponse?.status ==
                                                                    Status.SUCCESS &&
                                                                reasonToRejectResponse?.data != null) {
                                                              bool status = (reasonToRejectResponse
                                                                      ?.data?.isNotEmpty) ??
                                                                  false;
                                                              if (status) {
                                                                RejectReasonInwardRequestDialog.show(context,
                                                                    title: S.of(context).reasonToReject,
                                                                    rejectionReasonInward:
                                                                        reasonToRejectResponse!.data!,
                                                                    onDismissed: () {
                                                                  Navigator.pop(context);
                                                                }, onSelected: (value) {
                                                                  Navigator.pop(context);
                                                                  model.reasonToRejectController.text =
                                                                      value.description;
                                                                  model.rejectReasonCode = value.code;

                                                                  model.validate();
                                                                });
                                                              }
                                                            }
                                                          },
                                                          suffixIcon: (isValid, value) {
                                                            return Container(
                                                                height: 16.h,
                                                                width: 16.w,
                                                                padding:
                                                                    EdgeInsets.symmetric(horizontal: 7.w),
                                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                                    color:
                                                                        Theme.of(context).primaryColorDark));
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                                      child: AppStreamBuilder<bool>(
                                                          stream: model.showButtonStream,
                                                          initialData: false,
                                                          dataBuilder: (context, isValid) {
                                                            return Visibility(
                                                              visible: isValid!,
                                                              child: AnimatedButton(
                                                                buttonText: S.of(context).swipeToProceed,
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        S.of(context).swipeDownToCancel,
                                                        style: TextStyle(
                                                          color: AppColor.gray5,
                                                          fontSize: 10.t,
                                                          letterSpacing: 1.0,
                                                          fontFamily: StringUtils.appFont,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                });
                          });
                    }));
          }),
    );
  }
}
