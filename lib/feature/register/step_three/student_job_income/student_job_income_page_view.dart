import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_three/student_job_income/student_job_income_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/ui/molecules/register/additional_income_source_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../../di/register/register_modules.dart';
import '../../../../ui/molecules/profile/profile_row_item.dart';

class StudentJobIncomePageView
    extends BasePageViewWidget<StudentJobIncomePageViewModel> {
  StudentJobIncomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Text(
          S.of(context).jobIncome,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).jobIncomeMsg,
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
                    stream: model.studentIncomeStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                      } else if (data.status == Status.ERROR) {}
                    },
                    dataBuilder: (context, data) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (details.primaryDelta!.isNegative) {
                            ProviderScope.containerOf(context)
                                .read(registerStepThreeViewModelProvider)
                                .registrationStepThreePageController
                                .jumpToPage(6);
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
                                child: Column(
                                  children: [
                                    ProfileRowItem(
                                      title: S
                                          .of(context)
                                          .additionalSourceIncomeQ1,
                                      activeText: S.of(context).yes,
                                      inactiveText: S.of(context).no,
                                      providerBase:
                                          studentIncomeViewModelProvider,
                                      onToggle: (isActive) {
                                        return Visibility(
                                          visible: isActive,
                                          child: AppStreamBuilder<String>(
                                            stream: model.uploadStudentStream,
                                            initialData: '',
                                            onData: (documentResponse) {
                                              if (documentResponse.isNotEmpty) {
                                                model
                                                    .updateStudentDocumentField(
                                                        documentResponse);
                                              }
                                            },
                                            dataBuilder: (context, document) {
                                              return AppStreamBuilder<bool>(
                                                stream:
                                                    model.documentStudentStream,
                                                initialData: false,
                                                dataBuilder:
                                                    (context, isUploaded) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16.0),
                                                    // child: AppTextField(
                                                    //   labelText: '',
                                                    //   hintText:
                                                    //       S.of(context).addIncome,
                                                    //   hintTextColor: AppColor.vivid_orange,
                                                    //   controller: model
                                                    //       .studentIncomeController,
                                                    //   key: model
                                                    //       .studentIncomeKey,
                                                    //   readOnly: true,
                                                    //   // hintTextColor: AppColor.vivid_orange,
                                                    //   suffixIcon:
                                                    //       (value, data) {
                                                    //     return InkWell(
                                                    //       onTap: (){
                                                    //         print("hello");
                                                    //       },
                                                    //       child: Image.asset(AssetUtils.add),
                                                    //     );
                                                    //   },
                                                    // ),
                                                    child: Visibility(
                                                      visible: isActive,
                                                      child: AppStreamBuilder<
                                                          List<
                                                              AdditionalIncomeSourceParams>>(
                                                        stream: model
                                                            .additionalSourceIncomeListStream,
                                                        initialData: [],
                                                        dataBuilder: (context,
                                                            dataList) {
                                                          if (dataList!
                                                              .isNotEmpty) {
                                                            return ListView
                                                                .builder(
                                                                    itemCount:
                                                                        dataList.length +
                                                                            1,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      if (index ==
                                                                          dataList
                                                                              .length) {
                                                                        return AddIncomeWidget(
                                                                          label: S
                                                                              .of(context)
                                                                              .addIncome,
                                                                          onTap:
                                                                              () {
                                                                            AdditionalIncomeSourceDialog.show(context, onDismissed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            }, onSelected:
                                                                                (value) {
                                                                              Navigator.pop(context);
                                                                              model.addAdditionalIncomeList(value);
                                                                            });
                                                                          },
                                                                        );
                                                                      }
                                                                      return AdditionalIncomeSourceWidget(
                                                                        additionalIncomeSourceParams:
                                                                            dataList[index],
                                                                        onTap:
                                                                            () {
                                                                          model.removeAdditionalItem(
                                                                              index);
                                                                        },
                                                                      );
                                                                    });
                                                          } else {
                                                            return AddIncomeWidget(
                                                              label: S
                                                                  .of(context)
                                                                  .addIncome,
                                                              onTap: () {
                                                                AdditionalIncomeSourceDialog.show(
                                                                    context,
                                                                    onDismissed:
                                                                        () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }, onSelected:
                                                                        (value) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  model.addAdditionalIncomeList(
                                                                      value);
                                                                });
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
