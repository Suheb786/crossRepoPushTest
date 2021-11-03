import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/start_over_widget.dart';
import 'package:neo_bank/ui/molecules/review_application/review_item.dart';
import 'package:neo_bank/ui/molecules/review_application/review_term_cond_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ReviewApplicationPageView
    extends BasePageViewWidget<ReviewApplicationPageViewModel> {
  ReviewApplicationPageView(ProviderBase model) : super(model);

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
                  child: AppStreamBuilder<Resource<List<String>>>(
                    stream: model.reviewAppStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(registerStepFiveViewModelProvider)
                            .registrationStepFivePageController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, response) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (details.primaryDelta!.isNegative) {
                            model.validateReviewDetails();
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
                              color: AppColor.white,
                              gradient: LinearGradient(
                                  colors: [AppColor.white, AppColor.white],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child:
                                FadingEdgeScrollView.fromSingleChildScrollView(
                              gradientFractionOnEnd: 0.3,
                              gradientFractionOnStart: 0.3,
                              child: SingleChildScrollView(
                                controller: model.scrollController,
                                physics: ClampingScrollPhysics(),
                                child: Column(
                                  children: [
                                    StartOverWidget(
                                      onTap: () {},
                                      title: S.of(context).startOverDesc,
                                      labelText: S.of(context).startOver,
                                    ),
                                    SizedBox(height: 32),

                                    ///address details
                                    ReviewApplicationItem(
                                      title: S.of(context).residentCountrySmall,
                                      details: "Jordan",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).homeAddressSmall,
                                      details: "Queen Rania Al-Abdullah",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).streetAddressSmall,
                                      details: "Sweilah",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).buildingNameNo,
                                      details: "W Amman",
                                    ),

                                    ///permanent address
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24.0),
                                      child: Container(
                                        height: 1,
                                        color: AppColor.white_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).permanentHomeAddress,
                                      details: "Queen Rania Al-Abdullah",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).streetAddressSmall,
                                      details: "Sweilah",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).buildingNameNo,
                                      details: "Walafahah Amman",
                                    ),

                                    /// personal details
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24.0),
                                      child: Container(
                                        height: 1,
                                        color: AppColor.white_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).spouseName,
                                      details: "Ameena Rasheed",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).natureSpecialNeeds,
                                      details: "Movement",
                                    ),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).employmentStatusSmall,
                                      details: "Full-Time Employee",
                                    ),

                                    ///occupation
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24.0),
                                      child: Container(
                                        height: 1,
                                        color: AppColor.white_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).occupationSmall,
                                      details: "Senior Executive",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).mainSourceIncome,
                                      details: "Salary",
                                    ),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).mainAnnualIncomeSmall,
                                      details: "JOD 60,000",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).employerNameSmall,
                                      details: "Jordan Insurance Company",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).employerCountrySmall,
                                      details: "Jordan",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).employerCitySmall,
                                      details: "Amman",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).employerContactSmall,
                                      details: "+962 79 333 8080",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).addIncome1,
                                      details: "Rent Income JOD 25,000",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).addIncome2,
                                      details: "Investments JOD 75,000",
                                    ),

                                    ///purpose of account opening
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24.0),
                                      child: Container(
                                        height: 1,
                                        color: AppColor.white_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).purposeOfAccount,
                                      details: "Salary",
                                    ),
                                    ReviewApplicationItem(
                                      title: S
                                          .of(context)
                                          .typeOfTransactionsSmall('1'),
                                      details: "Transfers",
                                    ),
                                    ReviewApplicationItem(
                                      title: S
                                          .of(context)
                                          .typeOfTransactionsSmall('2'),
                                      details: "Cash Deposit",
                                    ),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).expMonthlyTransactions,
                                      details: "JOD 12,000",
                                    ),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).expAnnualTransactions,
                                      details: "JOD 102,000",
                                    ),

                                    ///Tax and PEP questions
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24.0),
                                      child: Container(
                                        height: 1,
                                        color: AppColor.white_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).areYouUSCitizen,
                                      details: "No",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).areYouUSTaxResident,
                                      details: "No",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).wereBornInUS,
                                      details: "No",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).areYouTaxResidentQ,
                                      details: "No",
                                    ),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).areYouAnyFirstDegreeQ,
                                      details: "Yes",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).relationshipWithPEP,
                                      details: "Father",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).personsName,
                                      details: "Salah Mawajdeh",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).personsRole,
                                      details: "Minister of Health",
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24.0),
                                      child: Container(
                                        height: 1,
                                        color: AppColor.white_gray,
                                      ),
                                    ),
                                    AppStreamBuilder<bool>(
                                      stream: model.declarationSelectedStream,
                                      initialData: false,
                                      dataBuilder: (context, isSelected) {
                                        return ReviewTCWidget(
                                          isSelected: isSelected,
                                          title: S.of(context).confirmInfoTC,
                                          subTitle:
                                              S.of(context).termsAndCondition,
                                          onTap: () {
                                            model.updateDeclarationSelection(
                                                !(isSelected!));
                                          },
                                        );
                                      },
                                    ),

                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 45, top: 24),
                                      child: AppStreamBuilder<bool>(
                                          stream:
                                              model.declarationSelectedStream,
                                          initialData: false,
                                          dataBuilder: (context, isChecked) {
                                            return Visibility(
                                              visible: isChecked!,
                                              child: AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed,
                                                textColor:
                                                    AppColor.light_violet,
                                                borderColor:
                                                    AppColor.light_violet,
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
