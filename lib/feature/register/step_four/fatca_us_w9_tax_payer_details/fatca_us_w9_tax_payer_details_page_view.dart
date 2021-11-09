import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog.dart';
import 'package:neo_bank/ui/molecules/register/declaration_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/molecules/upload_document/upload_document_bottom_sheet.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class FatcaUSW9TaxPayersDetailsPageView
    extends BasePageViewWidget<FatcaUSW9TaxPayersDetailsPageViewModel> {
  FatcaUSW9TaxPayersDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
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
                  stream: model.fatcaUSW9taxPayerDetailsStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerViewModelProvider)
                          .registrationStepsController
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
                          model.validateFatcaUSW9TaxPayersDetails();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(registerStepFourViewModelProvider)
                              .registrationStepFourPageController
                              .previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        shadowColor: AppColor.black.withOpacity(0.32),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          labelText:
                                              S.of(context).whichTaxPayerAreYou,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.taxPayerTypeController,
                                          key: model.taxPayerTypeKey,
                                          readOnly: true,
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                TaxPayerDialog.show(context,
                                                    taxPayerTypeEnum:
                                                        TaxPayerTypeEnum.W9,
                                                    onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.updateTaxPayerTypeField(
                                                      value);
                                                  model.isValid();
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        AppStreamBuilder<bool>(
                                          stream: model
                                              .socialSecurityVisibilityStream,
                                          initialData: false,
                                          dataBuilder: (context, isVisible) {
                                            return Visibility(
                                              visible: isVisible!,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .socialSecurityNUmber,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller: model
                                                        .socialSecurityNumberController,
                                                    key: model
                                                        .socialSecurityNumberKey,
                                                    inputAction:
                                                        TextInputAction.go,
                                                    onChanged: (value) {
                                                      model.isValid();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 32,
                                                  ),
                                                  Text(
                                                    S
                                                        .of(context)
                                                        .socialSecurityCard,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        color: AppColor
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .only(
                                                        bottom: 16.0,top:8),
                                                    child: Text(
                                                      S
                                                          .of(context)
                                                          .socialSecurityCardDesc,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          color: AppColor
                                                              .very_light_gray_white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  AppStreamBuilder<String>(
                                                    stream: model
                                                        .uploadDocumentStream,
                                                    initialData: '',
                                                    onData: (documentResponse) {
                                                      if (documentResponse
                                                          .isNotEmpty) {
                                                        model.updateUploadDocumentField(
                                                            documentResponse);
                                                      }
                                                    },
                                                    dataBuilder:
                                                        (context, document) {
                                                      return AppStreamBuilder<
                                                          bool>(
                                                        stream: model
                                                            .documentUploadedStream,
                                                        initialData: false,
                                                        dataBuilder: (context,
                                                            isUploaded) {
                                                          return AppTextField(
                                                            labelText: '',
                                                            hintText: S
                                                                .of(context)
                                                                .uploadDocumentsSmall,
                                                            controller: model
                                                                .uploadDocumentController,
                                                            key: model
                                                                .uploadDocumentKey,
                                                            readOnly: true,
                                                            textColor: AppColor
                                                                .vivid_orange,
                                                            hintTextColor:
                                                                AppColor
                                                                    .vivid_orange,
                                                            suffixIcon:
                                                                (value, data) {
                                                              return InkWell(
                                                                onTap: !(isUploaded!)
                                                                    ? () async {
                                                                        showModalBottomSheet(
                                                                            context:
                                                                                context,
                                                                            builder: (builder) =>
                                                                                UploadDocumentBottomSheetWidget(
                                                                                  title: S.of(context).selectAnyOption,
                                                                                  firstOptionText: S.of(context).storage,
                                                                                  secondOptionText: S.of(context).camera,
                                                                                  buttonText: S.of(context).cancel,
                                                                                  onCameraTap: () {
                                                                                    Navigator.pop(context);
                                                                                    model.uploadDocument(DocumentTypeEnum.CAMERA);
                                                                                  },
                                                                                  onPhotoLibraryTap: () {
                                                                                    Navigator.pop(context);
                                                                                    model.uploadDocument(DocumentTypeEnum.GALLERY);
                                                                                  },
                                                                                  onCancelTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                ));
                                                                      }
                                                                    : () {
                                                                        model
                                                                            .uploadDocumentController
                                                                            .clear();
                                                                        model.updateDocumentUploadedStream(
                                                                            false);
                                                                      },
                                                                child: Container(
                                                                    height: 16,
                                                                    width: 16,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                5),
                                                                    child: isUploaded
                                                                        ? AppSvg.asset(AssetUtils
                                                                            .delete)
                                                                        : AppSvg.asset(
                                                                            AssetUtils.upload)),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    AppStreamBuilder<bool>(
                                      stream: model.declarationSelectedStream,
                                      initialData: false,
                                      dataBuilder: (context, isSelected) {
                                        return DeclarationWidget(
                                          isSelected: isSelected,
                                          title1: S.of(context).iConfirmThatMy,
                                          title2: S.of(context).fatca,
                                          title3: S
                                              .of(context)
                                              .declarationIsTrueAndCorrect,
                                          onTap: () {
                                            model.updateDeclarationSelection(
                                                !(isSelected!));
                                            model.isValid();
                                          },
                                        );
                                      },
                                    ),
                                    AppStreamBuilder<bool>(
                                      stream: model
                                          .verifyInfoDeclarationSelectedStream,
                                      initialData: false,
                                      dataBuilder: (context, isSelected) {
                                        return DeclarationWidget(
                                          isSelected: isSelected,
                                          title1: S
                                              .of(context)
                                              .verifyInformationDirectlyOrUsingThirdPartyAgentDesc,
                                          onTap: () {
                                            model
                                                .updateVerifyInfoDeclarationSelection(
                                                !(isSelected!));
                                            model.isValid();
                                          },
                                        );
                                      },
                                    ),
                                    Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 26, right: 45),
                                        child: AppStreamBuilder<bool>(
                                            stream:
                                                model.allFieldValidatorStream,
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
                                    ),
                                  ],
                                )
                              ],
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
