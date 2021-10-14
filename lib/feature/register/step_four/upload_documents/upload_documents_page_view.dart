import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/upload_documents/upload_documents_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/review_application/review_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/upload_document/upload_document_bottom_sheet.dart';
import 'package:neo_bank/ui/molecules/upload_document/upload_document_item.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:domain/constants/enum/document_type_enum.dart';

class UploadDocumentsPageView
    extends BasePageViewWidget<UploadDocumentsPageViewModel> {
  UploadDocumentsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).uploadDocuments,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 32),
            child: Text(
              S.of(context).completeTaxReportInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
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
                      onData: (data) {},
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (details.primaryDelta!.isNegative) {

                            }else{
                              ProviderScope.containerOf(context)
                                  .read(registerStepFourViewModelProvider)
                                  .pageController
                                  .previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
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
                                    padding: EdgeInsets.only(bottom: 114),
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppStreamBuilder<String>(
                                            stream:
                                                model.uploadIncomePoofStream,
                                            initialData: "",
                                            onData: (data) {
                                              model.updateIncomeFileName(
                                                  data.split("/").last);
                                            },
                                            dataBuilder: (context, data) {
                                              return UploadDocumentItem(
                                                title:
                                                    S.of(context).proofOfIncome,
                                                desc: S
                                                    .of(context)
                                                    .proofOfIncomeDesc,
                                                uploadText:
                                                    model.incomeFileStr ??
                                                        S.of(context).upload,
                                                isUploaded:
                                                    model.incomeFileUploaded,
                                                onTap: () {
                                                  if (model.incomeFileStr !=
                                                      S.of(context).upload) {
                                                    model.updateIncomeFileName(
                                                        S.of(context).upload);
                                                  } else {
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
                                                              onCameraTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                model.pickIncomePoofDocument(
                                                                    DocumentTypeEnum
                                                                        .CAMERA);
                                                              },
                                                              onPhotoLibraryTap:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                                model.pickIncomePoofDocument(
                                                                    DocumentTypeEnum
                                                                        .GALLERY);
                                                              },
                                                              onCancelTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ));
                                                  }
                                                },
                                              );
                                            }),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 16.0, bottom: 16),
                                          child: Container(
                                            height: 1,
                                            color: AppColor.strong_violet,
                                          ),
                                        ),
                                        AppStreamBuilder<String>(
                                            stream:
                                                model.uploadAddressPoofStream,
                                            initialData: "",
                                            onData: (data) {
                                              model.updateAddressFileName(
                                                  data.split("/").last);
                                            },
                                            dataBuilder: (context, data) {
                                              return UploadDocumentItem(
                                                title: S
                                                    .of(context)
                                                    .proofOfAddress,
                                                desc: S
                                                    .of(context)
                                                    .proofOfAddressDesc,
                                                uploadText:
                                                    (model.addressFileStr) ??
                                                        S.of(context).upload,
                                                isUploaded:
                                                    model.addressFileUploaded,
                                                onTap: () {
                                                  if (model.addressFileStr !=
                                                      S.of(context).upload) {
                                                    model.updateAddressFileName(
                                                        S.of(context).upload);
                                                  } else {
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
                                                              onCameraTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                model.pickAddressPoofDocument(
                                                                    DocumentTypeEnum
                                                                        .CAMERA);
                                                              },
                                                              onPhotoLibraryTap:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                                model.pickAddressPoofDocument(
                                                                    DocumentTypeEnum
                                                                        .GALLERY);
                                                              },
                                                              onCancelTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ));
                                                  }
                                                },
                                              );
                                            })
                                      ],
                                    ))),
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
