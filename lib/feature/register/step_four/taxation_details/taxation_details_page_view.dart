import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/fatca_enum.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/pep_dialog/pep_dialog.dart';
import 'package:neo_bank/ui/molecules/register/taxation_switch_widget/taxation_switch_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class TaxationDetailsPageView
    extends BasePageViewWidget<TaxationDetailsPageViewModel> {
  TaxationDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Scaffold(
        primary: true,
        extendBody: true,
        body: AppKeyBoardHide(
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
                    child: AppStreamBuilder<Resource<SetFatcResponse>>(
                      stream: model.setFatcaQuestionsStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          ///storing response to main page
                          model.updateData(context);
                          switch (data
                              .data!.setFatcaResponseContent!.requestResponse) {
                            case FatcaEnum.w8:
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .nextPage();
                                // .next();
                              });
                              break;

                            case FatcaEnum.w9:
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .moveToPage(4);
                                // .move(4, animation: false);
                              });
                              break;
                            case FatcaEnum.CONFIRMATION_SCREEN:
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerViewModelProvider)
                                    .registrationStepsController
                                    .nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                              });
                              break;
                          }
                        } else if (data.status == Status.ERROR) {
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, response) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .appSwiperController
                                    .page ==
                                0.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.setFatcaQuestionResponse();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.setFatcaQuestionResponse();
                                }
                              }
                            }
                          },
                          child: AppStreamBuilder<
                              Resource<GetFatcaQuestionsResponse>>(
                            stream: model.getFatcaQuestionsStream,
                            initialData: Resource.none(),
                            onData: (data) {
                              if (data.status == Status.SUCCESS) {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .isGetFatca = true;
                                // model.isFatcaGet = true;
                              }
                            },
                            dataBuilder: (context, questions) {
                              switch (questions!.status) {
                                case Status.SUCCESS:
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom -
                                                    50 <=
                                                0
                                            ? 0
                                            : MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom -
                                                48),
                                    child: SingleChildScrollView(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
                                      physics: ClampingScrollPhysics(),
                                      primary: true,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ListView.builder(
                                              key: ValueKey(1),
                                              physics: ClampingScrollPhysics(),
                                              itemCount: questions
                                                  .data!
                                                  .getFatcaQuestionsResponseContent!
                                                  .fatcaQuestionsList!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return TaxationSwitchWidget(
                                                  key: ValueKey(questions
                                                      .data!
                                                      .getFatcaQuestionsResponseContent!
                                                      .fatcaQuestionsList![
                                                          index]
                                                      .orderNo),
                                                  data: questions
                                                      .data!
                                                      .getFatcaQuestionsResponseContent!
                                                      .fatcaQuestionsList![index],
                                                  onToggle: (value) {
                                                    model.toggleSelection(
                                                        value, index);
                                                  },
                                                  onDropDownSelection: (selection,
                                                      selectedAdditionalData) {
                                                    model.setDropDownSelection(
                                                        selectedAdditionalData,
                                                        selection);
                                                  },
                                                  onTextUpdate: (selection,
                                                      changedValue) {
                                                    model.setOtherData(
                                                        selection,
                                                        changedValue);
                                                  },
                                                  onInfoClick: () {
                                                    PEPDialog.show(context,
                                                        onSelected: () {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                );
                                              },
                                              shrinkWrap: true,
                                              primary: false),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 32),
                                              child: AnimatedButton(
                                                  buttonText: S
                                                      .of(context)
                                                      .swipeToProceed),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                case Status.LOADING:
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                      strokeWidth: 2,
                                    ),
                                  );
                                default:
                                  return Center(
                                    child: Text('Something went wrong'),
                                  );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
