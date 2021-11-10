import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
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
import 'package:neo_bank/utils/color_utils.dart';
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
                                .read(registerViewModelProvider)
                                .registrationStepsController
                                .nextPage(
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
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        AppStreamBuilder<
                                            List<AdditionalIncomeSourceParams>>(
                                          stream: model
                                              .additionalSourceIncomeListStream,
                                          initialData: [],
                                          dataBuilder: (context, dataList) {
                                            if (dataList!.isNotEmpty) {
                                              return ListView.builder(
                                                  itemCount:
                                                      dataList.length + 1,
                                                  shrinkWrap: true,
                                                  physics: ClampingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index ==
                                                        dataList.length) {
                                                      return AddIncomeWidget(
                                                        label: S
                                                            .of(context)
                                                            .addIncome,
                                                        onTap: () {
                                                          AdditionalIncomeSourceDialog
                                                              .show(context,
                                                                  onDismissed:
                                                                      () {
                                                            Navigator.pop(
                                                                context);
                                                          }, onSelected:
                                                                      (value) {
                                                            Navigator.pop(
                                                                context);
                                                            model
                                                                .addAdditionalIncomeList(
                                                                    value);
                                                          });
                                                        },
                                                      );
                                                    }
                                                    return AdditionalIncomeSourceWidget(
                                                      additionalIncomeSourceParams:
                                                          dataList[index],
                                                      onTap: () {
                                                        model
                                                            .removeAdditionalItem(
                                                                index);
                                                      },
                                                    );
                                                  });
                                            } else {
                                              return AddIncomeWidget(
                                                label: S.of(context).addIncome,
                                                onTap: () {
                                                  AdditionalIncomeSourceDialog
                                                      .show(context,
                                                          onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model
                                                        .addAdditionalIncomeList(
                                                            value);
                                                  });
                                                },
                                              );
                                            }
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
                                  Positioned(
                                    bottom: 0,
                                    right: 45,
                                    child: AnimatedButton(
                                        buttonText:
                                            S.of(context).swipeToProceed),
                                  )
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
    );
  }
}
