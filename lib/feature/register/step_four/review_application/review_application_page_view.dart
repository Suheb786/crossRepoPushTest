import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/review_application/review_item.dart';
import 'package:neo_bank/ui/molecules/review_application/review_term_cond_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReviewApplicationPageView
    extends BasePageViewWidget<ReviewApplicationPageViewModel> {
  ReviewApplicationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
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
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (details.primaryDelta!.isNegative) {
                            ProviderScope.containerOf(context)
                                .read(registerStepFourViewModelProvider)
                                .pageController
                                .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {
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
                                    colors: [
                                      AppColor.white,
                                      AppColor.white
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ReviewApplicationItem(title: S.of(context).emailAddress, details: "salam@email.com",),
                                    ReviewApplicationItem(title: S.of(context).mobileNumber, details: "+962 79 332 8080",),
                                    Padding(
                                      padding: EdgeInsets.only(top:16.0, bottom: 8.0),
                                      child: AppDivider(
                                        height: 1,
                                        color: AppColor.light_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(title: S.of(context).residentCountry, details: "Jordan",),
                                    ReviewApplicationItem(title: S.of(context).homeAddress, details: "Queen Rania Al-Abdullah",),
                                    ReviewApplicationItem(title: S.of(context).streetAddress, details: "Sweilah",),
                                    ReviewApplicationItem(title: S.of(context).buildingNameNo, details: "W Amman",),
                                    Padding(
                                      padding: EdgeInsets.only(top:16.0, bottom: 8.0),
                                      child: AppDivider(
                                        height: 1,
                                        color: AppColor.light_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(title: S.of(context).spouseName, details: "Ameena Rasheed",),
                                    ReviewApplicationItem(title: S.of(context).natureSpecialNeeds, details: "Movement",),
                                    ReviewApplicationItem(title: S.of(context).relationshipWithPEP, details: "Father",),
                                    ReviewApplicationItem(title: S.of(context).personsName, details: "Salah Mawajdeh",),
                                    ReviewApplicationItem(title: S.of(context).personsRole, details: "Minister of Health",),
                                    Padding(
                                      padding: EdgeInsets.only(top:16.0, bottom: 8.0),
                                      child: AppDivider(
                                        height: 1,
                                        color: AppColor.light_gray,
                                      ),
                                    ),
                                    ReviewApplicationItem(title: S.of(context).employmentStatus, details: "Employed",),
                                    ReviewApplicationItem(title: S.of(context).occupation, details: "Accountant",),

                                    ReviewApplicationItem(title: S.of(context).mainSourceIncome, details: "Salary",),
                                    ReviewApplicationItem(title: S.of(context).monthlyIncome, details: "JOD 4,950",),
                                    ReviewApplicationItem(title: S.of(context).annualIncome, details: "JOD 59,400",),
                                    ReviewApplicationItem(title: S.of(context).purposeOfAccount, details: "Salary",),
                                    ReviewApplicationItem(title: S.of(context).employerName, details: "Jordan Insurance Company",),
                                    ReviewApplicationItem(title: S.of(context).employerCountry, details: "Jordan",),
                                    ReviewApplicationItem(title: S.of(context).employerCity, details: "Amman",),
                                    ReviewApplicationItem(title: S.of(context).employerContact, details: "79 333 8089",),
                                    ReviewApplicationItem(title: S.of(context).additionalSourceIncome, details: "Freelance Designer",),
                                    ReviewApplicationItem(title: S.of(context).totalAdditionalIncome, details: "JOD 2,000",),

                                  ],
                                ),
                              )),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
