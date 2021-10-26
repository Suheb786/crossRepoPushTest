import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/countryselection/country_selection_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
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
    return ShakeAnimatedWidget(
      enabled: false,
      duration: Duration(milliseconds: 100),
      shakeAngle: Rotation.deg(z: 1),
      curve: Curves.easeInOutSine,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta!.isNegative) {
            ProviderScope.containerOf(context)
                .read(addNumberViewModelProvider)
                .notify();
            ProviderScope.containerOf(context)
                .read(accountRegistrationViewModelProvider)
                .pageController
                .nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          margin: EdgeInsets.zero,
          shadowColor: AppColor.black.withOpacity(0.32),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                  color: AppColor.very_soft_violet,
                  gradient: LinearGradient(colors: [
                    AppColor.dark_violet,
                    AppColor.dark_moderate_blue
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
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
                              Navigator.pushReplacementNamed(
                                  context, RoutePaths.NonJordanianRegister);
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
                        right: 45,
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
    );
  }
}
