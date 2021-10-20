import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/review_application/review_edit_info_item.dart';
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
                  child: AppStreamBuilder<Resource<List<String>>>(
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
                          } else {
                            // ProviderScope.containerOf(context)
                            //     .read(registerViewModelProvider)
                            //     .registrationStepsController
                            //     .previousPage(
                            //     duration: Duration(milliseconds: 500),
                            //     curve: Curves.easeInOut);
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
                              //padding: EdgeInsets.only(bottom: 20),
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: [
                                  ///personal details
                                  ReviewApplicationItem(
                                    title: S.of(context).emailAddressSmall,
                                    details: "salam@email.com",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).mobileNumber,
                                    details: "+962 79 332 8080",
                                  ),
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                  ),

                                  ///
                                  ReviewApplicationItem(
                                    title: S.of(context).nameAsPerID,
                                    details: "Abdul Salam Mahmood",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).idNumber,
                                    details: "923338221222",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).dateOfBirth,
                                    details: "12 July 1992",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).nationalitySmall,
                                    details: "Jordan",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).expiryDateSmall,
                                    details: "12 July 2022",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).genderSmall,
                                    details: "Male",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).mothersName,
                                    details: "Amal",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).mothersBirthplace,
                                    details: "Amman",
                                  ),
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                  ),

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
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                  ),

                                  ///
                                  ReviewApplicationItem(
                                    title: S.of(context).spouseName,
                                    details: "Ameena Rasheed",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).natureSpecialNeeds,
                                    details: "Movement",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).employmentStatusSmall,
                                    details: "Full-Time Employee",
                                  ),
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                  ),

                                  ///
                                  ReviewApplicationItem(
                                    title: S.of(context).occupationSmall,
                                    details: "Senior Executive",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).mainSourceIncome,
                                    details: "Salary",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).mainAnnualIncome,
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
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
                                    ),
                                  ),

                                  ///
                                  ReviewApplicationItem(
                                    title: S.of(context).purposeOfAccount,
                                    details: "Salary",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).typeOfTransactions,
                                    details: "Transfers",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).expMonthlyTransactions,
                                    details: "JOD 12,000",
                                  ),
                                  ReviewApplicationItem(
                                    title: S.of(context).expAnnualTransactions,
                                    details: "JOD 102,000",
                                  ),
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
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
                                    title: S.of(context).areYouAnyFirstDegreeQ,
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
                                  ReviewEditInfoItem(
                                    title: S.of(context).editInformation,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                      height: 1,
                                      color: AppColor.light_gray,
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
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 45, right: 45, top: 24),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.declarationSelectedStream,
                                        initialData: false,
                                        dataBuilder: (context, isChecked) {
                                          return Visibility(
                                            visible: isChecked!,
                                            child: AnimatedButton(
                                              buttonText: "Swipe to proceed",
                                              textColor: AppColor.light_violet,
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
