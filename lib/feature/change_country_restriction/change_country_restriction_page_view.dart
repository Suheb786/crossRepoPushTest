import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/change_country_restriction/change_country_restriction_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/block_country/block_country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ChangeCountryRestrictionPageView extends BasePageViewWidget<ChangeCountryRestrictionPageViewModel> {
  ChangeCountryRestrictionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).changeCountryRestriction.toUpperCase(),
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).changeCardRestrictionDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).changeCardRestrictionDesc,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 32),
                        child: AddIncomeWidget(
                          label: S.of(context).addCountryRestriction,
                          onTap: () {
                            CountryDialog.show(context, title: S.of(context).addCountryRestriction,
                                onDismissed: () {
                              Navigator.pop(context);
                            }, onSelected: (value) {
                              Navigator.pop(context);
                              BlockCountryDialog.show(context,
                                  countryData: value,
                                  title: S.of(context).blockThisCountry,
                                  onSelected: (value) {}, onDismissed: () {
                                Navigator.pop(context);
                              });
                            });
                          },
                        ),
                      ),
                      Text(
                        S.of(context).blockedCountries,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor, shape: BoxShape.circle),
                            child: AppSvg.asset(AssetUtils.countryRestriction),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              S.of(context).notSetUpCountryRestrictionYet,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          S.of(context).backToCardSettings,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.brightBlue,
                            letterSpacing: 1,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
