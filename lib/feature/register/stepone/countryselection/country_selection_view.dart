import 'package:domain/model/country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/country/country_list_item.dart';
import 'package:neo_bank/ui/molecules/register/notify_me_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class CountrySelectionPageView
    extends BasePageViewWidget<CountrySelectionViewModel> {
  CountrySelectionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Text(
          S.of(context).accountRegistration,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).selectCountryHeader,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.very_dark_gray,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta!.isNegative) {
                ProviderScope.containerOf(context)
                    .read(addNumberViewModelProvider)
                    .notify();
                ProviderScope.containerOf(context)
                    .read(registerStepOneViewModelProvider)
                    .pageController
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
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  decoration: BoxDecoration(
                      color: AppColor.very_soft_violet,
                      gradient: LinearGradient(
                          colors: [
                            AppColor.dark_violet,
                            AppColor.dark_moderate_blue
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: AppStreamBuilder<Resource<List<Country>>>(
                    stream: model.countries,
                    initialData: Resource.none(),
                    dataBuilder: (context, data) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              NotifyMeWidget(
                                onTap: () {
                                  // ProviderScope
                                  //     .containerOf(context)
                                  //     .read(registerStepOneViewModelProvider)
                                  //     .pageController
                                  //     .nextPage(
                                  //     duration: Duration(milliseconds: 500),
                                  //     curve: Curves.easeInOut);
                                },
                                title: S.of(context).accountOpeningDescription,
                                labelText: S.of(context).notifyMe,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              CountryListItem(
                                item: model.getSpecifiedCountry(),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 24,
                            left: 69,
                            right: 69,
                            child: AnimatedButton(
                              buttonText: S.of(context).swipeToProceed,
                            ),
                          )
                        ],
                      );
                    },
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
