import 'dart:io';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/payment/request_from_new_recipient/request_from_new_recipient_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_setting/choose_profile_widget.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/number_formatting_widget.dart';
import 'package:neo_bank/ui/molecules/profile/profile_row_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RequestFromNewRecipientPageView extends BasePageViewWidget<RequestFromNewRecipientViewModel> {
  RequestFromNewRecipientPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, RequestFromNewRecipientViewModel model) {
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
                    child: AppStreamBuilder<Resource<RequestToPayContentResponse>>(
                        stream: model.requestFromNewRecipientResponseStream,
                        initialData: Resource.none(),
                        onData: (data) async {
                          if (data.status == Status.SUCCESS) {
                            ///LOG Evenet to appflyer
                            model.logEventsForAppFlyer(
                                eventName: 'request_money_from_new_contact',
                                eventValue: {
                                  "money_requested": ProviderScope.containerOf(context)
                                          .read(requestPaymentFromNewRecipientViewModelProvider)
                                          .argument
                                          ?.currentPin ??
                                      ""
                                });

                            ///LOG EVENT TO FIREBASE
                            await FireBaseLogUtil.fireBaseLog("request_money_from_new_recipient_success", {
                              "is_money_requested": true,
                              "money_requested": ProviderScope.containerOf(context)
                                      .read(requestPaymentFromNewRecipientViewModelProvider)
                                      .argument
                                      ?.currentPin ??
                                  ""
                            });
                            Navigator.pushReplacementNamed(
                                context, RoutePaths.RequestAmountFromContactSuccess,
                                arguments: [
                                  ProviderScope.containerOf(context)
                                          .read(requestPaymentFromNewRecipientViewModelProvider)
                                          .argument
                                          ?.currentPin ??
                                      "",
                                  data.data!.requestToPayContent!.dbtrName!,
                                  model.ibanOrMobileController.text,
                                ]);
                          } else if (data.status == Status.ERROR) {
                            ///LOG EVENT TO FIREBASE
                            await FireBaseLogUtil.fireBaseLog("request_money_from_new_recipient_failure", {
                              "is_money_requested": false,
                            });

                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 2,
                            color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                            margin: EdgeInsets.zero,
                            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                      ? 0
                                      : MediaQuery.of(context).viewInsets.bottom - 48.0.h),
                              child: Container(
                                padding: EdgeInsetsDirectional.only(top: 32.0.h, start: 24.0.w, end: 24.0.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).requestedMoneyVia,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14.0.t,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 16.0.h),
                                              child: Focus(
                                                child: AppTextField(
                                                  labelText: S.of(context).accountMobileNoCliQ.toUpperCase(),
                                                  labelIcon: () {
                                                    return InkWell(
                                                      onTap: () async {
                                                        InformationDialog.show(context,
                                                            isSwipeToCancel: false,
                                                            title: S.of(context).contactInformation,
                                                            descriptionWidget: Column(
                                                              children: [
                                                                Text(
                                                                  S.of(context).requestMoneyFormateSample,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .surface,
                                                                      fontSize: 14.t,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                NumberFormattingWidget(
                                                                  title: S.of(context).ibanCliq,
                                                                  desc: S.of(context).dummyIBAN,
                                                                ),
                                                                NumberFormattingWidget(
                                                                  title: S.of(context).mobileNoCliq,
                                                                  desc: S.of(context).dummyMobileNo,
                                                                ),
                                                                NumberFormattingWidget(
                                                                  title: S.of(context).aliasCliq,
                                                                  desc: S.of(context).dummyAlias,
                                                                )
                                                              ],
                                                            ), onDismissed: () {
                                                          Navigator.pop(context);
                                                        }, onSelected: () {
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.only(start: 5.0.w),
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
                                                  controller: model.ibanOrMobileController,
                                                ),
                                                onFocusChange: (hasFocus) {
                                                  if (!hasFocus) {
                                                    model.getAccountByAlias(
                                                        model.ibanOrMobileController.text, "JOD");
                                                  }
                                                },
                                              ),
                                            ),
                                            AppStreamBuilder<String>(
                                                stream: model.showAccountDetailStream,
                                                initialData: "",
                                                dataBuilder: (context, value) {
                                                  if (!(value!.isEmpty)) {
                                                    return Padding(
                                                        padding: EdgeInsets.only(top: 16.0.h),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                value,
                                                                textAlign: TextAlign.end,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontSize: 12.0.t,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                                  } else {
                                                    return Container();
                                                  }
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
                                                controller: model.purposeController,
                                                onPressed: () {
                                                  if (model.purposeList.isNotEmpty) {
                                                    PurposeDialog.show(context,
                                                        purposeList: model.purposeList, onSelected: (value) {
                                                      model.updatePurpose(value);
                                                      model.updatePurposeDetailList(value.purposeDetails!);
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
                                                      padding: EdgeInsetsDirectional.only(end: 8.0.w),
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
                                                onPressed: () {
                                                  if (model.purposeDetailList.isNotEmpty) {
                                                    PurposeDetailDialog.show(context,
                                                        purposeDetailList: model.purposeDetailList,
                                                        onSelected: (value) {
                                                      model.updatePurposeDetail(value);
                                                      model.validateField();
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
                                                      padding: EdgeInsetsDirectional.only(end: 8.0.w),
                                                      child: AppSvg.asset(AssetUtils.downArrow,
                                                          color: AppColor.dark_gray_1));
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 24.0.h),
                                              child: ProfileRowItem(
                                                title: S.of(context).addRecipientToContact,
                                                initialValue: false,
                                                activeText: S.of(context).yes.toUpperCase(),
                                                inactiveText: S.of(context).no.toUpperCase(),
                                                providerBase: anyOtherNationalityViewModelProvider,
                                                onToggle: (isActive) {
                                                  model.addContact = isActive;
                                                  return Visibility(
                                                    visible: isActive,
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: 16.0.h),
                                                      child: Row(
                                                        children: [
                                                          AppStreamBuilder<String>(
                                                            stream: model.uploadProfilePhotoStream,
                                                            initialData: '',
                                                            onData: (data) {
                                                              if (data.isNotEmpty) {
                                                                model.selectedProfile = data;
                                                                // model.addImage(
                                                                //     data);
                                                                _cropImage(data, model, context);
                                                                // model.showSuccessToast(
                                                                //     S.of(context).profilePhotoUpdated);
                                                              }
                                                            },
                                                            dataBuilder: (context, data) {
                                                              return AppStreamBuilder<String>(
                                                                stream: model.selectedImageValue,
                                                                initialData: '',
                                                                dataBuilder: (context, image) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      ChooseProfileWidget.show(context,
                                                                          onCameraTap: () async {
                                                                        Navigator.pop(context);

                                                                        final dynamic filePath =
                                                                            await Navigator.pushNamed(context,
                                                                                RoutePaths.CameraCapturePage);

                                                                        if (filePath.toString().isNotEmpty)
                                                                          model.uploadProfilePhoto(
                                                                              DocumentTypeEnum.CAMERA,
                                                                              cameraPhotoFile: filePath);
                                                                      }, onGalleryTap: () {
                                                                        Navigator.pop(context);
                                                                        model.uploadProfilePhoto(
                                                                            DocumentTypeEnum.PICK_IMAGE);
                                                                      }, onRemoveTap: () {
                                                                        model.removeImage();
                                                                        Navigator.pop(context);
                                                                      }, onCancelled: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                          title: S
                                                                              .of(context)
                                                                              .pleaseSelectYourAction);
                                                                    },
                                                                    child: Container(
                                                                      height: 50.0.h,
                                                                      width: 50.0.w,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape.circle),
                                                                      child: ClipOval(
                                                                        child: image!.isEmpty
                                                                            ? AppSvg.asset(
                                                                                AssetUtils.personCircle,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                            : Image.file(
                                                                                File(image),
                                                                                fit: BoxFit.fill,
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
                                                                  EdgeInsetsDirectional.only(start: 14.0.w),
                                                              child: AppStreamBuilder<bool>(
                                                                  stream: model.addNickNameStream,
                                                                  initialData: false,
                                                                  dataBuilder: (context, val) {
                                                                    return FocusScope(
                                                                      onFocusChange: (hasFocus) {
                                                                        model.updateNickName(hasFocus);
                                                                      },
                                                                      child: Container(
                                                                        height: 28.0.h,
                                                                        child: TextField(
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontSize: 14.0.t,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyLarge!
                                                                                  .color!),
                                                                          cursorColor: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .color!,
                                                                          controller:
                                                                              model.addNickNameController,
                                                                          decoration: InputDecoration(
                                                                            hintText:
                                                                                S.of(context).addNickName,
                                                                            hintStyle: TextStyle(
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14.0.t,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: val!
                                                                                    ? Colors.transparent
                                                                                    : Theme.of(context)
                                                                                        .textTheme
                                                                                        .bodyLarge!
                                                                                        .color!),
                                                                            border: InputBorder.none,
                                                                            contentPadding: EdgeInsets.only(
                                                                                bottom: 18.0.h),
                                                                          ),
                                                                          onSubmitted: (value) {
                                                                            model.addNickNameVal = value;
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
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 16.0.h, bottom: 5.0.h),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: AppStreamBuilder<bool>(
                                                    stream: model.showButtonStream,
                                                    initialData: false,
                                                    dataBuilder: (context, isValid) {
                                                      return AppPrimaryButton(
                                                        isDisabled: !isValid!,
                                                        text: S.of(context).next,
                                                        onPressed: () {
                                                          model.requestFromNewRecipient(context);
                                                        },
                                                      );
                                                    }),
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
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _cropImage(String data, RequestFromNewRecipientViewModel model, BuildContext context) async {
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
