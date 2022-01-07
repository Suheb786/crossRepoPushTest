import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/ui/molecules/register/additional_income_source_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../../di/register/register_modules.dart';

class StudentJobIncomePageView
    extends BasePageViewWidget<StudentJobIncomePageViewModel> {
  StudentJobIncomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
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
                  child: AppStreamBuilder<Resource<SaveJobDetailsResponse>>(
                    stream: model.jobAndIncomeStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          ProviderScope.containerOf(context)
                              .read(registerViewModelProvider)
                              .registrationStepsController
                              .nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                        });
                      }
                    },
                    dataBuilder: (context, jonResponse) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            model.jobIncomeDetails();
                          }
                        },
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom -
                                                  50 <=
                                              0
                                          ? 0
                                          : MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom -
                                              48),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    AppStreamBuilder<
                                        List<AdditionalIncomeType>>(
                                      stream: model
                                          .additionalSourceIncomeListStream,
                                      initialData: [],
                                      dataBuilder: (context, dataList) {
                                        if (dataList!.isNotEmpty) {
                                          return ListView.builder(
                                              itemCount: dataList.length + 1,
                                              shrinkWrap: true,
                                              primary: false,
                                              physics: ClampingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                if (index == dataList.length) {
                                                  return AddIncomeWidget(
                                                    label:
                                                        S.of(context).addIncome,
                                                    onTap: () {
                                                      AdditionalIncomeSourceDialog
                                                          .show(context,
                                                              onDismissed: () {
                                                        Navigator.pop(context);
                                                      }, onSelected: (value) {
                                                        if (value.totalIncome!
                                                            .isEmpty) {
                                                          model.showToastWithError(AppError(
                                                              type: ErrorType
                                                                  .EMPTY_INCOME,
                                                              cause:
                                                                  Exception(),
                                                              error: ErrorInfo(
                                                                  message:
                                                                      '')));
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                          model
                                                              .addAdditionalIncomeList(
                                                                  value);
                                                        }
                                                      });
                                                    },
                                                  );
                                                }
                                                return AdditionalIncomeSourceWidget(
                                                  additionalIncomeSourceParams:
                                                      dataList[index],
                                                  onTap: () {
                                                    model.removeAdditionalItem(
                                                        index);
                                                  },
                                                );
                                              });
                                        } else {
                                          return AddIncomeWidget(
                                            label: S.of(context).addIncome,
                                            onTap: () {
                                              AdditionalIncomeSourceDialog.show(
                                                  context, onDismissed: () {
                                                Navigator.pop(context);
                                              }, onSelected: (value) {
                                                if (value
                                                    .totalIncome!.isEmpty) {
                                                  model.showToastWithError(
                                                      AppError(
                                                          type:
                                                              ErrorType
                                                                  .EMPTY_INCOME,
                                                          cause: Exception(),
                                                          error: ErrorInfo(
                                                              message: '')));
                                                } else {
                                                  Navigator.pop(context);
                                                  model.addAdditionalIncomeList(
                                                      value);
                                                }
                                              });
                                            },
                                          );
                                        }
                                      },
                                    ),
                                    AppStreamBuilder<bool>(
                                      stream: model.allFieldValidatorStream,
                                      initialData: false,
                                      dataBuilder: (context, data) {
                                        return Visibility(
                                          visible: data!,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed),
                                          ),
                                        );
                                      },
                                    )
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
