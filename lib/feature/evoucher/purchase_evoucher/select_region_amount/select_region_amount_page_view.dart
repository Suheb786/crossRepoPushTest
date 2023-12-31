import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_by_denomination_amount/purchase_by_denomination_amount_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/region_filter/region_filter_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectRegionAmountPageView extends BasePageViewWidget<SelectRegionAmountPageViewModel> {
  SelectRegionAmountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return AppStreamBuilder<Resource<bool>>(
              stream: model.selectRegionAmountStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  model.getFilteredVoucherList();
                  Navigator.pushNamed(context, RoutePaths.PurchaseByDenominationAmountPage,
                      arguments: PurchaseByDenominationAmountPageArgument(
                          voucherItems: model.filteredVouchers, category: model.argument?.category ?? ''));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, data) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 96.h,
                      ),
                      Text(
                        S.of(context).eVouchers.toUpperCase(),
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 10.t,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        S.of(context).selectPreferredRegionAmount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20.t,
                            fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsetsDirectional.only(top: 32.h, bottom: 56.h, start: 24.w, end: 24.w),
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              height: 72.h,
                                              width: 72.w,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    model.argument?.voucherItems.first.cardFaceImage ?? "",
                                                placeholder: (context, url) =>
                                                    Container(color: Theme.of(context).primaryColor),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            model.argument?.voucherItems.first.brand ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: Theme.of(context).indicatorColor,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 32.h,
                                          ),
                                          AppTextField(
                                            labelText: S.of(context).region.toUpperCase(),
                                            hintText: S.of(context).pleaseSelect,
                                            readOnly: true,
                                            controller: model.selectedRegionController,
                                            key: model.selectedRegionKey,
                                            onPressed: () {
                                              RegionFilterDialog.show(context,
                                                  title: S.of(context).preferredRegion,
                                                  isFromPurchaseFlow: true,
                                                  regionByCategoriesList: model.voucherCountries,
                                                  onDismissed: () {
                                                Navigator.pop(context);
                                              }, onSelected: (value) {
                                                Navigator.pop(context);
                                                model.selectedRegion = value;
                                                model.selectedRegionController.text = value.countryName ?? '';
                                                model.amountController.clear();
                                                model.getVoucherValue();
                                                model.validate();
                                              });
                                            },
                                            suffixIcon: (value, data) {
                                              return Container(
                                                  height: 16.h,
                                                  width: 16.h,
                                                  padding: EdgeInsetsDirectional.only(end: 8),
                                                  child: AppSvg.asset(AssetUtils.downArrow,
                                                      color: Theme.of(context).colorScheme.surfaceTint));
                                            },
                                          ),
                                          SizedBox(height: 16.h),
                                          AppTextField(
                                            labelText: S.of(context).value.toUpperCase(),
                                            hintText: S.of(context).pleaseSelect,
                                            readOnly: true,
                                            controller: model.amountController,
                                            key: model.amountKey,
                                            onPressed: () {
                                              if (model.selectedRegionController.text != "") {
                                                RelationshipWithCardHolderDialog.show(context,
                                                    title: S.of(context).value.toTitleCase(),
                                                    relationSHipWithCardHolder: model.voucherValue,
                                                    onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.amountController.text = value;
                                                  model.validate();
                                                });
                                              } else if (model.selectedRegionController.text == "") {
                                                model.selectedRegionKey.currentState!.isValid = false;
                                                model.showToastWithError(AppError(
                                                    error: ErrorInfo(message: ''),
                                                    type: ErrorType.SELECT_REGION_FIRST,
                                                    cause: Exception()));
                                              }
                                            },
                                            suffixIcon: (value, data) {
                                              return Container(
                                                  height: 16.h,
                                                  width: 16.h,
                                                  padding: EdgeInsetsDirectional.only(end: 8),
                                                  child: AppSvg.asset(AssetUtils.downArrow,
                                                      color: Theme.of(context).colorScheme.surfaceTint));
                                            },
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(top: 12.0.h, bottom: 16.h),
                                        child: AppStreamBuilder<bool>(
                                            stream: model.showButtonStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return AppPrimaryButton(
                                                text: S.of(context).next,
                                                isDisabled: !isValid!,
                                                onPressed: () {
                                                  model.validateFields();
                                                },
                                              );
                                            }),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          S.of(context).back,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
