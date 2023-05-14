import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/my_documents/my_documents_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/molecules/upload_document_selection_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class MyDocumentsPageView extends BasePageViewWidget<MyDocumentsPageViewModel> {
  MyDocumentsPageView(ProviderBase model) : super(model);

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
                          } else if (data.status == Status.ERROR) {
                            if (data.appError!.type == ErrorType.EMPTY_INCOME_DOCUMENT) {
                              model.incomeDocumentKey.currentState!.isValid = false;
                            } else if (data.appError!.type == ErrorType.EMPTY_ADDRESS_DOCUMENT) {
                              model.addressDocumentKey.currentState!.isValid = false;
                            } else if (data.appError!.type == ErrorType.EMPTY_NATIONALITY_DOCUMENT) {
                              model.additionalNationalityKey.currentState!.isValid = false;
                            }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity!.isNegative) {
                                //model.validateDocuments();
                              }
                            },
                            child: Card(
                              margin: EdgeInsets.only(left: 24, right: 24, bottom: 40),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                  child: SingleChildScrollView(
                                      physics: ClampingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).proofOfIncome,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).primaryColorDark),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0, bottom: 16),
                                            child: Text(
                                              S.of(context).proofOfIncomeDescSetting,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).primaryColorDark),
                                            ),
                                          ),
                                          AppStreamBuilder<String>(
                                            stream: model.uploadIncomePoofStream,
                                            initialData: '',
                                            onData: (documentResponse) {
                                              if (documentResponse.isNotEmpty) {
                                                model.updateIncomeDocumentField(documentResponse);
                                                model.validateFields();
                                              }
                                            },
                                            dataBuilder: (context, document) {
                                              return AppStreamBuilder<bool>(
                                                stream: model.documentIncomeStream,
                                                initialData: true,
                                                dataBuilder: (context, isUploaded) {
                                                  return AppStreamBuilder<Resource<FileUploadResponse>>(
                                                    stream: model.uploadIncomeProofDocumentStream,
                                                    initialData: Resource.none(),
                                                    onData: (data) {
                                                      ///uncomment once api integration done
                                                      // if (data.status ==
                                                      //     Status.SUCCESS) {
                                                      //   model.incomeProofDocumentId =
                                                      //       data
                                                      //           .data!
                                                      //           .fileUploadContent!
                                                      //           .documentId!;
                                                      //   model.isIncomeDocumentUploaded =
                                                      //       true;
                                                      //   model
                                                      //       .validateFields();
                                                      // }
                                                    },
                                                    dataBuilder: (context, incomeUploadedResponse) {
                                                      return AppTextField(
                                                        labelText: '',
                                                        hintText: S.of(context).uploadDocumentsSmall,
                                                        controller: model.incomeController,
                                                        key: model.incomeDocumentKey,
                                                        readOnly: true,
                                                        hintTextColor: Theme.of(context).primaryColorDark,
                                                        textFieldBorderColor:
                                                            Theme.of(context).primaryColorDark,
                                                        textColor: Theme.of(context).primaryColorDark,
                                                        suffixIcon: (value, data) {
                                                          return InkWell(
                                                            onTap: !(isUploaded!)
                                                                ? () async {
                                                                    UploadDocumentSelectionWidget.show(
                                                                        context, onCameraTap: () {
                                                                      Navigator.pop(context);
                                                                      model.uploadIncomeDocument(
                                                                          DocumentTypeEnum.CAMERA);
                                                                    }, onUploadDocumentTap: () {
                                                                      Navigator.pop(context);
                                                                      model.uploadIncomeDocument(
                                                                          DocumentTypeEnum.GALLERY);
                                                                    }, onCancelled: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                        title: S
                                                                            .of(context)
                                                                            .pleaseSelectYourAction);
                                                                  }
                                                                : () {
                                                                    model.incomeController.clear();
                                                                    model.updateIncomeUploadedStream(false);
                                                                    model.isIncomeDocumentUploaded = false;
                                                                    model.incomeProofDocumentId = '';
                                                                    model.validateFields();
                                                                  },
                                                            child: Container(
                                                                height: 16,
                                                                width: 16,
                                                                padding: EdgeInsets.all(5),
                                                                child: isUploaded
                                                                    ? AppSvg.asset(
                                                                        AssetUtils.delete,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark,
                                                                      )
                                                                    : AppSvg.asset(
                                                                        AssetUtils.upload,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark,
                                                                      )),
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
                                            padding: EdgeInsets.only(top: 24.0, bottom: 24),
                                            child: Container(
                                              height: 1,
                                              color: AppColor.dark_gray_1,
                                            ),
                                          ),
                                          Text(
                                            S.of(context).proofOfAddress,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).primaryColorDark),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0, bottom: 16),
                                            child: Text(
                                              S.of(context).proofOfAddressDescSetting,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).primaryColorDark),
                                            ),
                                          ),
                                          AppStreamBuilder<String>(
                                            stream: model.uploadAddressPoofStream,
                                            initialData: '',
                                            onData: (documentResponse) {
                                              if (documentResponse.isNotEmpty) {
                                                model.updateAddressDocumentField(documentResponse);
                                                model.validateFields();
                                              }
                                            },
                                            dataBuilder: (context, document) {
                                              return AppStreamBuilder<bool>(
                                                stream: model.documentAddressStream,
                                                initialData: true,
                                                dataBuilder: (context, isUploaded) {
                                                  return AppStreamBuilder<Resource<FileUploadResponse>>(
                                                    stream: model.uploadAddressProofDocumentStream,
                                                    initialData: Resource.none(),
                                                    onData: (addressProofResponse) {
                                                      // if (addressProofResponse
                                                      //         .status ==
                                                      //     Status.SUCCESS) {
                                                      //   model.addressProofDocumentId =
                                                      //       addressProofResponse
                                                      //           .data!
                                                      //           .fileUploadContent!
                                                      //           .documentId!;
                                                      //   model.isAddressDocumentUploaded =
                                                      //       true;
                                                      //   model
                                                      //       .validateFields();
                                                      // }
                                                    },
                                                    dataBuilder: (context, data) {
                                                      return AppTextField(
                                                        labelText: '',
                                                        hintText: S.of(context).uploadDocumentsSmall,
                                                        controller: model.addressController,
                                                        key: model.addressDocumentKey,
                                                        readOnly: true,
                                                        textFieldBorderColor:
                                                            Theme.of(context).primaryColorDark,
                                                        hintTextColor: Theme.of(context).primaryColorDark,
                                                        textColor: Theme.of(context).primaryColorDark,
                                                        suffixIcon: (value, data) {
                                                          return InkWell(
                                                            onTap: !(isUploaded!)
                                                                ? () async {
                                                                    UploadDocumentSelectionWidget.show(
                                                                        context, onCameraTap: () {
                                                                      Navigator.pop(context);
                                                                      model.uploadAddressDocument(
                                                                          DocumentTypeEnum.CAMERA);
                                                                    }, onUploadDocumentTap: () {
                                                                      Navigator.pop(context);
                                                                      model.uploadAddressDocument(
                                                                          DocumentTypeEnum.GALLERY);
                                                                    }, onCancelled: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                        title: S
                                                                            .of(context)
                                                                            .pleaseSelectYourAction);
                                                                  }
                                                                : () {
                                                                    model.addressController.clear();
                                                                    model.updateAddressUploadedStream(false);
                                                                    model.isAddressDocumentUploaded = false;
                                                                    model.addressProofDocumentId = '';
                                                                    model.validateFields();
                                                                  },
                                                            child: Container(
                                                                height: 16,
                                                                width: 16,
                                                                padding: EdgeInsets.all(5),
                                                                child: isUploaded
                                                                    ? AppSvg.asset(
                                                                        AssetUtils.delete,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark,
                                                                      )
                                                                    : AppSvg.asset(
                                                                        AssetUtils.upload,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark,
                                                                      )),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          // Center(
                                          //   child: AppStreamBuilder<bool>(
                                          //     stream: model
                                          //         .showAnimatedButtonStream,
                                          //     initialData: false,
                                          //     dataBuilder:
                                          //         (context, isValid) {
                                          //       return Visibility(
                                          //         visible: isValid!,
                                          //         child: AnimatedButton(
                                          //             buttonText: S
                                          //                 .of(context)
                                          //                 .swipeToProceed),
                                          //       );
                                          //     },
                                          //   ),
                                          // )
                                        ],
                                      ))),
                            ),
                          );
                        },
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
