import 'dart:io';

import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:neo_bank/utils/status.dart';

class AccountSettingPageView
    extends BasePageViewWidget<AccountSettingPageViewModel> {
  AccountSettingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 40),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: AppStreamBuilder<Resource<ProfileInfoResponse>>(
                initialData: Resource.none(),
                stream: model.getProfileInfoStream,
                dataBuilder: (context, profileData) {
                  print('received success');
                  switch (profileData!.status) {
                    case Status.SUCCESS:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppStreamBuilder<String>(
                            stream: model.uploadProfilePhotoStream,
                            initialData: '',
                            onData: (data) {
                              if (data != null && data.isNotEmpty) {
                                model.selectedProfile = data;
                                model.addImage(data);
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
                                            },
                                            onGalleryTap: () {
                                              Navigator.pop(context);
                                              model.uploadProfilePhoto(
                                                  DocumentTypeEnum.PICK_IMAGE);
                                            },
                                            onRemoveTap: () {},
                                            onCancelled: () {
                                              Navigator.pop(context);
                                            },
                                            title: S
                                                .of(context)
                                                .pleaseSelectYourAction);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        radius: 48,
                                        child: CircleAvatar(
                                          radius: 48,
                                          backgroundImage: image!.isEmpty
                                              ? Image.asset(
                                                  AssetUtils.dummyProfile,
                                                  fit: BoxFit.cover,
                                                ).image
                                              : Image.file(
                                                  File(image),
                                                  fit: BoxFit.cover,
                                                ).image,
                                        ),
                                      ));
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text(
                              S.of(context).tapToEditPhoto,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle!
                                      .color),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 32.0, bottom: 16),
                            child: Container(
                              height: 1,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          AccountSettingWidget(
                            image: AssetUtils.email,
                            title: S.of(context).emailAddressSmall,
                            subtitle: (profileData
                                        .data!.content!.email!.isNotEmpty ||
                                    profileData.data!.content!.email != null)
                                ? profileData.data!.content!.email!
                                : 'test@email.com',
                            onTap: () async {
                              var isSuccess = await Navigator.pushNamed(
                                  context, RoutePaths.ChangeEmailAddress);
                              if (isSuccess != null) {
                                //model.getProfileDetails();
                              }
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16),
                            child: Container(
                              height: 1,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          AccountSettingWidget(
                            image: AssetUtils.mobile,
                            title: S.of(context).mobileNumber,
                            subtitle: (profileData.data!.content!.mobileNumber!
                                        .isNotEmpty ||
                                    profileData.data!.content!.mobileNumber !=
                                        null)
                                ? profileData.data!.content!.mobileNumber!
                                : '+962 79 322 8080',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.ChangeMobileNumber);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16),
                            child: Container(
                              height: 1,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          AccountSettingWidget(
                            image: AssetUtils.password,
                            title: S.of(context).changePassword,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.ChangePassword);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16),
                            child: Container(
                              height: 1,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          AppStreamBuilder<bool>(
                            stream: model.switchValue,
                            initialData: profileData.data!.content!.biometric!,
                            dataBuilder: (context, isActive) {
                              return AppStreamBuilder<Resource<bool>>(
                                stream: model.enableBiometricStream,
                                initialData: Resource.none(),
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    model.updateSwitchValue(true);
                                  } else if (data.status == Status.ERROR) {
                                    model.updateSwitchValue(false);
                                  }
                                },
                                dataBuilder: (context, isBiometricEnabled) {
                                  return AppStreamBuilder<
                                      Resource<GenerateKeyPairResponse>>(
                                    initialData: Resource.none(),
                                    stream: model.generateKeyPairStream,
                                    onData: (data) {
                                      if (data.status == Status.SUCCESS) {
                                        model.enableBiometric();
                                      }
                                    },
                                    dataBuilder: (context, keyPairResponse) {
                                      return AppStreamBuilder<Resource<bool>>(
                                        stream:
                                            model.authenticateBioMetricStream,
                                        initialData: Resource.none(),
                                        onData: (data) {
                                          if (data.status == Status.SUCCESS) {
                                            print('authenticated success');
                                            model.generateKeyPair();
                                            // model.showSuccessToast(
                                            //     S.of(context).biometricLoginActivated);
                                          }
                                        },
                                        dataBuilder:
                                            (context, biometricAuthenticated) {
                                          return AppStreamBuilder<
                                              Resource<bool>>(
                                            stream: model.checkBioMetricStream,
                                            initialData: Resource.none(),
                                            onData: (data) {
                                              if (data.status ==
                                                  Status.SUCCESS) {
                                                print('success');
                                                model.authenticateBioMetric(
                                                    title: S
                                                        .of(context)
                                                        .enableBiometricLoginTitle,
                                                    localisedReason: Platform
                                                            .isAndroid
                                                        ? S
                                                            .of(context)
                                                            .enableBiometricLoginDescriptionAndroid
                                                        : S
                                                            .of(context)
                                                            .enableBiometricLoginDescriptionIos);
                                              }
                                            },
                                            dataBuilder:
                                                (context, isAvailable) {
                                              return BiometricSwitchWidget(
                                                onToggle: (value) {
                                                  if (value) {
                                                    model.checkBiometric();
                                                  }
                                                },
                                                isActive: isActive,
                                                title: S
                                                    .of(context)
                                                    .biometricLogin,
                                                image: AssetUtils.biometric,
                                                inActiveText: S.of(context).no,
                                                activeText: S.of(context).yes,
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
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16),
                            child: Container(
                              height: 1,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          AccountSettingWidget(
                            image: AssetUtils.documents,
                            title: S.of(context).myDocuments,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.MyDocuments);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16),
                            child: Container(
                              height: 1,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          AccountSettingWidget(
                            image: AssetUtils.termsCondition,
                            title: S.of(context).termsAndConditionsSetting,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.TermsAndCondition);
                            },
                          ),
                          SizedBox(
                            height: 60,
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
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _cropImage(String data, AccountSettingPageViewModel model,
      BuildContext context) async {
    File? cropped = await ImageCropper.cropImage(
        sourcePath: data,
        cropStyle: CropStyle.circle,
        iosUiSettings: IOSUiSettings(
            resetButtonHidden: true,
            rotateButtonsHidden: true,
            aspectRatioPickerButtonHidden: true,
            doneButtonTitle: 'Choose'),
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (cropped != null) {
      model.selectedProfile = cropped.path;
      model.addImage(cropped.path);
      model.showSuccessToast(S.of(context).profilePhotoUpdated);
    }
  }
}
