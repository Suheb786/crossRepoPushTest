import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/evouchers/evouchers_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EVouchersFilterDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;

  EVouchersFilterDialogView({this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return eVouchersDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EVouchersFilterDialogViewModel>(
      providerBase: providerBase(),
      onModelReady: (model) {},
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 32.0, bottom: 40),
                      child: Center(
                        child: Text(
                          title!,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    AppTextField(
                      labelText: S.of(context).category.toUpperCase(),
                      hintText: S.of(context).pleaseSelect,
                      readOnly: true,
                      controller: model!.categoryController,
                      key: model.categoryKey,
                      onPressed: () {
                        RelationshipWithCardHolderDialog.show(context,
                            title: S.of(context).category,
                            relationSHipWithCardHolder: model.categoryList, onDismissed: () {
                          Navigator.pop(context);
                        }, onSelected: (value) {
                          Navigator.pop(context);
                          model.categoryController.text = value;
                          model.showResetFilterButton();
                        });
                      },
                      suffixIcon: (value, data) {
                        return Container(
                            height: 16,
                            width: 16,
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      labelText: S.of(context).preferredRegion.toUpperCase(),
                      hintText: S.of(context).pleaseSelect,
                      readOnly: true,
                      controller: model.preferredRegionController,
                      key: model.preferredRegionKey,
                      onPressed: () {
                        RelationshipWithCardHolderDialog.show(context,
                            title: S.of(context).preferredRegion,
                            relationSHipWithCardHolder: model.preferredRegionList, onDismissed: () {
                          Navigator.pop(context);
                        }, onSelected: (value) {
                          Navigator.pop(context);
                          model.preferredRegionController.text = value;
                          model.showResetFilterButton();
                        });
                      },
                      suffixIcon: (value, data) {
                        return Container(
                            height: 16,
                            width: 16,
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      labelText: S.of(context).minPrice.toUpperCase(),
                      hintText: S.of(context).pleaseSelect,
                      readOnly: true,
                      controller: model.minPriceController,
                      key: model.minPriceKey,
                      onPressed: () {
                        RelationshipWithCardHolderDialog.show(context,
                            title: S.of(context).minPrice,
                            relationSHipWithCardHolder: model.minMaxPriceList, onDismissed: () {
                          Navigator.pop(context);
                        }, onSelected: (value) {
                          Navigator.pop(context);
                          model.minPriceController.text = value;
                          model.showResetFilterButton();
                        });
                      },
                      suffixIcon: (value, data) {
                        return Container(
                            height: 16,
                            width: 16,
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      labelText: S.of(context).maxPrice.toUpperCase(),
                      hintText: S.of(context).pleaseSelect,
                      readOnly: true,
                      controller: model.maxPriceController,
                      key: model.maxPriceKey,
                      onPressed: () {
                        RelationshipWithCardHolderDialog.show(context,
                            title: S.of(context).maxPrice,
                            relationSHipWithCardHolder: model.minMaxPriceList, onDismissed: () {
                          Navigator.pop(context);
                        }, onSelected: (value) {
                          Navigator.pop(context);
                          model.maxPriceController.text = value;
                          model.showResetFilterButton();
                        });
                      },
                      suffixIcon: (value, data) {
                        return Container(
                            height: 16,
                            width: 16,
                            padding: EdgeInsetsDirectional.only(end: 8),
                            child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                      },
                    ),
                    AppStreamBuilder<bool>(
                        stream: model.showButtonStream,
                        initialData: false,
                        dataBuilder: (context, isVisible) {
                          return Visibility(
                            visible: isVisible!,
                            child: InkWell(
                              onTap: () => model.resetFilter(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(top: 32.0),
                                child: Text(
                                  S.of(context).resetFilter,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentTextTheme.bodyText1?.color),
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      color: AppColor.white.withOpacity(0),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 57,
                              width: 57,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                              child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 16),
                            child: Center(
                              child: Text(
                                S.of(context).swipeDownToCancel,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400, color: AppColor.dark_gray_1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
