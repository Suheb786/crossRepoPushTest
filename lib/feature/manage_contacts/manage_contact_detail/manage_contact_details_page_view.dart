import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageContactDetailsPageView extends BasePageViewWidget<ManageContactDetailsPageViewModel> {
  ManageContactDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 40.h),
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppStreamBuilder<String>(
                        stream: model.uploadProfilePhotoStream,
                        initialData: '',
                        onData: (data) {
                          if (data.isNotEmpty) {
                            //model.selectedProfile = data;
                            //model.addImage(data);
                            _cropImage(data, model, context);
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<String>(
                            stream: model.selectedImageValue,
                            initialData: '',
                            dataBuilder: (context, image) {
                              return InkWell(
                                  onTap: () {
                                    // ChooseProfileWidget.show(context,
                                    //     onCameraTap: () {
                                    //       Navigator.pop(context);
                                    //       model.uploadProfilePhoto(
                                    //           DocumentTypeEnum.CAMERA);
                                    //     },
                                    //     onGalleryTap: () {
                                    //       Navigator.pop(context);
                                    //       model.uploadProfilePhoto(
                                    //           DocumentTypeEnum.PICK_IMAGE);
                                    //     },
                                    //     onRemoveTap: () {},
                                    //     onCancelled: () {
                                    //       Navigator.pop(context);
                                    //     },
                                    //     title: S
                                    //         .of(context)
                                    //         .pleaseSelectYourAction);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    radius: 48.w,
                                    child: CircleAvatar(
                                      radius: 48.w,
                                      child: image!.isEmpty
                                          ? (model.beneficiary.imageUrl!.isNotEmpty
                                              ? CircleAvatar(
                                                  radius: 48.w,
                                                  backgroundImage: Image.memory(
                                                    model.beneficiary.imageUrl!,
                                                    fit: BoxFit.cover,
                                                  ).image,
                                                )
                                              : CircleAvatar(
                                                  radius: 48.w,
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  child: Text(
                                                    StringUtils.getFirstInitials(model.beneficiary.fullName),
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 14.t,
                                                        color: Theme.of(context).colorScheme.secondary),
                                                  ),
                                                ))
                                          : CircleAvatar(
                                              radius: 48.w,
                                              backgroundImage: Image.file(
                                                File(image),
                                                fit: BoxFit.cover,
                                              ).image,
                                            ),
                                    ),
                                  ));
                            },
                          );
                        },
                      ),
                      Visibility(
                        visible: false,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Center(
                              child: Text(
                                S.of(context).tapToEditPhoto,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      AppTextField(
                        labelText: S.of(context).nickName.toUpperCase(),
                        hintText: S.of(context).pleaseEnter,
                        inputType: TextInputType.text,
                        readOnly: true,
                        controller: model.nickNameController,
                        maxLength: 25,
                        textColor: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                        onChanged: (text) {
                          model.showSaveButton();
                          model.updateType = UpdateType.details;
                        },
                      ),
                      SizedBox(height: 13.h),
                      AppTextField(
                        labelText: S.of(context).ibanMobileNoAlias.toUpperCase(),
                        hintText: S.of(context).pleaseEnter,
                        inputType: TextInputType.text,
                        controller: model.ibanController,
                        enabled: false,
                        readOnly: true,
                        textColor: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                      ),
                      SizedBox(height: 13.h),
                      AppTextField(
                        labelText: S.of(context).accountHolderName.toUpperCase(),
                        hintText: S.of(context).pleaseEnter,
                        inputType: TextInputType.text,
                        controller: model.accountHolderNameController,
                        enabled: false,
                        readOnly: true,
                        textColor: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                      ),
                      SizedBox(height: 13.h),
                      AppTextField(
                        labelText: S.of(context).bankName,
                        hintText: S.of(context).pleaseEnter,
                        inputType: TextInputType.text,
                        controller: model.bankNameController,
                        enabled: false,
                        readOnly: true,
                        textColor: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                      ),
                      SizedBox(height: 13.h),
                      AppTextField(
                        labelText: S.of(context).purpose,
                        // hintText: S.of(context).pleaseSelect,
                        hintText: "",
                        inputType: TextInputType.text,
                        controller: model.purposeController,
                        readOnly: true,
                        textColor: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                        // onPressed: () {
                        //   if (model.purposeList.length > 0) {
                        //     PurposeDialog.show(context,
                        //         purposeList: model.purposeList,
                        //         onSelected: (value) {
                        //       model.updatePurpose(value);
                        //       model.updatePurposeDetailList(
                        //           value.purposeDetails!);
                        //       model.showSaveButton();
                        //       Navigator.pop(context);
                        //       model.updateType = UpdateType.details;
                        //     }, onDismissed: () {
                        //       Navigator.pop(context);
                        //     });
                        //   }
                        // },
                        // suffixIcon: (value, data) {
                        //   return Container(
                        //       height: 16,
                        //       width: 16,
                        //       padding: EdgeInsetsDirectional.only(right: 8),
                        //       child: AppSvg.asset(AssetUtils.downArrow,
                        //           color: AppColor.dark_gray_1));
                        // },
                      ),
                      SizedBox(height: 13.h),
                      AppTextField(
                        labelText: S.of(context).purposeDetail,
                        // hintText: S.of(context).pleaseSelect,
                        hintText: "",
                        inputType: TextInputType.text,
                        readOnly: true,
                        controller: model.purposeDetailsController,
                        textColor: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                        /*onPressed: () {
                          if (model.purposeDetailList.isNotEmpty) {
                            PurposeDetailDialog.show(context,
                                purposeDetailList: model.purposeDetailList,
                                onSelected: (value) {
                              model.updatePurposeDetail(value);
                              Navigator.pop(context);
                              model.showSaveButton();
                              model.updateType = UpdateType.details;
                            }, onDismissed: () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        suffixIcon: (value, data) {
                          return Container(
                              height: 16,
                              width: 16,
                              padding: EdgeInsetsDirectional.only(right: 8),
                              child: AppSvg.asset(AssetUtils.downArrow,
                                  color: AppColor.dark_gray_1));
                        },*/
                      ),
                      AppStreamBuilder<Resource<bool>>(
                        stream: model.deleteBeneficiaryStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            model.showSuccessToast('Contact Deleted Successfully.');
                            Navigator.pop(context, true);
                          }
                        },
                        dataBuilder: (context, deleteBeneficiary) {
                          return InkWell(
                            onTap: () {
                              model.deleteBeneficiary();
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 45.h, bottom: 11.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppSvg.asset(AssetUtils.delete, color: Theme.of(context).primaryColor),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    S.of(context).removeFromContact,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14.t,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                AppStreamBuilder<Resource<bool>>(
                  stream: model.uploadBeneficiaryProfileImageStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.showSuccessToast(S.of(context).yourContactDetailsUpdated);
                      Navigator.pop(context, true);
                    }
                  },
                  dataBuilder: (context, uploadProfilePhoto) {
                    return AppStreamBuilder<Resource<bool>>(
                      stream: model.updateBeneficiaryStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.showSuccessToast(S.of(context).yourContactDetailsUpdated);
                          Navigator.pop(context, true);
                        }
                      },
                      dataBuilder: (context, beneficiaryUpdate) {
                        return AppStreamBuilder<bool>(
                          stream: model.showSaveButtonStream,
                          initialData: false,
                          dataBuilder: (context, isVisible) {
                            return Visibility(
                                visible: isVisible!,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () {
                                      model.updateBeneficiary();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).textTheme.bodyMedium!.color!,
                                          borderRadius: BorderRadius.circular(100)),
                                      child: Center(
                                        child: Text(
                                          S.of(context).saveChanges,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.secondary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _cropImage(String data, ManageContactDetailsPageViewModel model, BuildContext context) async {
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
      model.updateType = UpdateType.image;
      model.showSaveButton();
    }
  }
}
