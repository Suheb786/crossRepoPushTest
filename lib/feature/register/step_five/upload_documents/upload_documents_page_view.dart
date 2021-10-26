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
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/molecules/upload_document/upload_document_bottom_sheet.dart';
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
                                                  color: AppColor.white),
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
                                                    color: AppColor.white),
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
                                                      hintText:
                                                          S.of(context).upload,
                                                      controller: model
                                                          .incomeController,
                                                      key: model
                                                          .incomeDocumentKey,
                                                      readOnly: true,
                                                      suffixIcon:
                                                          (value, data) {
                                                        return InkWell(
                                                          onTap: !(isUploaded!)
                                                              ? () async {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (builder) =>
                                                                              UploadDocumentBottomSheetWidget(
                                                                                title: S.of(context).selectAnyOption,
                                                                                firstOptionText: S.of(context).storage,
                                                                                secondOptionText: S.of(context).camera,
                                                                                buttonText: S.of(context).cancel,
                                                                                onCameraTap: () {
                                                                                  Navigator.pop(context);
                                                                                  model.uploadIncomeDocument(DocumentTypeEnum.CAMERA);
                                                                                },
                                                                                onPhotoLibraryTap: () {
                                                                                  Navigator.pop(context);
                                                                                  model.uploadIncomeDocument(DocumentTypeEnum.GALLERY);
                                                                                },
                                                                                onCancelTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ));
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
                                                  color: AppColor.white),
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
                                                    color: AppColor.white),
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
                                                      hintText:
                                                          S.of(context).upload,
                                                      controller: model
                                                          .addressController,
                                                      key: model
                                                          .addressDocumentKey,
                                                      readOnly: true,
                                                      suffixIcon:
                                                          (value, data) {
                                                        return InkWell(
                                                          onTap: !(isUploaded!)
                                                              ? () async {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (builder) =>
                                                                              UploadDocumentBottomSheetWidget(
                                                                                title: S.of(context).selectAnyOption,
                                                                                firstOptionText: S.of(context).storage,
                                                                                secondOptionText: S.of(context).camera,
                                                                                buttonText: S.of(context).cancel,
                                                                                onCameraTap: () {
                                                                                  Navigator.pop(context);
                                                                                  model.uploadAddressDocument(DocumentTypeEnum.CAMERA);
                                                                                },
                                                                                onPhotoLibraryTap: () {
                                                                                  Navigator.pop(context);
                                                                                  model.uploadAddressDocument(DocumentTypeEnum.GALLERY);
                                                                                },
                                                                                onCancelTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ));
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
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 24.0, bottom: 16),
                                              child: Container(
                                                height: 1,
                                                color: AppColor.strong_violet,
                                              ),
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
