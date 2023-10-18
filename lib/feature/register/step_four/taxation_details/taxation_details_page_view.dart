import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/fatca_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/pep_dialog/pep_dialog.dart';
import 'package:neo_bank/ui/molecules/register/taxation_switch_widget/taxation_switch_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

class TaxationDetailsPageView extends BasePageViewWidget<TaxationDetailsPageViewModel> {
  TaxationDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
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
                          switch (data.data!.setFatcaResponseContent!.requestResponse) {
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
                                    .nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                              });
                              break;
                          }
                        } else if (data.status == Status.ERROR) {
                          if (data.appError?.type == ErrorType.FATCA_ELIGIBLE) {
                            Navigator.pushReplacementNamed(context, RoutePaths.CreditCardApplicationFailure,
                                arguments: CreditCardApplicationFailureArguments(
                                    creditFailureState: CreditFailureState.FATCA));
                          }
                        }
                      },
                      dataBuilder: (context, response) {
                        return AppStreamBuilder<Resource<GetFatcaQuestionsResponse>>(
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
                                      bottom: 20
                                          .h /*MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                          ? 0
                                          : MediaQuery.of(context).viewInsets.bottom - 48*/
                                      ),
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                                    physics: ClampingScrollPhysics(),
                                    primary: true,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        ListView.builder(
                                            key: ValueKey(1),
                                            physics: ClampingScrollPhysics(),
                                            itemCount: questions.data!.getFatcaQuestionsResponseContent!
                                                .fatcaQuestionsList!.length,
                                            itemBuilder: (context, index) {
                                              return TaxationSwitchWidget(
                                                key: ValueKey(questions
                                                    .data!
                                                    .getFatcaQuestionsResponseContent!
                                                    .fatcaQuestionsList![index]
                                                    .orderNo),
                                                data: questions.data!.getFatcaQuestionsResponseContent!
                                                    .fatcaQuestionsList![index],
                                                onToggle: (value) {
                                                  model.toggleSelection(value, index);
                                                  if (!value) {
                                                    model.resetValue(index);
                                                  }
                                                },
                                                onDropDownSelection: (selection, selectedAdditionalData) {
                                                  model.setDropDownSelection(
                                                      selectedAdditionalData, selection);
                                                },
                                                onTextUpdate: (selection, changedValue) {
                                                  model.setOtherData(selection, changedValue);
                                                },
                                                onInfoClick: () {
                                                  PEPDialog.show(context, onSelected: () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              );
                                            },
                                            shrinkWrap: true,
                                            primary: false),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 32.h),
                                            child: AppPrimaryButton(
                                              text: S.of(context).next,
                                              onPressed: () {
                                                if (ProviderScope.containerOf(context)
                                                        .read(registerStepFourViewModelProvider)
                                                        .appSwiperController
                                                        .page ==
                                                    0.0) {
                                                  model.setFatcaQuestionResponse();
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              case Status.LOADING:
                                return Container();
                              default:
                                return Center(
                                  child: Text(S.of(context).somethingWentWrong),
                                );
                            }
                          },
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
