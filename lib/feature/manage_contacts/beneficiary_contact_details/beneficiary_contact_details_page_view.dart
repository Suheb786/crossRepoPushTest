import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/clipboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_transaction_history_list/beneficiary_transaction_history_list_page.dart';
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
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../payment/request_amount_from_contact/request_amount_from_contact_page.dart';
import '../../payment/send_amount_to_contact/send_amount_to_contact_page.dart';
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
              Icon(
                Icons.star_border_outlined,
                color: Colors.transparent,
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
                        onData: (data) {},
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
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                clipBehavior: Clip.none,
                                children: [
                                  image!.isEmpty
                                      ? model.argument.beneficiaryInformation.image.isEmpty
                                          ? AppStreamBuilder<String>(
                                              stream: model.beneficiaryNameStream,
                                              initialData: '',
                                              dataBuilder: (context, nickNameResponse) {
                                                return CircleAvatar(
                                                    backgroundColor: Theme.of(context).colorScheme.shadow,
                                                    radius: 48.w,
                                                    child: Text(
                                                      StringUtils.getFirstInitials(nickNameResponse),
                                                      style: TextStyle(
                                                        color: AppColor.white,
                                                        fontSize: 22.t,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ));
                                              })
                                          : CircleAvatar(
                                              radius: 48.w,
                                              backgroundImage: Image.memory(
                                                model.argument.beneficiaryInformation.image,
                                                fit: BoxFit.cover,
                                              ).image,
                                            )
                                      : CircleAvatar(
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
                              ));
                        });
                  }),
              AppStreamBuilder<Resource<bool>>(
                  stream: model.deleteBeneficiaryStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.showSuccessTitleandDescriptionToast(ToastwithTitleandDescription(
                          title: '', description: S.of(context).yourContactHasBeenRemoved));
                      Navigator.pop(context, true);
                    }
                  },
                  dataBuilder: (context, data) {
                    return InkWell(
                        onTap: () {
                          InformationDialog.show(context,
                              image: AssetUtils.removeContact, isSwipeToCancel: true, onDismissed: () {
                            Navigator.pop(context);
                          }, onSelected: () {
                            Navigator.pop(context);
                            model.deleteBeneficiary();
                          },
                              title: S.current.removeContact,
                              descriptionWidget: Text(S.current.areYouSureToremoveContact));
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: AppSvg.asset(AssetUtils.delete,
                              color: AppColor.sky_blue_mid, height: 24.h, width: 24.w),
                        ));
                  }),
            ],
          ),
          SizedBox(height: 16.h),
          AppStreamBuilder<Resource<bool>>(
              stream: model.updateBeneficiaryStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  model.addNickName(nickName: model.nickNameController.text);
                  model.showSuccessTitleandDescriptionToast(
                      ToastwithTitleandDescription(title: '', description: S.of(context).nickNameUpdated));
                }
              },
              dataBuilder: (context, data) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w) + EdgeInsets.only(top: 10.h, bottom: 6.h),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.white_gray,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AppStreamBuilder<bool>(
                            stream: model.nameEditableNotifierStream,
                            initialData: false,
                            dataBuilder: (context, isEditable) {
                              return Focus(
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    model.toggleNickName(context);
                                  }
                                },
                                child: AutoSizeTextField(
                                  controller: model.nickNameController,
                                  focusNode: model.nickNameFocus,
                                  fullwidth: false,
                                  textAlign: TextAlign.center,
                                  cursorWidth: 1.w,
                                  minWidth: 40.w,
                                  readOnly: isEditable ?? false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(right: 6.0, left: 0.0),
                                    isCollapsed: false,
                                  ),
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.brightBlue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0.t),
                                  onSubmitted: (value) {},
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      AppStreamBuilder<bool>(
                          stream: model.nameEditableNotifierStream,
                          initialData: false,
                          dataBuilder: (context, isEditable) {
                            return GestureDetector(
                              onTap: () {
                                model.toggleNickName(context);
                              },
                              child: AppSvg.asset(
                                (isEditable ?? false) ? AssetUtils.editNickName : AssetUtils.checkIcon,
                                color: AppColor.brightBlue,
                                width: isEditable ?? false ? 14.h : 12.h,
                                height: isEditable ?? false ? 14.h : 12.h,
                              ),
                            );
                          })
                    ],
                  ),
                );
              }),
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
            model.argument.beneficiaryInformation.fullName!,
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
            model.navigationType == NavigationType.REQUEST_MONEY
                ? S.current.accountMobileNoCliQ.toUpperCase()
                : S.of(context).accountMobileNoAlias,
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
                  model.argument.beneficiaryInformation.identifier ?? '',
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
                        text: model.argument.beneficiaryInformation.identifier ?? '',
                      )).then((value) => Fluttertoast.showToast(msg: S.of(context).copied));
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
            model.argument.beneficiaryInformation.purposeParentDetails!,
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
            model.argument.beneficiaryInformation.purposeDetails!,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: ProviderScope.containerOf(context)
                    .read(appHomeViewModelProvider)
                    .dashboardDataContent
                    .dashboardFeatures
                    ?.manageContactHistory ??
                false,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.BeneficiaryTransactionHistoryList,
                          arguments: BeneficiaryTransactionHistoryListPageArguments(
                            navigationType: model.argument.navigationType,
                            beneficiaryId: model.argument.beneficiaryInformation.id ?? '',
                          ));
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
                    width: 80.w,
                    child: Text(
                      S.current.viewTransactions,
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
            ),
          ),
          Visibility(
            visible: model.navigationType == NavigationType.REQUEST_MONEY,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.RequestAmountFromContact,
                      arguments: RequestAmountToContactPageArgument(
                          Beneficiary(
                              userId: model.argument.beneficiaryInformation.userId,
                              accountHolderName: model.argument.beneficiaryInformation.fullName,
                              accountNo: model.argument.beneficiaryInformation.accountNo,
                              bankName: model.argument.beneficiaryInformation.bankName,
                              beneType: model.argument.beneficiaryInformation.beneficiaryType,
                              beneficiaryAddress: "",
                              detCustomerType: model.argument.beneficiaryInformation.detCustomerType,
                              fullName: model.argument.beneficiaryInformation.fullName,
                              iban: model.argument.beneficiaryInformation.accountNo,
                              id: model.argument.beneficiaryInformation.id,
                              imageUrl: model.argument.beneficiaryInformation.image,
                              limit: model.argument.beneficiaryInformation.limit,
                              mobileNumber: model.argument.beneficiaryInformation.mobileNumber,
                              nickName: model.argument.beneficiaryInformation.nickName,
                              purpose: model.argument.beneficiaryInformation.purpose,
                              purposeDetails: model.argument.beneficiaryInformation.purposeDetails,
                              purposeParent: model.argument.beneficiaryInformation.purposeParent,
                              purposeParentDetails:
                                  model.argument.beneficiaryInformation.purposeParentDetails,
                              purposeType: model.argument.beneficiaryInformation.purposeType,
                              identifier: model.argument.beneficiaryInformation.identifier),
                          needBackButton: true),
                    );
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
          ),
          Visibility(
            visible: model.navigationType == NavigationType.SEND_MONEY,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.SendAmountToContact,
                      arguments: SendAmountToContactPageArgument(
                          Beneficiary(
                              userId: model.argument.beneficiaryInformation.userId,
                              accountHolderName: model.argument.beneficiaryInformation.fullName,
                              accountNo: model.argument.beneficiaryInformation.accountNo,
                              bankName: model.argument.beneficiaryInformation.bankName,
                              beneType: model.argument.beneficiaryInformation.beneficiaryType,
                              beneficiaryAddress: "",
                              detCustomerType: model.argument.beneficiaryInformation.detCustomerType,
                              fullName: model.argument.beneficiaryInformation.fullName,
                              iban: model.argument.beneficiaryInformation.accountNo,
                              id: model.argument.beneficiaryInformation.id,
                              imageUrl: model.argument.beneficiaryInformation.image,
                              limit: model.argument.beneficiaryInformation.limit,
                              mobileNumber: model.argument.beneficiaryInformation.mobileNumber,
                              nickName: model.argument.beneficiaryInformation.nickName,
                              purpose: model.argument.beneficiaryInformation.purpose,
                              purposeDetails: model.argument.beneficiaryInformation.purposeDetails,
                              purposeParent: model.argument.beneficiaryInformation.purposeParent,
                              purposeParentDetails:
                                  model.argument.beneficiaryInformation.purposeParentDetails,
                              purposeType: model.argument.beneficiaryInformation.purposeType,
                              identifier: model.argument.beneficiaryInformation.identifier),
                          needBackButton: true),
                    );
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
