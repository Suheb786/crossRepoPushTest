import 'dart:developer';
import 'dart:io';

import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/user_contact_details/user_contact_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_setting/choose_profile_widget.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/edit_profile_pic_bottom_sheet_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';

class UserContactDetailsPageView extends BasePageViewWidget<UserContactDetailsPageViewModel> {
  UserContactDetailsPageView(ProviderBase model) : super(model);
  @override
  Widget build(BuildContext context, UserContactDetailsPageViewModel model) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return AppKeyBoardHide(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(top: 50, start: 29.w, end: 29.w, bottom: 36.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: () {}, child: AppSvg.asset(AssetUtils.back, height: 20)),
                    InkWell(onTap: () {}, child: AppSvg.asset(AssetUtils.delete, height: 20)),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 24,
                  shadowColor: AppColor.black.withOpacity(0.32),
                  margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 40),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                            ? 0
                            : MediaQuery.of(context).viewInsets.bottom - 48),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 40),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        // fit: StackFit.loose,
                        children: [
                          Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      AppStreamBuilder<Resource<bool>>(
                                          stream: model.deleteProfileImageStream,
                                          onData: (data) {
                                            if (data.status == Status.SUCCESS) {
                                              Navigator.pop(context);
                                              model.getProfileDetails();
                                              model.showSuccessToast('Profile Image deleted.');
                                              model.selectedProfile = '';
                                              model.addImage(model.selectedProfile);
                                            }
                                          },
                                          initialData: Resource.none(),
                                          dataBuilder: (context, snapshot) {
                                            return AppStreamBuilder<Resource<bool>>(
                                                stream: model.uploadProfileImageStream,
                                                initialData: Resource.none(),
                                                onData: (data) {
                                                  if (data.status == Status.SUCCESS) {
                                                    model.addImage(model.selectedProfile);
                                                    model.showSuccessToast(S.of(context).profilePhotoUpdated);
                                                    model.getProfileDetails();
                                                  }
                                                },
                                                dataBuilder: (context, profilePhotoUpload) {
                                                  return AppStreamBuilder<String>(
                                                      stream: model.uploadProfilePhotoStream,
                                                      initialData: "",
                                                      dataBuilder: (context, data) {
                                                        return AppStreamBuilder<String>(
                                                            initialData: "",
                                                            stream: model.selectedImageValue,
                                                            onData: (data) {
                                                              if (data.isNotEmpty) {
                                                                model.selectedProfile = data;

                                                                _cropImage(data, model, context);
                                                              }
                                                            },
                                                            dataBuilder: (context, image) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  EditProfilePicBottomSheetSelectionWidget
                                                                      .show(context,
                                                                          onCancel: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          onRemovePhoto: () {},
                                                                          onSelectFromLibrary: () {
                                                                            model.uploadProfilePhoto(
                                                                                DocumentTypeEnum.PICK_IMAGE);
                                                                          },
                                                                          onTakePhoto: () {
                                                                            model.uploadProfilePhoto(
                                                                                DocumentTypeEnum.CAMERA);
                                                                          },
                                                                          title: S.current
                                                                              .pleaseSelectYourAction);
                                                                },
                                                                child: CircleAvatar(
                                                                  backgroundColor:
                                                                      Theme.of(context).primaryColor,
                                                                  minRadius: 48,
                                                                  child: Text(
                                                                    StringUtils.getFirstInitials(
                                                                        "Abdullah Ali"),
                                                                    style: TextStyle(
                                                                      color: AppColor.white,
                                                                      fontSize: 22.t,
                                                                      fontWeight: FontWeight.w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      });
                                                });
                                          }),

                                      // SizedBox(width: 69),
                                      Icon(
                                        Icons.star_border_outlined,
                                        color: AppColor.sky_blue_mid,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Abdullah Ali",
                                    style: TextStyle(
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.gray_black,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      S.current.tapToEditPhoto,
                                      style: TextStyle(
                                        fontSize: 12.t,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.gray1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  AppTextField(
                                    labelText: S.current.nameOfBeneficiary.toUpperCase(),
                                    controller: model.editNameController,
                                  ),
                                  SizedBox(height: 16.0.h),
                                  AppTextField(
                                    labelText: S.current.emailAddress.toUpperCase(),
                                    controller: model.editEmailController,
                                  ),
                                  SizedBox(height: 16.0.h),
                                  AppTextField(
                                    labelText: S.current.ibanORaccountORmobileORalias.toUpperCase(),
                                    controller: model.editIbanController,
                                    labelIcon: () {
                                      return InkWell(
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
                                  ),
                                  SizedBox(height: 40.0.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (!model.visibleSaveButton()) {
                                                Navigator.pushNamed(context, RoutePaths.PaymentActivityPage);
                                              }
                                            },
                                            child: Container(
                                              height: 64.h,
                                              width: 64.h,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: AppSvg.asset(
                                                  AssetUtils.viewHistoryIcon,
                                                  color: AppColor.sky_blue_mid,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: AppColor.sky_blue_mid,
                                                  width: 1.5.w,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              S.current.viewHistory,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12.t,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.gray_black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (!model.visibleSaveButton()) {
                                                log("request Money is enable");
                                              }
                                            },
                                            child: Container(
                                              height: 64.h,
                                              width: 64.h,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: AppSvg.asset(
                                                  AssetUtils.requestMoneyIcon,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.sky_blue_mid,
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: AppColor.sky_blue_mid,
                                                  width: 1.5.w,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              S.current.requestMoney,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12.t,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.gray_black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (model.visibleSaveButton() == false) {
                                                log("send money is enable");
                                              }
                                            },
                                            child: Container(
                                              height: 64.h,
                                              width: 64.h,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: AppSvg.asset(
                                                  AssetUtils.sendMoneyIcon,
                                                  color: AppColor.white,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.sky_blue_mid,
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: AppColor.sky_blue_mid,
                                                  width: 1.5.w,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              S.current.sendMoney,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12.t,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.gray_black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !isKeyboard && model.visibleSaveButton(),
                            // visible: true,
                            child: Container(
                              height: 56.h,
                              width: double.infinity,
                              margin: EdgeInsetsDirectional.only(
                                top: 10,
                              ),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: AppColor.white.withOpacity(0.9),
                                    spreadRadius: 15,
                                    blurRadius: 50,
                                    offset: Offset(0, -55))
                              ], color: AppColor.sky_blue_mid, borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  S.current.saveChanges,
                                  style: TextStyle(
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _cropImage(String data, UserContactDetailsPageViewModel model, BuildContext context) async {
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
    model.uploadProfileImage();
    // model.addImage(cropped.path);
    // model.showSuccessToast(S.of(context).profilePhotoUpdated);
  }
}
