import 'dart:io';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/account_setting/choose_profile_widget.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/number_formatting_widget.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendToNewRecipientPageView extends BasePageViewWidget<SendToNewRecipientViewModel> {
  SendToNewRecipientPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SendToNewRecipientViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
              stream: model.errorDetectorStream,
              initialData: false,
              dataBuilder: (context, isError) {
                return ShakeAnimatedWidget(
                  enabled: isError ?? false,
                  duration: Duration(milliseconds: 100),
                  shakeAngle: Rotation.deg(z: 1),
                  curve: Curves.easeInOutSine,
                  child: AppStreamBuilder<Resource<bool>>(
                      stream: model.transferVerifyStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          ProviderScope.containerOf(context)
                              .read(paymentToNewRecipientViewModelProvider)
                              .nextPage();
                          // .next();
                        }
                      },
                      dataBuilder: (context, transferVerified) {
                        return AppStreamBuilder<Resource<CheckSendMoneyResponse>>(
                            stream: model.checkSendMoneyStream,
                            onData: (data) {
                              if (data.status == Status.SUCCESS) {
                                model.purposeController.clear();
                                model.purposeDetailController.clear();

                                model.checkSendMoneyMessageEnum =
                                    data.data?.checkSendMoneyContent?.transferResponse?.messageEnum ??
                                        CheckSendMoneyMessageEnum.NONE;
                                if (data.data?.checkSendMoneyContent?.transferResponse?.messageEnum ==
                                    CheckSendMoneyMessageEnum.IBAN_FROM_CliQ) {
                                  model.showCheckSendMoneyRecipientDetailsVisibility(true);
                                  model.showNameVisibility(false);
                                } else {
                                  model.showCheckSendMoneyRecipientDetailsVisibility(false);
                                  model.showNameVisibility(true);
                                }

                                if (data.data?.checkSendMoneyContent?.transferResponse?.messageEnum ==
                                    CheckSendMoneyMessageEnum.Mobile_NUMBER_BANKSMART) {
                                  InformationDialog.show(context,
                                      isSwipeToCancel: false,
                                      title: S.of(context).mobileNoRegisteredWithBlink,
                                      descriptionWidget: Text(
                                        S.of(context).mobileNoRegisteredWithBlinkDesc,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onDismissed: () {}, onSelected: () {
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            },
                            initialData: Resource.none(),
                            dataBuilder: (context, checkSendMoneyResponse) {
                              return AppStreamBuilder<Resource<bool>>(
                                stream: model.sendToNewRecipientResponseStream,
                                initialData: Resource.none(),
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    if (checkSendMoneyResponse!.data!.checkSendMoneyContent!.transferResponse!
                                                .beneficiaryId !=
                                            null &&
                                        checkSendMoneyResponse.data!.checkSendMoneyContent!.transferResponse!
                                            .beneficiaryId!.isNotEmpty) {
                                      ProviderScope.containerOf(context)
                                          .read(paymentToNewRecipientViewModelProvider)
                                          .nextPage();
                                      // .next();
                                    } else {
                                      model.verifyTransfer(
                                          amount: ProviderScope.containerOf(context)
                                              .read(sendMoneyViewModelProvider)
                                              .currentPinValue);
                                    }
                                  } else if (data.status == Status.ERROR) {
                                    if (data.appError!.type == ErrorType.EMPTY_IBAN_MOBILE) {
                                      model.ibanOrMobileKey.currentState!.isValid = false;
                                    } else if (data.appError!.type == ErrorType.EMPTY_PURPOSE) {
                                      model.purposeKey.currentState!.isValid = false;
                                    } else if (data.appError!.type == ErrorType.EMPTY_PURPOSE_DETAIL) {
                                      model.purposeDetailKey.currentState!.isValid = false;
                                    }
                                    model.showToastWithError(data.appError!);
                                  }
                                },
                                dataBuilder: (context, data) {
                                  return GestureDetector(
                                    onVerticalDragEnd: (details) {
                                      FocusScope.of(context).unfocus();
                                      if (details.primaryVelocity!.isNegative) {
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    onHorizontalDragEnd: (details) {
                                      FocusScope.of(context).unfocus();
                                      if (StringUtils.isDirectionRTL(context)) {
                                        if (!details.primaryVelocity!.isNegative) {
                                          model.sendToNewRecipient(context);
                                        }
                                      } else {
                                        if (details.primaryVelocity!.isNegative) {
                                          model.sendToNewRecipient(context);
                                        }
                                      }
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 2,
                                      color:
                                          Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                                      margin: EdgeInsets.zero,
                                      shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                                ? 0
                                                : MediaQuery.of(context).viewInsets.bottom - 48.0.h),
                                        child: Container(
                                          padding: EdgeInsetsDirectional.only(
                                              top: 32.0.h, start: 24.0.w, end: 24.0.w),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  controller: model.scrollController,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        S.of(context).sendMoneyTo,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 14.0.t,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 16.0.h),
                                                        child: Focus(
                                                          child: AppTextField(
                                                            labelText: S.of(context).accountMobileNoAlias,
                                                            labelIcon: () {
                                                              return InkWell(
                                                                onTap: () async {
                                                                  InformationDialog.show(context,
                                                                      isSwipeToCancel: false,
                                                                      title: S.of(context).numberFormatting,
                                                                      descriptionWidget: Column(
                                                                        children: [
                                                                          Text(
                                                                            S
                                                                                .of(context)
                                                                                .samplesOfNoFormatting,
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14.t,
                                                                                color: AppColor.veryDarkGray1
                                                                                    .withOpacity(0.5),
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          NumberFormattingWidget(
                                                                            title: S.of(context).iban,
                                                                            desc: S.of(context).dummyIBAN,
                                                                          ),
                                                                          NumberFormattingWidget(
                                                                            title:
                                                                                S.of(context).accountNumber,
                                                                            desc:
                                                                                S.of(context).dummyAccountNo,
                                                                          ),
                                                                          NumberFormattingWidget(
                                                                            title: S.of(context).mobileNo,
                                                                            desc: S.of(context).dummyMobileNo,
                                                                          ),
                                                                          NumberFormattingWidget(
                                                                            title: S.of(context).alias,
                                                                            desc: S.of(context).dummyAlias,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      onDismissed: () {}, onSelected: () {
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional.only(
                                                                      start: 5.0.w),
                                                                  child: Container(
                                                                      height: 14.h,
                                                                      width: 14.w,
                                                                      child: AppSvg.asset(AssetUtils.info,
                                                                          color: Theme.of(context)
                                                                              .inputDecorationTheme
                                                                              .focusedBorder!
                                                                              .borderSide
                                                                              .color)),
                                                                ),
                                                              );
                                                            },
                                                            hintText: S.of(context).pleaseEnter,
                                                            key: model.ibanOrMobileKey,
                                                            controller: model.ibanOrMobileController,
                                                            onPressed: () {},
                                                          ),
                                                          onFocusChange: (hasFocus) {
                                                            if (!hasFocus) {
                                                              if (model
                                                                  .ibanOrMobileController.text.isNotEmpty) {
                                                                model.checkSendMoney(
                                                                    amount: ProviderScope.containerOf(context)
                                                                        .read(sendMoneyViewModelProvider)
                                                                        .currentPinValue,
                                                                    iban: model.ibanOrMobileController.text);
                                                              }
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      AppStreamBuilder<bool>(
                                                          stream: model
                                                              .checkSendMoneyRecipientDetailsVisibilityStream,
                                                          initialData: false,
                                                          dataBuilder: (context, visible) {
                                                            return Visibility(
                                                                visible: visible ?? false,
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 16.h,
                                                                    ),
                                                                    AppTextField(
                                                                      labelText: S.of(context).recipientName,
                                                                      hintText: S.of(context).pleaseEnter,
                                                                      key: model.recipientNameKey,
                                                                      controller:
                                                                          model.recipientNameController,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 16.h,
                                                                    ),
                                                                    AppTextField(
                                                                      labelText:
                                                                          S.of(context).recipientAddress,
                                                                      hintText: S.of(context).pleaseEnter,
                                                                      key: model.recipientAddressKey,
                                                                      controller:
                                                                          model.recipientAddressController,
                                                                    ),
                                                                  ],
                                                                ));
                                                          }),
                                                      AppStreamBuilder<bool>(
                                                          stream: model.showNameVisibilityStream,
                                                          initialData: false,
                                                          dataBuilder: (context, visibility) {
                                                            return Visibility(
                                                              visible: visibility!,
                                                              child: Padding(
                                                                  padding: EdgeInsets.only(top: 16.0.h),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Text(
                                                                          S.of(context).nameOfBeneficiary,
                                                                          style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 12.0.t,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                          (model.transferResponse.name !=
                                                                                      null &&
                                                                                  model.transferResponse.name!
                                                                                      .isNotEmpty)
                                                                              ? model.transferResponse.name!
                                                                              : '-',
                                                                          maxLines: 2,
                                                                          textAlign: TextAlign.end,
                                                                          style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 12.0.t,
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                            );
                                                          }),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 24.0.h),
                                                        child: Text(
                                                          S.of(context).selectPurpose,
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 14.0.t,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 16.0.h),
                                                        child: AppTextField(
                                                          labelText: S.of(context).purpose,
                                                          hintText: S.of(context).pleaseEnter,
                                                          readOnly: true,
                                                          key: model.purposeKey,
                                                          controller: model.purposeController,
                                                          onPressed: () {
                                                            if (model.purposeList != null &&
                                                                model.purposeList.isNotEmpty) {
                                                              PurposeDialog.show(context,
                                                                  purposeList: model.purposeList,
                                                                  onSelected: (value) {
                                                                model.updatePurpose(value);
                                                                model.updatePurposeDetaiList(
                                                                    value.purposeDetails!);
                                                                Navigator.pop(context);
                                                              }, onDismissed: () {
                                                                Navigator.pop(context);
                                                              });
                                                            }
                                                          },
                                                          suffixIcon: (value, data) {
                                                            return Container(
                                                                height: 16.0.h,
                                                                width: 16.0.w,
                                                                padding:
                                                                    EdgeInsetsDirectional.only(end: 8.0.w),
                                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                                    color: AppColor.dark_gray_1));
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 16.0.h),
                                                        child: AppTextField(
                                                          labelText: S.of(context).purposeDetails,
                                                          hintText: S.of(context).pleaseEnter,
                                                          readOnly: true,
                                                          controller: model.purposeDetailController,
                                                          key: model.purposeDetailKey,
                                                          onPressed: () {
                                                            if (model.purposeDetaiList != null &&
                                                                model.purposeDetaiList.isNotEmpty) {
                                                              PurposeDetailDialog.show(context,
                                                                  purposeDetailList: model.purposeDetaiList,
                                                                  onSelected: (value) {
                                                                model.updatePurposeDetail(value);
                                                                Navigator.pop(context);
                                                              }, onDismissed: () {
                                                                Navigator.pop(context);
                                                              });
                                                            }
                                                          },
                                                          suffixIcon: (value, data) {
                                                            return Container(
                                                                height: 16.0.h,
                                                                width: 16.0.w,
                                                                padding:
                                                                    EdgeInsetsDirectional.only(end: 8.0.w),
                                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                                    color: AppColor.dark_gray_1));
                                                          },
                                                        ),
                                                      ),
                                                      AppStreamBuilder<bool>(
                                                          stream: model.switchValue,
                                                          initialData: false,
                                                          dataBuilder: (context, isActive) {
                                                            return Padding(
                                                              padding: EdgeInsets.only(top: 24.0.h),
                                                              child: Column(
                                                                children: [
                                                                  AppSwitchLabelWidget(
                                                                    label:
                                                                        S.of(context).addRecipientToContact,
                                                                    inActiveText:
                                                                        S.of(context).no.toUpperCase(),
                                                                    activeText:
                                                                        S.of(context).yes.toUpperCase(),
                                                                    onToggle: (value) {
                                                                      model.isFriend = value;
                                                                      model.addNickNameController.clear();
                                                                      model.updateSwitchValue(value);
                                                                      if (value) {
                                                                        if (model
                                                                            .scrollController.hasClients) {
                                                                          model.scrollController.animateTo(
                                                                            model.scrollController.position
                                                                                .maxScrollExtent,
                                                                            duration: Duration(seconds: 1),
                                                                            curve: Curves.fastOutSlowIn,
                                                                          );
                                                                        }
                                                                      }
                                                                    },
                                                                    isActive: isActive,
                                                                  ),
                                                                  Visibility(
                                                                    visible: isActive!,
                                                                    child: Container(
                                                                      padding: EdgeInsets.only(top: 16.0.h),
                                                                      child: Row(
                                                                        children: [
                                                                          AppStreamBuilder<String>(
                                                                            stream: model
                                                                                .uploadProfilePhotoStream,
                                                                            initialData: '',
                                                                            onData: (data) {
                                                                              if (data != null &&
                                                                                  data.isNotEmpty) {
                                                                                model.selectedProfile = data;
                                                                                // model.addImage(
                                                                                //     data);
                                                                                _cropImage(
                                                                                    data, model, context);
                                                                                // model.showSuccessToast(
                                                                                //     S.of(context).profilePhotoUpdated);
                                                                              }
                                                                            },
                                                                            dataBuilder: (context, data) {
                                                                              return AppStreamBuilder<String>(
                                                                                stream:
                                                                                    model.selectedImageValue,
                                                                                initialData: '',
                                                                                dataBuilder:
                                                                                    (context, image) {
                                                                                  return InkWell(
                                                                                    onTap: () {
                                                                                      ChooseProfileWidget.show(
                                                                                          context,
                                                                                          onCameraTap: () {
                                                                                        Navigator.pop(
                                                                                            context);
                                                                                        model.uploadProfilePhoto(
                                                                                            DocumentTypeEnum
                                                                                                .CAMERA);
                                                                                      }, onGalleryTap: () {
                                                                                        Navigator.pop(
                                                                                            context);
                                                                                        model.uploadProfilePhoto(
                                                                                            DocumentTypeEnum
                                                                                                .PICK_IMAGE);
                                                                                      }, onRemoveTap: () {
                                                                                        model.removeImage();
                                                                                        Navigator.pop(
                                                                                            context);
                                                                                      }, onCancelled: () {
                                                                                        Navigator.pop(
                                                                                            context);
                                                                                      },
                                                                                          title: S
                                                                                              .of(context)
                                                                                              .pleaseSelectYourAction);
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 50.0.h,
                                                                                      width: 50.0.w,
                                                                                      decoration:
                                                                                          BoxDecoration(
                                                                                              shape: BoxShape
                                                                                                  .circle),
                                                                                      child: ClipOval(
                                                                                        child: image!.isEmpty
                                                                                            ? AppSvg.asset(
                                                                                                AssetUtils
                                                                                                    .personCircle,
                                                                                                fit: BoxFit
                                                                                                    .fill,
                                                                                              )
                                                                                            : Image.file(
                                                                                                File(image),
                                                                                                fit: BoxFit
                                                                                                    .fill,
                                                                                              ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                          ),
                                                                          Expanded(
                                                                            child: Padding(
                                                                              padding:
                                                                                  EdgeInsetsDirectional.only(
                                                                                      start: 14.0.w),
                                                                              child: AppStreamBuilder<bool>(
                                                                                  stream:
                                                                                      model.addNickNameStream,
                                                                                  initialData: false,
                                                                                  dataBuilder:
                                                                                      (context, val) {
                                                                                    return FocusScope(
                                                                                      onFocusChange:
                                                                                          (hasFocus) {
                                                                                        model.updateNickName(
                                                                                            hasFocus);
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 28.0.h,
                                                                                        child: TextField(
                                                                                          style: TextStyle(
                                                                                              fontFamily:
                                                                                                  StringUtils
                                                                                                      .appFont,
                                                                                              fontSize:
                                                                                                  14.0.t,
                                                                                              fontWeight:
                                                                                                  FontWeight
                                                                                                      .w600,
                                                                                              color: Theme.of(
                                                                                                      context)
                                                                                                  .accentTextTheme
                                                                                                  .bodyText1!
                                                                                                  .color),
                                                                                          cursorColor: Theme
                                                                                                  .of(context)
                                                                                              .accentTextTheme
                                                                                              .bodyText1!
                                                                                              .color,
                                                                                          controller: model
                                                                                              .addNickNameController,
                                                                                          decoration:
                                                                                              InputDecoration(
                                                                                            hintText: S
                                                                                                .of(context)
                                                                                                .addNickName,
                                                                                            hintStyle: TextStyle(
                                                                                                fontFamily:
                                                                                                    StringUtils
                                                                                                        .appFont,
                                                                                                fontSize:
                                                                                                    14.0.t,
                                                                                                fontWeight:
                                                                                                    FontWeight
                                                                                                        .w600,
                                                                                                color: val!
                                                                                                    ? Colors
                                                                                                        .transparent
                                                                                                    : Theme.of(
                                                                                                            context)
                                                                                                        .accentTextTheme
                                                                                                        .bodyText1!
                                                                                                        .color),
                                                                                            border:
                                                                                                InputBorder
                                                                                                    .none,
                                                                                            contentPadding:
                                                                                                EdgeInsets.only(
                                                                                                    bottom:
                                                                                                        18.0.h),
                                                                                          ),
                                                                                          onSubmitted:
                                                                                              (value) {
                                                                                            model.addNickNameVal =
                                                                                                value;
                                                                                            // model.updateNickName(false);
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 16.0.h,
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: AppStreamBuilder<bool>(
                                                            stream: model.showButtonStream,
                                                            initialData: true,
                                                            dataBuilder: (context, isValid) {
                                                              return Visibility(
                                                                visible: isValid!,
                                                                child: AnimatedButton(
                                                                  buttonText: S.of(context).swipeToProceed,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(top: 20.0.h, bottom: 16.0.h),
                                                  child: Text(
                                                    S.of(context).backToPayments,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.brightBlue,
                                                      fontSize: 12.0.t,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _cropImage(String data, SendToNewRecipientViewModel model, BuildContext context) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: data,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(hideBottomControls: true),
          IOSUiSettings(
              resetButtonHidden: true,
              rotateButtonsHidden: true,
              aspectRatioPickerButtonHidden: true,
              doneButtonTitle: 'Choose')
        ],
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (cropped != null) {
      model.selectedProfile = cropped.path;
      model.addImage(cropped.path);
    }
  }
}
