import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/upload_document/upload_document_bottom_sheet.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/upload_document_later/upload_document_later_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class UploadDocumentsPageView
    extends BasePageViewWidget<UploadDocumentsPageViewModel> {
  UploadDocumentsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                initialData: false,
                stream: model.errorDetectorStream,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                      stream: model.documentsStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          Navigator.pushReplacementNamed(
                              context, RoutePaths.AccountReady);
                        } else if (data.status == Status.ERROR) {
                          if (data.appError!.type ==
                              ErrorType.EMPTY_INCOME_DOCUMENT) {
                            model.incomeDocumentKey.currentState!.isValid =
                                false;
                          } else if (data.appError!.type ==
                              ErrorType.EMPTY_ADDRESS_DOCUMENT) {
                            model.addressDocumentKey.currentState!.isValid =
                                false;
                          }
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (details.primaryDelta!.isNegative) {
                              model.validateDocuments();
                            } else {
                              ProviderScope.containerOf(context)
                                  .read(registerStepFiveViewModelProvider)
                                  .registrationStepFivePageController
                                  .jumpToPage(1);
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 2,
                            color: Theme.of(context)
                                .cardTheme
                                .copyWith(color: AppColor.white)
                                .color,
                            margin: EdgeInsets.zero,
                            shadowColor: AppColor.black.withOpacity(0.32),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                        padding: EdgeInsets.only(bottom: 114),
                                        physics: ClampingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).proofOfIncome,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColorDark),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8.0, bottom: 16),
                                              child: Text(
                                                S.of(context).proofOfIncomeDesc,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                              ),
                                            ),
                                            AppStreamBuilder<String>(
                                              stream:
                                                  model.uploadIncomePoofStream,
                                              initialData: '',
                                              onData: (documentResponse) {
                                                if (documentResponse
                                                    .isNotEmpty) {
                                                  model
                                                      .updateIncomeDocumentField(
                                                          documentResponse);
                                                }
                                              },
                                              dataBuilder: (context, document) {
                                                return AppStreamBuilder<bool>(
                                                  stream: model
                                                      .documentIncomeStream,
                                                  initialData: false,
                                                  dataBuilder:
                                                      (context, isUploaded) {
                                                    return AppTextField(
                                                      labelText: '',
                                                      hintText: S
                                                          .of(context)
                                                          .uploadDocumentsSmall,
                                                      controller: model
                                                          .incomeController,
                                                      key: model
                                                          .incomeDocumentKey,
                                                      readOnly: true,
                                                      hintTextColor:
                                                          AppColor.vivid_orange,
                                                      textColor:
                                                          AppColor.vivid_orange,
                                                      suffixIcon:
                                                          (value, data) {
                                                        return InkWell(
                                                          onTap: !(isUploaded!)
                                                              ? () async {
                                                                  UploadDocumentBottomSheet.show(
                                                                      context,
                                                                      title: S
                                                                          .of(
                                                                              context)
                                                                          .pleaseSelectYourAction,
                                                                      onTakePhoto:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    model.uploadIncomeDocument(
                                                                        DocumentTypeEnum
                                                                            .CAMERA);
                                                                  }, uploadDocument:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    model.uploadIncomeDocument(
                                                                        DocumentTypeEnum
                                                                            .GALLERY);
                                                                  }, onCancel:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }
                                                              : () {
                                                                  model
                                                                      .incomeController
                                                                      .clear();
                                                                  model.updateIncomeUploadedStream(
                                                                      false);
                                                                },
                                                          child: Container(
                                                              height: 16,
                                                              width: 16,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: isUploaded
                                                                  ? AppSvg.asset(
                                                                      AssetUtils
                                                                          .delete)
                                                                  : AppSvg.asset(
                                                                      AssetUtils
                                                                          .upload)),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 24.0, bottom: 24),
                                              child: Container(
                                                height: 1,
                                                color: AppColor.strong_violet,
                                              ),
                                            ),
                                            Text(
                                              S.of(context).proofOfAddress,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColorDark),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8.0, bottom: 16),
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .proofOfAddressDesc,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                              ),
                                            ),
                                            AppStreamBuilder<String>(
                                              stream:
                                                  model.uploadAddressPoofStream,
                                              initialData: '',
                                              onData: (documentResponse) {
                                                if (documentResponse
                                                    .isNotEmpty) {
                                                  model
                                                      .updateAddressDocumentField(
                                                          documentResponse);
                                                }
                                              },
                                              dataBuilder: (context, document) {
                                                return AppStreamBuilder<bool>(
                                                  stream: model
                                                      .documentAddressStream,
                                                  initialData: false,
                                                  dataBuilder:
                                                      (context, isUploaded) {
                                                    return AppTextField(
                                                      labelText: '',
                                                      hintText: S
                                                          .of(context)
                                                          .uploadDocumentsSmall,
                                                      controller: model
                                                          .addressController,
                                                      key: model
                                                          .addressDocumentKey,
                                                      readOnly: true,
                                                      hintTextColor:
                                                          AppColor.vivid_orange,
                                                      textColor:
                                                          AppColor.vivid_orange,
                                                      suffixIcon:
                                                          (value, data) {
                                                        return InkWell(
                                                          onTap: !(isUploaded!)
                                                              ? () async {
                                                                  UploadDocumentBottomSheet.show(
                                                                      context,
                                                                      title: S
                                                                          .of(
                                                                              context)
                                                                          .pleaseSelectYourAction,
                                                                      onTakePhoto:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    model.uploadAddressDocument(
                                                                        DocumentTypeEnum
                                                                            .CAMERA);
                                                                  }, uploadDocument:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    model.uploadAddressDocument(
                                                                        DocumentTypeEnum
                                                                            .GALLERY);
                                                                  }, onCancel:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }
                                                              : () {
                                                                  model
                                                                      .addressController
                                                                      .clear();
                                                                  model.updateAddressUploadedStream(
                                                                      false);
                                                                },
                                                          child: Container(
                                                              height: 16,
                                                              width: 16,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: isUploaded
                                                                  ? AppSvg.asset(
                                                                      AssetUtils
                                                                          .delete)
                                                                  : AppSvg.asset(
                                                                      AssetUtils
                                                                          .upload)),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),

                                            ///TODO:change visibility based on additional nationality
                                            Visibility(
                                                visible: true,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24),
                                                      child: Container(
                                                        height: 1,
                                                        color: AppColor
                                                            .strong_violet,
                                                      ),
                                                    ),
                                                    Text(
                                                      S
                                                          .of(context)
                                                          .additionalNationalityPassport,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              AppColor.white),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, bottom: 16),
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .additionalNationalityPassportDesc,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                AppColor.white),
                                                      ),
                                                    ),
                                                    AppStreamBuilder<String>(
                                                      stream: model
                                                          .additionalNationalityProofStream,
                                                      initialData: '',
                                                      onData:
                                                          (documentResponse) {
                                                        if (documentResponse
                                                            .isNotEmpty) {
                                                          model.updateAdditionalNationalityField(
                                                              documentResponse);
                                                        }
                                                      },
                                                      dataBuilder:
                                                          (context, document) {
                                                        return AppStreamBuilder<
                                                            bool>(
                                                          stream: model
                                                              .documentNationalityStream,
                                                          initialData: false,
                                                          dataBuilder: (context,
                                                              isUploaded) {
                                                            return AppTextField(
                                                              labelText: '',
                                                              hintText: S
                                                                  .of(context)
                                                                  .uploadDocumentsSmall,
                                                              controller: model
                                                                  .additionalNationalityController,
                                                              key: model
                                                                  .additionalNationalityKey,
                                                              readOnly: true,
                                                              hintTextColor:
                                                                  AppColor
                                                                      .vivid_orange,
                                                              textColor: AppColor
                                                                  .vivid_orange,
                                                              suffixIcon:
                                                                  (value,
                                                                      data) {
                                                                return InkWell(
                                                                  onTap: !(isUploaded!)
                                                                      ? () async {
                                                                          UploadDocumentBottomSheet.show(context, title: S.of(context).pleaseSelectYourAction, onTakePhoto:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            model.uploadAdditionalNationalityDocument(DocumentTypeEnum.CAMERA);
                                                                          }, uploadDocument:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            model.uploadAdditionalNationalityDocument(DocumentTypeEnum.GALLERY);
                                                                          }, onCancel:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          });
                                                                        }
                                                                      : () {
                                                                          model
                                                                              .additionalNationalityController
                                                                              .clear();
                                                                          model.updateAdditionalNationalityUploadedStream(
                                                                              false);
                                                                        },
                                                                  child: Container(
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                      padding:
                                                                          EdgeInsets.all(
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
                                                )),
                                            Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 40.0, bottom: 16),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        UploadDocumentLaterDialog
                                                            .show(context,
                                                                onSelected: () {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .uploadDocumentLater,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColor
                                                                .vivid_orange),
                                                      ))),
                                            ),
                                          ],
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        right: 45,
                                        child: AnimatedButton(
                                            buttonText:
                                                S.of(context).swipeToProceed))
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
