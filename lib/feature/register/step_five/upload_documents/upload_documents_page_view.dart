import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/customer_status_enum.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/model/upload_document/save_upload_document_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/upload_document_later/upload_document_later_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/molecules/upload_document_selection_widget.dart';
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
                    child: AppStreamBuilder<Resource<CreateAccountResponse>>(
                        stream: model.createAccountStream,
                        initialData: Resource.none(),
                        onData: (createAccountData) {
                          if (createAccountData.status == Status.SUCCESS) {
                            model.getCustomerStatus();
                          }
                        },
                        dataBuilder: (context, createAccountData) {
                          return AppStreamBuilder<Resource<GetAccountResponse>>(
                              stream: model.getAccountStream,
                              initialData: Resource.none(),
                              onData: (getAccountData) {
                                if (getAccountData.status == Status.SUCCESS) {
                                  model.createAccount(
                                      getAccountData
                                          .data!.content!.accountDetails!,
                                      getAccountData
                                          .data!.content!.customerInformation!);
                                }
                              },
                              dataBuilder: (context, getAccountData) {
                                return AppStreamBuilder<
                                        Resource<CustomerStatus>>(
                                    stream: model.customerStatusStream,
                                    initialData: Resource.none(),
                                    onData: (userStatus) {
                                      if (userStatus.status == Status.SUCCESS) {
                                        // ProviderScope.containerOf(context)
                                        //         .read(
                                        //             registerStepFiveViewModelProvider)
                                        //         .secondNextScreen =
                                        //     userStatus.data!.secondNextPage!;
                                        model.isSecondNextPage
                                            ? getSecondNextPage(
                                                userStatus.data!,
                                                model,
                                                context)
                                            : getNextPage(userStatus.data!,
                                                model, context);
                                      }
                                    },
                                    dataBuilder: (context, userStatus) {
                                      return AppStreamBuilder<Resource<bool>>(
                                        stream: model.removeDebitLockStream,
                                        initialData: Resource.none(),
                                        onData: (data) {
                                          if (data.status == Status.SUCCESS) {
                                            model.getCustomerStatus();
                                            // Navigator.pushReplacementNamed(
                                            //     context, RoutePaths.AccountReady);
                                          }
                                        },
                                        dataBuilder:
                                            (context, debitLockResponse) {
                                          return AppStreamBuilder<
                                              Resource<
                                                  SaveUploadDocumentResponse>>(
                                            stream: model.documentsStream,
                                            initialData: Resource.none(),
                                            onData: (data) {
                                              if (data.status ==
                                                  Status.SUCCESS) {
                                                model.isDocumentSkipped = false;
                                                model.getCustomerStatus();
                                              } else if (data.status ==
                                                  Status.ERROR) {
                                                model.showToastWithError(
                                                    data.appError!);
                                              }
                                            },
                                            dataBuilder: (context, data) {
                                              return GestureDetector(
                                                onHorizontalDragEnd: (details) {
                                                  if (details.primaryVelocity!
                                                      .isNegative) {
                                                    model.validateDocuments();
                                                  } else {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      ProviderScope.containerOf(
                                                              context)
                                                          .read(
                                                              registerStepFiveViewModelProvider)
                                                          .registrationStepFivePageController
                                                          .move(0,
                                                              animation: false);
                                                    });
                                                  }
                                                },
                                                child: Card(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets
                                                                          .bottom -
                                                                      50 <=
                                                                  0
                                                              ? 0
                                                              : MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom -
                                                                  48),
                                                      child:
                                                          SingleChildScrollView(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          32,
                                                                      horizontal:
                                                                          24),
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    S
                                                                        .of(context)
                                                                        .proofOfIncome,
                                                                    softWrap:
                                                                        true,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            16),
                                                                    child: Text(
                                                                      S
                                                                          .of(context)
                                                                          .proofOfIncomeDesc,
                                                                      softWrap:
                                                                          true,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Theme.of(context).primaryColorDark),
                                                                    ),
                                                                  ),
                                                                  AppStreamBuilder<
                                                                      String>(
                                                                    stream: model
                                                                        .uploadIncomePoofStream,
                                                                    initialData:
                                                                        '',
                                                                    onData:
                                                                        (documentResponse) {
                                                                      if (documentResponse
                                                                          .isNotEmpty) {
                                                                        model.updateIncomeDocumentField(
                                                                            documentResponse);
                                                                      }
                                                                    },
                                                                    dataBuilder:
                                                                        (context,
                                                                            document) {
                                                                      return AppStreamBuilder<
                                                                          bool>(
                                                                        stream:
                                                                            model.documentIncomeStream,
                                                                        initialData:
                                                                            false,
                                                                        dataBuilder:
                                                                            (context,
                                                                                isUploaded) {
                                                                          return AppStreamBuilder<
                                                                              Resource<FileUploadResponse>>(
                                                                            stream:
                                                                                model.uploadIncomeProofDocumentStream,
                                                                            initialData:
                                                                                Resource.none(),
                                                                            onData:
                                                                                (data) {
                                                                              if (data.status == Status.SUCCESS) {
                                                                                model.incomeProofDocumentId = data.data!.fileUploadContent!.documentId!;
                                                                                model.isIncomeDocumentUploaded = true;
                                                                                model.validateFields();
                                                                              }
                                                                            },
                                                                            dataBuilder:
                                                                                (context, incomeUploadedResponse) {
                                                                              return AppTextField(
                                                                                labelText: '',
                                                                                hintText: S.of(context).uploadDocumentsSmall,
                                                                                controller: model.incomeController,
                                                                                fontSize: 12,
                                                                                containerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                                                // key: model
                                                                                //     .incomeDocumentKey,
                                                                                readOnly: true,
                                                                                hintTextColor: Theme.of(context).primaryColorDark,
                                                                                textFieldBorderColor: Theme.of(context).accentTextTheme.bodyText1!.color,
                                                                                textColor: Theme.of(context).primaryColorDark,
                                                                                suffixIcon: (value, data) {
                                                                                  return InkWell(
                                                                                    onTap: !(isUploaded!)
                                                                                        ? () async {
                                                                                            UploadDocumentSelectionWidget.show(context, onCameraTap: () {
                                                                                              Navigator.pop(context);
                                                                                              model.uploadIncomeDocument(DocumentTypeEnum.CAMERA);
                                                                                            }, onUploadDocumentTap: () {
                                                                                              Navigator.pop(context);
                                                                                              model.uploadIncomeDocument(DocumentTypeEnum.GALLERY);
                                                                                            }, onCancelled: () {
                                                                                              Navigator.pop(context);
                                                                                            }, title: S.of(context).pleaseSelectYourAction);
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
                                                                                        padding: EdgeInsets.all(7),
                                                                                        child: isUploaded
                                                                                            ? AppSvg.asset(
                                                                                                AssetUtils.delete,
                                                                                                color: Theme.of(context).primaryColorDark,
                                                                                              )
                                                                                            : AppSvg.asset(
                                                                                                AssetUtils.upload,
                                                                                                color: Theme.of(context).primaryColorDark,
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
                                                                    padding: EdgeInsets.only(
                                                                        top:
                                                                            24.0,
                                                                        bottom:
                                                                            24),
                                                                    child:
                                                                        Container(
                                                                      height: 1,
                                                                      color: AppColor
                                                                          .whiteGrey,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    S
                                                                        .of(context)
                                                                        .proofOfAddress,
                                                                    softWrap:
                                                                        true,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            16),
                                                                    child: Text(
                                                                      S
                                                                          .of(context)
                                                                          .proofOfAddressDesc,
                                                                      softWrap:
                                                                          true,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Theme.of(context).primaryColorDark),
                                                                    ),
                                                                  ),
                                                                  AppStreamBuilder<
                                                                      String>(
                                                                    stream: model
                                                                        .uploadAddressPoofStream,
                                                                    initialData:
                                                                        '',
                                                                    onData:
                                                                        (documentResponse) {
                                                                      if (documentResponse
                                                                          .isNotEmpty) {
                                                                        model.updateAddressDocumentField(
                                                                            documentResponse);
                                                                      }
                                                                    },
                                                                    dataBuilder:
                                                                        (context,
                                                                            document) {
                                                                      return AppStreamBuilder<
                                                                          bool>(
                                                                        stream:
                                                                            model.documentAddressStream,
                                                                        initialData:
                                                                            false,
                                                                        dataBuilder:
                                                                            (context,
                                                                                isUploaded) {
                                                                          return AppStreamBuilder<
                                                                              Resource<FileUploadResponse>>(
                                                                            stream:
                                                                                model.uploadAddressProofDocumentStream,
                                                                            initialData:
                                                                                Resource.none(),
                                                                            onData:
                                                                                (addressProofResponse) {
                                                                              if (addressProofResponse.status == Status.SUCCESS) {
                                                                                model.addressProofDocumentId = addressProofResponse.data!.fileUploadContent!.documentId!;
                                                                                model.isAddressDocumentUploaded = true;
                                                                                model.validateFields();
                                                                              }
                                                                            },
                                                                            dataBuilder:
                                                                                (context, data) {
                                                                              return AppTextField(
                                                                                labelText: '',
                                                                                hintText: S.of(context).uploadDocumentsSmall,
                                                                                controller: model.addressController,
                                                                                // key: model
                                                                                //     .addressDocumentKey,
                                                                                fontSize: 12,
                                                                                containerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                                                readOnly: true,
                                                                                textFieldBorderColor: Theme.of(context).accentTextTheme.bodyText1!.color,
                                                                                hintTextColor: Theme.of(context).primaryColorDark,
                                                                                textColor: Theme.of(context).primaryColorDark,
                                                                                suffixIcon: (value, data) {
                                                                                  return InkWell(
                                                                                    onTap: !(isUploaded!)
                                                                                        ? () async {
                                                                                            UploadDocumentSelectionWidget.show(context, onCameraTap: () {
                                                                                              Navigator.pop(context);
                                                                                              model.uploadAddressDocument(DocumentTypeEnum.CAMERA);
                                                                                            }, onUploadDocumentTap: () {
                                                                                              Navigator.pop(context);
                                                                                              model.uploadAddressDocument(DocumentTypeEnum.GALLERY);
                                                                                            }, onCancelled: () {
                                                                                              Navigator.pop(context);
                                                                                            }, title: S.of(context).pleaseSelectYourAction);
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
                                                                                        padding: EdgeInsets.all(7),
                                                                                        child: isUploaded
                                                                                            ? AppSvg.asset(
                                                                                                AssetUtils.delete,
                                                                                                color: Theme.of(context).primaryColorDark,
                                                                                              )
                                                                                            : AppSvg.asset(
                                                                                                AssetUtils.upload,
                                                                                                color: Theme.of(context).primaryColorDark,
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
                                                                  // AppStreamBuilder<
                                                                  //     Resource<
                                                                  //         CheckOtherNationalityResponse>>(
                                                                  //   initialData: Resource.none(),
                                                                  //   stream: model
                                                                  //       .checkOtherNationalityStatusStream,
                                                                  //   onData: (data) {
                                                                  //     if (data.status == Status.SUCCESS) {
                                                                  //       model.isOtherNationality = data
                                                                  //           .data!
                                                                  //           .checkOtherNationalityResponseContent!
                                                                  //           .status!;
                                                                  //     }
                                                                  //   },
                                                                  //   dataBuilder: (context, status) {
                                                                  //     return Visibility(
                                                                  //         visible: status!
                                                                  //             .data!
                                                                  //             .checkOtherNationalityResponseContent!
                                                                  //             .status!,
                                                                  //         child: Column(
                                                                  //           crossAxisAlignment:
                                                                  //               CrossAxisAlignment.start,
                                                                  //           children: [
                                                                  //             Padding(
                                                                  //               padding:
                                                                  //                   EdgeInsets.symmetric(
                                                                  //                       vertical: 24),
                                                                  //               child: Container(
                                                                  //                 height: 1,
                                                                  //                 color: AppColor
                                                                  //                     .dark_gray_1,
                                                                  //               ),
                                                                  //             ),
                                                                  //             Text(
                                                                  //               S
                                                                  //                   .of(context)
                                                                  //                   .additionalNationalityPassport,
                                                                  //               softWrap: true,
                                                                  //               style: TextStyle(
                                                                  //                   fontSize: 14,
                                                                  //                   fontWeight:
                                                                  //                       FontWeight.w600,
                                                                  //                   color: Theme.of(
                                                                  //                           context)
                                                                  //                       .primaryColorDark),
                                                                  //             ),
                                                                  //             Padding(
                                                                  //               padding: EdgeInsets.only(
                                                                  //                   top: 8.0, bottom: 16),
                                                                  //               child: Text(
                                                                  //                 S
                                                                  //                     .of(context)
                                                                  //                     .additionalNationalityPassportDesc,
                                                                  //                 softWrap: true,
                                                                  //                 style: TextStyle(
                                                                  //                     fontSize: 12,
                                                                  //                     fontWeight:
                                                                  //                         FontWeight.w400,
                                                                  //                     color: Theme.of(
                                                                  //                             context)
                                                                  //                         .primaryColorDark),
                                                                  //               ),
                                                                  //             ),
                                                                  //             AppStreamBuilder<String>(
                                                                  //               stream: model
                                                                  //                   .additionalNationalityProofStream,
                                                                  //               initialData: '',
                                                                  //               onData:
                                                                  //                   (documentResponse) {
                                                                  //                 if (documentResponse
                                                                  //                     .isNotEmpty) {
                                                                  //                   model.updateAdditionalNationalityField(
                                                                  //                       documentResponse);
                                                                  //                 }
                                                                  //               },
                                                                  //               dataBuilder:
                                                                  //                   (context, document) {
                                                                  //                 return AppStreamBuilder<
                                                                  //                     bool>(
                                                                  //                   stream: model
                                                                  //                       .documentNationalityStream,
                                                                  //                   initialData: false,
                                                                  //                   dataBuilder: (context,
                                                                  //                       isUploaded) {
                                                                  //                     return AppStreamBuilder<
                                                                  //                         Resource<
                                                                  //                             FileUploadResponse>>(
                                                                  //                       stream: model
                                                                  //                           .uploadOtherNationalityProofDocumentStream,
                                                                  //                       initialData:
                                                                  //                           Resource
                                                                  //                               .none(),
                                                                  //                       onData:
                                                                  //                           (otherNationalityUploadResponse) {
                                                                  //                         if (otherNationalityUploadResponse
                                                                  //                                 .status ==
                                                                  //                             Status
                                                                  //                                 .SUCCESS) {
                                                                  //                           model.otherNationalityProofDocumentId =
                                                                  //                               otherNationalityUploadResponse
                                                                  //                                   .data!
                                                                  //                                   .fileUploadContent!
                                                                  //                                   .documentId!;
                                                                  //                           model.isOtherNationalityDocumentUploaded =
                                                                  //                               true;
                                                                  //                           model
                                                                  //                               .validateFields();
                                                                  //                         }
                                                                  //                       },
                                                                  //                       dataBuilder:
                                                                  //                           (context,
                                                                  //                               data) {
                                                                  //                         return AppTextField(
                                                                  //                           labelText: '',
                                                                  //                           hintText: S
                                                                  //                               .of(context)
                                                                  //                               .uploadDocumentsSmall,
                                                                  //                           controller: model
                                                                  //                               .additionalNationalityController,
                                                                  //                           key: model
                                                                  //                               .additionalNationalityKey,
                                                                  //                           textFieldBorderColor: Theme.of(
                                                                  //                                   context)
                                                                  //                               .accentTextTheme
                                                                  //                               .bodyText1!
                                                                  //                               .color,
                                                                  //                           readOnly:
                                                                  //                               true,
                                                                  //                           hintTextColor:
                                                                  //                               Theme.of(
                                                                  //                                       context)
                                                                  //                                   .primaryColorDark,
                                                                  //                           textColor: Theme.of(
                                                                  //                                   context)
                                                                  //                               .primaryColorDark,
                                                                  //                           suffixIcon:
                                                                  //                               (value,
                                                                  //                                   data) {
                                                                  //                             return InkWell(
                                                                  //                               onTap: !(isUploaded!)
                                                                  //                                   ? () async {
                                                                  //                                       UploadDocumentSelectionWidget.show(context, title: S.of(context).pleaseSelectYourAction, onCameraTap: () {
                                                                  //                                         Navigator.pop(context);
                                                                  //                                         model.uploadAdditionalNationalityDocument(DocumentTypeEnum.CAMERA);
                                                                  //                                       }, onUploadDocumentTap: () {
                                                                  //                                         Navigator.pop(context);
                                                                  //                                         model.uploadAdditionalNationalityDocument(DocumentTypeEnum.GALLERY);
                                                                  //                                       }, onCancelled: () {
                                                                  //                                         Navigator.pop(context);
                                                                  //                                       });
                                                                  //                                     }
                                                                  //                                   : () {
                                                                  //                                       model.additionalNationalityController.clear();
                                                                  //                                       model.isOtherNationalityDocumentUploaded = false;
                                                                  //                                       model.otherNationalityProofDocumentId = '';
                                                                  //                                       model.validateFields();
                                                                  //                                       model.updateAdditionalNationalityUploadedStream(false);
                                                                  //                                     },
                                                                  //                               child: Container(
                                                                  //                                   height: 16,
                                                                  //                                   width: 16,
                                                                  //                                   padding: EdgeInsets.all(5),
                                                                  //                                   child: isUploaded
                                                                  //                                       ? AppSvg.asset(
                                                                  //                                           AssetUtils.delete,
                                                                  //                                           color: Theme.of(context).primaryColorDark,
                                                                  //                                         )
                                                                  //                                       : AppSvg.asset(
                                                                  //                                           AssetUtils.upload,
                                                                  //                                           color: Theme.of(context).primaryColorDark,
                                                                  //                                         )),
                                                                  //                             );
                                                                  //                           },
                                                                  //                         );
                                                                  //                       },
                                                                  //                     );
                                                                  //                   },
                                                                  //                 );
                                                                  //               },
                                                                  //             ),
                                                                  //           ],
                                                                  //         ));
                                                                  //   },
                                                                  // ),
                                                                  Center(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(top: 40.0, bottom: 16),
                                                                        child: TextButton(
                                                                            onPressed: () {
                                                                              UploadDocumentLaterDialog.show(context, onSelected: () {
                                                                                Navigator.pop(context);
                                                                                model.isDocumentSkipped = true;
                                                                                model.isSecondNextPage = true;
                                                                                model.getCustomerStatus();
                                                                                //model.getAccount();
                                                                                //Navigator.pushReplacementNamed(context, RoutePaths.AccountReady);
                                                                                getSecondNextPage(userStatus!.data!, model, context);
                                                                              });
                                                                            },
                                                                            child: Text(
                                                                              S.of(context).uploadDocumentLater,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).accentTextTheme.bodyText1!.color),
                                                                            ))),
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        AppStreamBuilder<
                                                                            bool>(
                                                                      stream: model
                                                                          .showAnimatedButtonStream,
                                                                      initialData:
                                                                          false,
                                                                      dataBuilder:
                                                                          (context,
                                                                              isValid) {
                                                                        return Visibility(
                                                                          visible:
                                                                              isValid!,
                                                                          child:
                                                                              AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                                                        );
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ))),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    });
                              });
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void getNextPage(CustomerStatus customerStatus,
      UploadDocumentsPageViewModel model, BuildContext context) {
    model.isSecondNextPage = false;
    switch (customerStatus.nextPage) {
      case CustomerStatusEnum.HOLD:
        Navigator.pushReplacementNamed(context, RoutePaths.AccountHold,
            arguments: AccountHoldArguments(
                applicationId: customerStatus.applicationId));
        break;
      case CustomerStatusEnum.ACCOUNT_PAGE:
        model.getAccount();
        break;
      case CustomerStatusEnum.SUCCESS:
        Navigator.pushReplacementNamed(context, RoutePaths.AccountReady,
            arguments: AccountReadyArguments(
                isDocumentUploaded: model.isDocumentSkipped));
        break;
      case CustomerStatusEnum.DOC_UPLOAD:
        break;
      case CustomerStatusEnum.VIDEO_CALL:
        Future.delayed(Duration(milliseconds: 500), () {
          ProviderScope.containerOf(context)
              .read(registerStepFiveViewModelProvider)
              .registrationStepFivePageController
              .move(0, animation: false);
        });
        break;
      case CustomerStatusEnum.REMOVE_DEBIT_LOCK:
        model.removeDebitLock();
        break;
      case CustomerStatusEnum.CARD_ISSUANCE:
        Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
        break;
    }
  }

  void getSecondNextPage(CustomerStatus customerStatus,
      UploadDocumentsPageViewModel model, BuildContext context) {
    switch (customerStatus.secondNextPage) {
      case CustomerStatusEnum.HOLD:
        Navigator.pushReplacementNamed(context, RoutePaths.AccountHold,
            arguments: AccountHoldArguments(
                applicationId: customerStatus.applicationId));
        break;
      case CustomerStatusEnum.ACCOUNT_PAGE:
        model.getAccount();
        break;

      case CustomerStatusEnum.VIDEO_CALL:
        Future.delayed(Duration(milliseconds: 500), () {
          ProviderScope.containerOf(context)
              .read(registerStepFiveViewModelProvider)
              .registrationStepFivePageController
              .move(1, animation: false);
        });
        break;
    }
  }
}
