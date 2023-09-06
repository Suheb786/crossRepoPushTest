import 'dart:io';

import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_setting/account_setting_widget.dart';
import 'package:neo_bank/ui/molecules/account_setting/biometric_switch_widget.dart';
import 'package:neo_bank/ui/molecules/account_setting/choose_profile_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../ui/molecules/app_svg.dart';
import '../../utils/color_utils.dart';

class AccountSettingPageView extends BasePageViewWidget<AccountSettingPageViewModel> {
  AccountSettingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 52.0.h, bottom: 0.h),
          height: 80.h,
          child: Text(
            S.of(context).profileSettings_,
            textAlign: TextAlign.center,
            softWrap: false,
            style: TextStyle(
                fontSize: 14.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Card(
                margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 40.h, top: 24.h),
                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                    height: constraints.maxHeight,
                    child: SingleChildScrollView(
                      child: AppStreamBuilder<Resource<ProfileInfoResponse>>(
                          initialData: Resource.none(),
                          stream: model.getProfileInfoStream,
                          onData: (data) {
                            if (data.status == Status.SUCCESS) {
                              model.mobile = data.data!.content!.mobileNumber!;
                            }
                          },
                          dataBuilder: (context, profileData) {
                            switch (profileData!.status) {
                              case Status.SUCCESS:
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(height: 15.h),
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
                                            dataBuilder: (context, dataUpload) {
                                              return AppStreamBuilder<String>(
                                                stream: model.uploadProfilePhotoStream,
                                                initialData: '',
                                                onData: (data) {
                                                  if (data.isNotEmpty) {
                                                    model.selectedProfile = data;
                                                    //model.addImage(data);
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
                                                                  await Navigator.pushNamed(
                                                                      context, RoutePaths.CameraCapturePage);

                                                              if (filePath.toString().isNotEmpty)
                                                                model.uploadProfilePhoto(
                                                                    DocumentTypeEnum.CAMERA,
                                                                    cameraPhotoFile: filePath);
                                                            }, onGalleryTap: () {
                                                              Navigator.pop(context);
                                                              model.uploadProfilePhoto(
                                                                  DocumentTypeEnum.PICK_IMAGE);
                                                            }, onRemoveTap: () {
                                                              model.deleteProfileImage(
                                                                  profileData.data!.content!.profileImage);
                                                            }, onCancelled: () {
                                                              Navigator.pop(context);
                                                            }, title: S.of(context).pleaseSelectYourAction);
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor: Theme.of(context).primaryColor,
                                                            radius: 48.w,
                                                            child: CircleAvatar(
                                                              radius: 48.w,
                                                              child: image!.isEmpty
                                                                  ? ((profileData.data!.content!.profileImage
                                                                          .isNotEmpty)
                                                                      ? CircleAvatar(
                                                                          radius: 48.w,
                                                                          backgroundImage: Image.memory(
                                                                            profileData
                                                                                .data!.content!.profileImage!,
                                                                            fit: BoxFit.cover,
                                                                          ).image,
                                                                        )
                                                                      : CircleAvatar(
                                                                          radius: 48.w,
                                                                          backgroundColor:
                                                                              Theme.of(context).primaryColor,
                                                                          child: Text(
                                                                            StringUtils.getFirstInitials(
                                                                                profileData
                                                                                    .data!.content!.fullName),
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 18.t,
                                                                                color: Theme.of(context)
                                                                                    .colorScheme
                                                                                    .secondary),
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
                                              );
                                            },
                                          );
                                        }),
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 32.0.h, bottom: 16.h),
                                      child: Container(
                                        height: 1,
                                        color: Theme.of(context).colorScheme.background,
                                      ),
                                    ),
                                    AccountSettingWidget(
                                      image: AssetUtils.email,
                                      title: S.of(context).emailAddressSmall,
                                      subtitle: (profileData.data!.content!.email!.isNotEmpty ||
                                              profileData.data!.content!.email != null)
                                          ? profileData.data!.content!.email
                                          : '-',
                                      onTap: () async {
                                        var isSuccess =
                                            await Navigator.pushNamed(context, RoutePaths.ChangeEmailAddress);
                                        if (isSuccess != null) {
                                          Future.delayed(Duration(milliseconds: 500), () {
                                            model.getProfileDetails();
                                          });
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.h),
                                      child: Container(
                                        height: 1,
                                        color: Theme.of(context).colorScheme.background,
                                      ),
                                    ),
                                    AccountSettingWidget(
                                      image: AssetUtils.mobile,
                                      title: S.of(context).mobileNumber,
                                      subtitle:
                                          "${profileData.data!.content!.mobileCode != null ? (profileData.data!.content!.mobileCode!.isNotEmpty ? profileData.data!.content!.mobileCode!.replaceAll('00', '+') : '+') : ""}" +
                                              " ${profileData.data!.content!.mobileNumber}",
                                      onTap: () async {
                                        var isSuccess =
                                            await Navigator.pushNamed(context, RoutePaths.ChangeMobileNumber);

                                        if (isSuccess != null) {
                                          Future.delayed(Duration(milliseconds: 500), () {
                                            model.getProfileDetails();
                                          });
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.h),
                                      child: Container(
                                        height: 1,
                                        color: Theme.of(context).colorScheme.background,
                                      ),
                                    ),
                                    AccountSettingWidget(
                                      image: AssetUtils.password,
                                      title: S.of(context).changePassword,
                                      onTap: () {
                                        Navigator.pushNamed(context, RoutePaths.ChangePassword);
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.h),
                                      child: Container(
                                        height: 1,
                                        color: Theme.of(context).colorScheme.background,
                                      ),
                                    ),
                                    AppStreamBuilder<Resource<bool>>(
                                        initialData: Resource.none(),
                                        stream: model.disableFingerPrintStream,
                                        onData: (data) {
                                          if (data.status == Status.SUCCESS) {
                                            model.updateSwitchValue(false);
                                            model.showSuccessToast(S.of(context).biometricLoginDeactivated);
                                          }
                                        },
                                        dataBuilder: (context, keyPairResponse) {
                                          return AppStreamBuilder<bool>(
                                            stream: model.switchValue,
                                            initialData: profileData.data!.content!.biometric!,
                                            dataBuilder: (context, isActive) {
                                              return AppStreamBuilder<Resource<bool>>(
                                                stream: model.enableBiometricStream,
                                                initialData: Resource.none(),
                                                onData: (data) {
                                                  if (data.status == Status.SUCCESS) {
                                                    model.updateSwitchValue(true);
                                                    model.showSuccessToast(
                                                        S.of(context).biometricLoginActivated);
                                                  } else if (data.status == Status.ERROR) {
                                                    model.updateSwitchValue(false);
                                                  }
                                                },
                                                dataBuilder: (context, isBiometricEnabled) {
                                                  return AppStreamBuilder<Resource<GenerateKeyPairResponse>>(
                                                    initialData: Resource.none(),
                                                    stream: model.generateKeyPairStream,
                                                    onData: (data) {
                                                      if (data.status == Status.SUCCESS) {
                                                        model.enableBiometric();
                                                      }
                                                    },
                                                    dataBuilder: (context, keyPairResponse) {
                                                      return AppStreamBuilder<Resource<bool>>(
                                                        stream: model.authenticateBioMetricStream,
                                                        initialData: Resource.none(),
                                                        onData: (data) {
                                                          if (data.status == Status.SUCCESS) {
                                                            if (data.data!) {
                                                              model.generateKeyPair();
                                                            }
                                                          }
                                                        },
                                                        dataBuilder: (context, biometricAuthenticated) {
                                                          return AppStreamBuilder<Resource<bool>>(
                                                            stream: model.checkBioMetricStream,
                                                            initialData: Resource.none(),
                                                            onData: (data) {
                                                              if (data.status == Status.SUCCESS) {
                                                                model.authenticateBioMetric(
                                                                    title: S
                                                                        .of(context)
                                                                        .enableBiometricLoginTitle,
                                                                    localisedReason: Platform.isAndroid
                                                                        ? S
                                                                            .of(context)
                                                                            .enableBiometricLoginDescriptionAndroid
                                                                        : S
                                                                            .of(context)
                                                                            .enableBiometricLoginDescriptionIos);
                                                              }
                                                            },
                                                            dataBuilder: (context, isAvailable) {
                                                              return BiometricSwitchWidget(
                                                                onToggle: (value) {
                                                                  if (value) {
                                                                    model.checkBiometric();
                                                                  } else if (!value) {
                                                                    model.disableFingerPrint();
                                                                  }
                                                                },
                                                                isActive: isActive,
                                                                title: S.of(context).biometricLogin,
                                                                image: AssetUtils.biometric,
                                                                inActiveText: S.of(context).no.toUpperCase(),
                                                                activeText: S.of(context).yes.toUpperCase(),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 16.0, bottom: 16),
                                    //   child: Container(
                                    //     height: 1,
                                    //     color: Theme.of(context)
                                    //         .backgroundColor,
                                    //   ),
                                    // ),
                                    // AccountSettingWidget(
                                    //   image: AssetUtils.documents,
                                    //   title: S.of(context).myDocuments,
                                    //   onTap: () {
                                    //     Navigator.pushNamed(context,
                                    //         RoutePaths.MyDocuments);
                                    //   },
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 16.0, bottom: 16),
                                    //   child: Container(
                                    //     height: 1,
                                    //     color: Theme.of(context)
                                    //         .backgroundColor,
                                    //   ),
                                    // ),
                                    // AccountSettingWidget(
                                    //   image: AssetUtils.termsCondition,
                                    //   title: S
                                    //       .of(context)
                                    //       .termsAndConditionsSetting,
                                    //   onTap: () {
                                    //     Navigator.pushNamed(context,
                                    //         RoutePaths.TermsAndCondition);
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 60.h,
                                    )
                                  ],
                                );

                              case Status.ERROR:
                                return Center(
                                  child: Text('Something went wrong'),
                                );
                              default:
                                return Container();
                            }
                          }),
                    ),
                  );
                }),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                        ]),
                    child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _cropImage(String data, AccountSettingPageViewModel model, BuildContext context) async {
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
      model.uploadProfileImage();
      // model.addImage(cropped.path);
      // model.showSuccessToast(S.of(context).profilePhotoUpdated);
    }
  }
}
