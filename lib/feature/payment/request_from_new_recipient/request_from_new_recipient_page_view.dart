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
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/profile/profile_row_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
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
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            print("got event: ${data.data!.requestToPayContent!.dbtrAcct}");
                            Navigator.pushReplacementNamed(
                                context, RoutePaths.RequestAmountFromContactSuccess,
                                arguments: [
                                  ProviderScope.containerOf(context)
                                      .read(requestMoneyViewModelProvider)
                                      .currentPinValue,
                                  data.data!.requestToPayContent!.dbtrName!,
                                  data.data!.requestToPayContent!.dbtrMcc!,
                                ]);
                          } else if (data.status == Status.ERROR) {
                            // if (data.appError!.type ==
                            //     ErrorType.EMPTY_RESIDENT_COUNTRY) {
                            //   model.residentCountryKey.currentState!.isValid =
                            //       false;
                            // }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.requestFromNewRecipient(context);
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.requestFromNewRecipient(context);
                                }
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 2,
                              color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                              margin: EdgeInsets.zero,
                              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                        ? 0
                                        : MediaQuery.of(context).viewInsets.bottom - 48),
                                child: Container(
                                  padding: EdgeInsetsDirectional.only(top: 32, start: 24, end: 24),
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
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 16.0),
                                                child: Focus(
                                                  child: AppTextField(
                                                    labelText: S.of(context).ibanOrMobileRequest,
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
                                                          padding: EdgeInsets.only(top: 16),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  S.of(context).nameOfBeneficiary,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  value,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12,
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
                                                padding: EdgeInsets.only(top: 24),
                                                child: Text(
                                                  S.of(context).selectPurpose,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 16),
                                                child: AppTextField(
                                                  labelText: S.of(context).purpose,
                                                  hintText: S.of(context).pleaseEnter,
                                                  readOnly: true,
                                                  controller: model.purposeController,
                                                  onPressed: () {
                                                    if (model.purposeList != null &&
                                                        model.purposeList.isNotEmpty) {
                                                      PurposeDialog.show(context,
                                                          purposeList: model.purposeList,
                                                          onSelected: (value) {
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
                                                        height: 16,
                                                        width: 16,
                                                        padding: EdgeInsetsDirectional.only(end: 8),
                                                        child: AppSvg.asset(AssetUtils.downArrow,
                                                            color: AppColor.dark_gray_1));
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 16),
                                                child: AppTextField(
                                                  labelText: S.of(context).purposeDetails,
                                                  hintText: S.of(context).pleaseEnter,
                                                  readOnly: true,
                                                  controller: model.purposeDetailController,
                                                  onPressed: () {
                                                    if (model.purposeDetailList != null &&
                                                        model.purposeDetailList.isNotEmpty) {
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
                                                        height: 16,
                                                        width: 16,
                                                        padding: EdgeInsetsDirectional.only(end: 8),
                                                        child: AppSvg.asset(AssetUtils.downArrow,
                                                            color: AppColor.dark_gray_1));
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 24),
                                                child: ProfileRowItem(
                                                  title: S.of(context).addRecipientToContact,
                                                  initialValue: false,
                                                  activeText: S.of(context).yes,
                                                  inactiveText: S.of(context).no,
                                                  providerBase: anyOtherNationalityViewModelProvider,
                                                  onToggle: (isActive) {
                                                    model.addContact = isActive;
                                                    return Visibility(
                                                      visible: isActive,
                                                      child: Container(
                                                        padding: EdgeInsets.only(top: 16),
                                                        child: Row(
                                                          children: [
                                                            AppStreamBuilder<String>(
                                                              stream: model.uploadProfilePhotoStream,
                                                              initialData: '',
                                                              onData: (data) {
                                                                if (data != null && data.isNotEmpty) {
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
                                                                            onCameraTap: () {
                                                                          Navigator.pop(context);
                                                                          model.uploadProfilePhoto(
                                                                              DocumentTypeEnum.CAMERA);
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
                                                                        height: 50,
                                                                        width: 50,
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
                                                                    EdgeInsetsDirectional.only(start: 14),
                                                                child: AppStreamBuilder<bool>(
                                                                    stream: model.addNickNameStream,
                                                                    initialData: false,
                                                                    dataBuilder: (context, val) {
                                                                      return FocusScope(
                                                                        onFocusChange: (hasFocus) {
                                                                          model.updateNickName(hasFocus);
                                                                        },
                                                                        child: Container(
                                                                          height: 28,
                                                                          child: TextField(
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Theme.of(context)
                                                                                    .accentTextTheme
                                                                                    .bodyText1!
                                                                                    .color),
                                                                            cursorColor: Theme.of(context)
                                                                                .accentTextTheme
                                                                                .bodyText1!
                                                                                .color,
                                                                            controller:
                                                                                model.addNickNameController,
                                                                            decoration: InputDecoration(
                                                                              hintText:
                                                                                  S.of(context).addNickName,
                                                                              hintStyle: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: val!
                                                                                      ? Colors.transparent
                                                                                      : Theme.of(context)
                                                                                          .accentTextTheme
                                                                                          .bodyText1!
                                                                                          .color),
                                                                              border: InputBorder.none,
                                                                              contentPadding:
                                                                                  EdgeInsets.only(bottom: 18),
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
                                                padding: EdgeInsets.only(
                                                  top: 16,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
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
                                          padding: EdgeInsets.only(top: 20, bottom: 16),
                                          child: Text(
                                            S.of(context).backToPayments,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.brightBlue,
                                              fontSize: 12,
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
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _cropImage(String data, RequestFromNewRecipientViewModel model, BuildContext context) async {
    File? cropped = await ImageCropper.cropImage(
        sourcePath: data,
        cropStyle: CropStyle.circle,
        iosUiSettings: IOSUiSettings(
            resetButtonHidden: true,
            rotateButtonsHidden: true,
            aspectRatioPickerButtonHidden: true,
            doneButtonTitle: 'Choose'),
        androidUiSettings: AndroidUiSettings(hideBottomControls: true),
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (cropped != null) {
      model.selectedProfile = cropped.path;
      model.addImage(cropped.path);
    }
  }
}
