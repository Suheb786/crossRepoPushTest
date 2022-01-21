import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/change_my_number_dialog/change_my_number_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ChangeMyNumberDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(CountryData)? onSelected;
  bool _keyboardVisible = false;
  final List<CountryData> countryDataList;

  ChangeMyNumberDialogView(
      {this.onDismissed, this.onSelected, required this.countryDataList});

  ProviderBase providerBase() {
    return changeMyNumberDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<ChangeMyNumberDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 36,
                  top: _keyboardVisible ? 36 : 204),
              child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
                      onDismissed?.call();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppStreamBuilder<CountryData>(
                          initialData: CountryData(),
                          stream: model!.getSelectedCountryStream,
                          dataBuilder: (context, selectedCountry) {
                            return AppTextField(
                              labelText:
                                  S.of(context).mobileNumber.toUpperCase(),
                              hintText: S.of(context).mobileNumberHint,
                              inputType: TextInputType.number,
                              inputAction: TextInputAction.done,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    model.countryData.mobileMax),
                              ],
                              controller: model.mobileNumberController,
                              key: model.mobileNumberKey,
                              onChanged: (value) {},
                              prefixIcon: () {
                                return InkWell(
                                  onTap: () {
                                    MobileNumberDialog.show(context,
                                        title: S.of(context).mobileNumber,
                                        onSelected: (data) {
                                      Navigator.pop(context);
                                      model.countryData = data;
                                      model.setSelectedCountry(data);
                                    }, onDismissed: () {
                                      Navigator.pop(context);
                                    }, countryDataList: countryDataList);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "${AssetUtils.flags}${selectedCountry!.isoCode3?.toLowerCase() ?? ""}.png"),
                                                    fit: BoxFit.cover))),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            selectedCountry
                                                    .phoneCode!.isNotEmpty
                                                ? '+${selectedCountry.phoneCode!}'
                                                : "",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 16,
                                            width: 16,
                                            margin: EdgeInsets.only(right: 8),
                                            child: AppSvg.asset(
                                                AssetUtils.downArrow,
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1!
                                                    .color))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            onSelected?.call(model.countryData);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .bodyText1!
                                    .color!),
                            child: AppSvg.asset(AssetUtils.tick,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark_gray_1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
        },
        onModelReady: (model) {
          if (countryDataList.length > 0) {
            model.countryData = countryDataList.firstWhere(
                (element) => element.isoCode3 == 'JOR',
                orElse: () => countryDataList.first);
            model.setSelectedCountry(model.countryData);
          }
          print('countryDatalength-->${countryDataList.length}');
        },
        providerBase: providerBase());
  }
}
