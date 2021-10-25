import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/upload_document_divider.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/molecules/upload_document/upload_document_bottom_sheet.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class FatcaUSRelevantW9PageView
    extends BasePageViewWidget<FatcaUSRelevantW9PageViewModel> {
  FatcaUSRelevantW9PageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Text(
          S.of(context).fatcaandPep,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).weNeedToMatchNamesONTaxReturn,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.very_dark_gray,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: AppStreamBuilder<bool>(
            stream: model.errorDetectorStream,
            initialData: false,
            dataBuilder: (context, error) {
              return ShakeAnimatedWidget(
                enabled: error ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<bool>>(
                  stream: model.fatcaUSRelevantW8Stream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerStepFourViewModelProvider)
                          .registrationStepFourPageController
                          .nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validateFatcaUSRelevantW9Details();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(registerStepFourViewModelProvider)
                              .registrationStepFourPageController
                              .jumpToPage(0);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColor.very_soft_violet,
                              gradient: LinearGradient(
                                  colors: [
                                    AppColor.dark_violet,
                                    AppColor.dark_moderate_blue
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: [
                                  AppTextField(
                                    labelText:
                                        S.of(context).nameAsPerIncomeTaxReturn,
                                    hintText: S.of(context).pleaseEnter,
                                    controller:
                                        model.nameAsPerTaxReturnController,
                                    key: model.nameAsPerTaxReturnKey,
                                    inputAction: TextInputAction.go,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText:
                                        S.of(context).businessNameOptional,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.businessNameController,
                                    inputType: TextInputType.text,
                                    inputAction: TextInputAction.go,
                                    key: model.businessNameKey,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      S.of(context).isBusinessNameDifferent,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.very_light_violet),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 32.0),
                                    child: UploadDocumentDivider(
                                      text: S.of(context).orYouCanUpload,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.of(context).w9Form,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.of(context).w9FormDesc,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AppStreamBuilder<String>(
                                    stream: model.uploadDocumentStream,
                                    initialData: '',
                                    onData: (documentResponse) {
                                      if (documentResponse.isNotEmpty) {
                                        model.updateUploadDocumentField(
                                            documentResponse);
                                      }
                                    },
                                    dataBuilder: (context, document) {
                                      return AppStreamBuilder<bool>(
                                        stream: model.documentUploadedStream,
                                        initialData: false,
                                        dataBuilder: (context, isUploaded) {
                                          return AppTextField(
                                            labelText: '',
                                            hintText: S
                                                .of(context)
                                                .uploadDocumentsSmall,
                                            controller:
                                                model.uploadDocumentController,
                                            key: model.uploadDocumentKey,
                                            readOnly: true,
                                            hintTextColor:
                                                AppColor.vivid_orange,
                                            suffixIcon: (value, data) {
                                              return InkWell(
                                                onTap: !(isUploaded!)
                                                    ? () async {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (builder) =>
                                                                UploadDocumentBottomSheetWidget(
                                                                  title: S
                                                                      .of(context)
                                                                      .selectAnyOption,
                                                                  firstOptionText: S
                                                                      .of(context)
                                                                      .storage,
                                                                  secondOptionText: S
                                                                      .of(context)
                                                                      .camera,
                                                                  buttonText: S
                                                                      .of(context)
                                                                      .cancel,
                                                                  onCameraTap:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    model.uploadDocument(
                                                                        DocumentTypeEnum
                                                                            .CAMERA);
                                                                  },
                                                                  onPhotoLibraryTap:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    model.uploadDocument(
                                                                        DocumentTypeEnum
                                                                            .GALLERY);
                                                                  },
                                                                  onCancelTap:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ));
                                                      }
                                                    : () {
                                                        model
                                                            .uploadDocumentController
                                                            .clear();
                                                        model
                                                            .updateDocumentUploadedStream(
                                                                false);
                                                      },
                                                child: Container(
                                                    height: 16,
                                                    width: 16,
                                                    padding: EdgeInsets.all(5),
                                                    child: isUploaded
                                                        ? AppSvg.asset(
                                                            AssetUtils.delete)
                                                        : AppSvg.asset(
                                                            AssetUtils.upload)),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 32, right: 45),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.allFieldValidatorStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return (isValid!)
                                                ? AnimatedButton(
                                                    buttonText: S
                                                        .of(context)
                                                        .swipeToProceed,
                                                    buttonHeight: 50,
                                                  )
                                                : Container();
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
