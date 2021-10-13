import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
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
        Text(
          S.of(context).reviewApplication,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).confirmYourInformation,
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
                    stream: model.reviewAppStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .registrationStepFourPageController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
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
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: 114),
                                physics: ClampingScrollPhysics(),
                                child: Column(
                                  children: [
                                    ReviewApplicationItem(
                                      title: S.of(context).emailAddressSmall,
                                      details: "salam@email.com",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).mobileNumber,
                                      details: "+962 79 332 8080",
                                    ),
                                    SizedBox(height: 16),
                                    Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                    SizedBox(height: 16),
                                    ReviewApplicationItem(
                                      title: S.of(context).residentCountry,
                                      details: "Jordan",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).homeAddress,
                                      details: "Queen Rania Al-Abdullah",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).streetAddress,
                                      details: "Sweilah",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).buildingNameNo,
                                      details: "W Amman",
                                    ),
                                    SizedBox(height: 16),
                                    Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                    SizedBox(height: 16),
                                    ReviewApplicationItem(
                                      title: S.of(context).spouseName,
                                      details: "Ameena Rasheed",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).natureSpecialNeeds,
                                      details: "Movement",
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
                                    SizedBox(height: 16),
                                    Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                    SizedBox(height: 8),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).employmentStatusSmall,
                                      details: "Employed",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).occupationSmall,
                                      details: "Accountant",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).mainSourceIncome,
                                      details: "Salary",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).monthlyIncomeSmall,
                                      details: "JOD 4,950",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).annualIncomeSmall,
                                      details: "JOD 59,400",
                                    ),
                                    ReviewApplicationItem(
                                      title: S.of(context).purposeOfAccount,
                                      details: "Salary",
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
                                      details: "79 333 8089",
                                    ),
                                    ReviewApplicationItem(
                                      title:
                                          S.of(context).additionalSourceIncome,
                                      details: "Freelance Designer",
                                    ),
                                    ReviewApplicationItem(
                                      title: S
                                          .of(context)
                                          .totalAdditionalIncomeSmall,
                                      details: "JOD 2,000",
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
                                    Visibility(
                                      visible: isError!,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            S.of(context).confirmTermsCondError,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.vivid_red),
                                          ),
                                        ),
                                      ),
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
