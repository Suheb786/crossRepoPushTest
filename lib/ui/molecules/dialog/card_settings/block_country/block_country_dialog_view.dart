import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/block_country/block_country_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BlockCountryDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;
  final CountryData countryData;

  const BlockCountryDialogView({required this.countryData, this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return blockCountryDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BlockCountryDialogModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    onDismissed?.call();
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Center(
                        child: Text(
                          title!,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont, fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: AppColor.white_gray),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            child: AppSvg.asset(
                              "${AssetUtils.flags}${countryData.isoCode3?.toLowerCase() ?? ""}.svg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                countryData.countryName ?? "",
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        S.of(context).blockThisCountryDesc,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 32),
                        padding: EdgeInsets.all(16),
                        height: 57,
                        width: 57,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).textTheme.bodyLarge!.color!),
                        child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Center(
                        child: Text(
                          S.of(context).swipeDownToCancel,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.dark_gray_1),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
        providerBase: providerBase());
  }
}
