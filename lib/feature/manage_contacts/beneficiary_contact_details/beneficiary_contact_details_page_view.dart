import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/edit_profile_pic_bottom_sheet_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';

import 'beneficiary_contact_details_page_view_model.dart';

class BeneficiaryContactDetailsPageView extends BasePageViewWidget<BeneficiaryContactDetailsPageViewModel> {
  BeneficiaryContactDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BeneficiaryContactDetailsPageViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              elevation: 24,
              shadowColor: AppColor.black.withOpacity(0.32),
              margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 40.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileHeader(context, model),
                    AppDivider(),
                    _profileBody(context, model),
                    AppDivider(),
                    _profileFooter(context, model)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileHeader(context, BeneficiaryContactDetailsPageViewModel model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 24.h, top: 32.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  InformationDialog.show(context,
                      title: S.current.favouriteContact,
                      descriptionWidget: Text(S.current.sendAndRequestFavouriteContacts),
                      image: AssetUtils.favContactIcon,
                      imageHight: 155.h,
                      imageWidth: 96.w,
                      isSwipeToCancel: true, onDismissed: () {
                    Navigator.pop(context);
                  }, onSelected: () {
                    Navigator.pop(context);
                    model.showSuccessTitleandDescriptionToast(
                      ToastwithTitleandDescription(
                        title: S.current.success,
                        description: S.current.yourContactisFavourite,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, RoutePaths.BeneficiaryContactsList);
                  });
                },
                child: Icon(
                  Icons.star_border_outlined,
                  color: AppColor.sky_blue_mid,
                ),
              ),
              AppStreamBuilder<String>(
                  stream: model.uploadProfilePhotoStream,
                  initialData: "",
                  onData: (data) {
                    if (data.isNotEmpty) {
                      _cropImage(data, model, context);
                    }
                  },
                  dataBuilder: (context, data) {
                    return AppStreamBuilder<String>(
                        initialData: "",
                        stream: model.selectedImageValue,
                        onData: (data) {
                          if (data.isNotEmpty) {
                            model.selectedProfile = data;
                          }
                        },
                        dataBuilder: (context, image) {
                          return GestureDetector(
                            onTap: () {
                              EditProfilePicBottomSheetSelectionWidget.show(context, onCancel: () {
                                Navigator.pop(context);
                              }, onRemovePhoto: () {
                                model.removeImage();
                                Navigator.pop(context);
                              }, onSelectFromLibrary: () {
                                model.uploadProfilePhoto(DocumentTypeEnum.PICK_IMAGE);
                                Navigator.pop(context);
                              }, onTakePhoto: () {
                                model.uploadProfilePhoto(DocumentTypeEnum.CAMERA);
                                Navigator.pop(context);
                              }, title: S.current.pleaseSelectYourAction);
                            },
                            child: image!.isEmpty
                                ? Stack(
                                    alignment: Alignment.bottomRight,
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        radius: 48.w,
                                        child: Text(
                                          StringUtils.getFirstInitials(model.argument.nickName),
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 22.t,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: -11.h,
                                          right: -6.w,
                                          child: AppSvg.asset(AssetUtils.cameraWhiteContainerWrap)),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.bottomRight,
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        radius: 48.w,
                                        backgroundImage: Image.file(
                                          File(image),
                                          fit: BoxFit.contain,
                                        ).image,
                                      ),
                                      Positioned(
                                          bottom: -11.h,
                                          right: -6.w,
                                          child: AppSvg.asset(AssetUtils.cameraWhiteContainerWrap)),
                                    ],
                                  ),
                          );
                        });
                  }),
              InkWell(
                  onTap: () {
                    InformationDialog.show(context, image: AssetUtils.removeContact, isSwipeToCancel: true,
                        onDismissed: () {
                      Navigator.pop(context);
                    }, onSelected: () {
                      Navigator.pushReplacementNamed(context, RoutePaths.OtpForManageContact);
                    },
                        title: S.current.removeContact,
                        descriptionWidget: Text(S.current.areYouSureToremoveContact));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AppSvg.asset(AssetUtils.delete,
                        color: AppColor.sky_blue_mid, height: 24.h, width: 24.w),
                  )),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.white_gray,
                ),
                borderRadius: BorderRadius.circular(100)),
            child: AutoSizeTextField(
              controller: model.nickNameController,
              fullwidth: false,
              textAlign: TextAlign.center,
              wrapWords: false,
              cursorWidth: 1.w,
              decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(0.0)),
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.brightBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0.t),
              onSubmitted: (value) {
                debugPrint("value----->${value}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileBody(context, BeneficiaryContactDetailsPageViewModel model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 24.h, top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).nameOfBeneficiary.toUpperCase(),
            style: TextStyle(
                fontSize: 12.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                color: AppColor.very_dark_gray1),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            model.argument.nickName!,
            style: TextStyle(
                fontSize: 16.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                color: AppColor.veryDarkGray2),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            S.of(context).accountMobileNoAlias,
            style: TextStyle(
                fontSize: 12.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                color: AppColor.very_dark_gray1),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  model.argument.iban!,
                  style: TextStyle(
                      fontSize: 16.t,
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      color: AppColor.veryDarkGray2),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 8.0.w),
                child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                        text: model.argument.iban!,
                      )).then((value) => Fluttertoast.showToast(msg: S.of(context).cardNumberCopied));
                    },
                    child: AppSvg.asset(AssetUtils.copy)),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            S.of(context).purpose,
            style: TextStyle(
                fontSize: 12.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                color: AppColor.very_dark_gray1),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            model.argument.purpose!,
            style: TextStyle(
                fontSize: 16.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                color: AppColor.veryDarkGray2),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            S.of(context).purposeDetail,
            style: TextStyle(
                fontSize: 12.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                color: AppColor.very_dark_gray1),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            model.argument.purposeDetails!,
            style: TextStyle(
                fontSize: 16.t,
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                color: AppColor.veryDarkGray2),
          ),
        ],
      ),
    );
  }

  Widget _profileFooter(context, BeneficiaryContactDetailsPageViewModel model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 24.h, top: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {},
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
                    fontSize: 14.t,
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
                  // Navigator.pushNamed(
                  //   context,
                  //   RoutePaths.RequestAmountFromContact,
                  //   arguments: Beneficiary(
                  //     accountHolderName: "Test User Account",
                  //     accountNo: "",
                  //     bankName: "ABC Bank",
                  //     beneType: "",
                  //     beneficiaryAddress: "",
                  //     detCustomerType: "",
                  //     fullName: "Test User",
                  //     iban: "98237328739",
                  //     id: "",
                  //     imageUrl: "",
                  //     limit: 3,
                  //     mobileNumber: "",
                  //     nickName: "test",
                  //     purpose: "personal",
                  //     purposeDetails: "Test Details",
                  //     purposeParent: "testparent",
                  //     purposeParentDetails: "",
                  //     purposeType: "",
                  //   ),
                  // );
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
                    fontSize: 14.t,
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
                  // Navigator.pushNamed(
                  //   context,
                  //   RoutePaths.SendAmountToContact,
                  //   arguments: Beneficiary(
                  //     accountHolderName: "Test User Account",
                  //     accountNo: "",
                  //     bankName: "ABC Bank",
                  //     beneType: "",
                  //     beneficiaryAddress: "",
                  //     detCustomerType: "",
                  //     fullName: "Test User",
                  //     iban: "98237328739",
                  //     id: "",
                  //     imageUrl: "",
                  //     limit: 3,
                  //     mobileNumber: "",
                  //     nickName: "test",
                  //     purpose: "personal",
                  //     purposeDetails: "Test Details",
                  //     purposeParent: "testparent",
                  //     purposeParentDetails: "",
                  //     purposeType: "",
                  //   ),
                  // );
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
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: AppColor.gray_black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _cropImage(String data, BeneficiaryContactDetailsPageViewModel model, BuildContext context) async {
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
      // model.showSuccessToast(S.of(context).profilePhotoUpdated);
    }
  }
}
