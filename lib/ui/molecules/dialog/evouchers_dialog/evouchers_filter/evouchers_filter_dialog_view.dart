import 'package:domain/constants/enum/evoucher_filter_option_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_min_max_value.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/region_filter/region_filter_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../utils/status.dart';
import 'categories_filter/categories_filter_dialog.dart';

class EVouchersFilterDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(FilterSelectedData)? onSelected;
  final String? title;
  final List<VoucherCategories>? categoriesList;

  EVouchersFilterDialogView({
    this.onDismissed,
    this.onSelected,
    this.title,
    this.categoriesList,
  });

  ProviderBase providerBase() {
    return eVouchersDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EVouchersFilterDialogViewModel>(
      providerBase: providerBase(),
      onModelReady: (model) {
        model.loadingStream.listen((value) {
          if (value) {
            AppProgress(context);
          } else {
            Navigator.pop(context);
          }
        });

        model.error.listen((event) {
          _showTopError(
              ErrorParser.getLocalisedStringError(
                error: event,
                localisedHelper: S.of(context),
              ),
              context);
        });
      },
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0.w)),
            insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  onDismissed?.call();
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 32.0.h, bottom: 40.h),
                    child: Center(
                      child: Text(
                        title ?? '',
                        style: TextStyle(
                            fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              labelText: S.of(context).category.toUpperCase(),
                              hintText: S.of(context).pleaseSelect,
                              readOnly: true,
                              controller: model!.categoryController,
                              key: model.categoryKey,
                              onPressed: () {
                                CategoriesFilterDialog.show(context,
                                    title: S.of(context).category,
                                    categoriesList: categoriesList ?? [], onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.categoryController.text = value.categoryName;
                                  model.categryId = value.id == 0 ? "" : value.id.toString();
                                  model.getRegionByCategories(model.categryId);

                                  model.showResetFilterButton();
                                });
                              },
                              suffixIcon: (value, data) {
                                return Container(
                                    height: 16.h,
                                    width: 16.w,
                                    padding: EdgeInsetsDirectional.only(end: 8.w),
                                    child: AppSvg.asset(AssetUtils.downArrow,
                                        color: Theme.of(context).colorScheme.surfaceTint));
                              },
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            AppStreamBuilder<Resource<List<VoucherRegionByCategories>>>(
                                initialData: Resource.none(),
                                stream: model.voucherRegionByCategoriesResponseStream,
                                onData: (regionByCategoriesValue) {},
                                dataBuilder: (context, regionByCategories) {
                                  return AppTextField(
                                    labelText: S.of(context).preferredRegion.toUpperCase(),
                                    hintText: S.of(context).pleaseSelect,
                                    readOnly: true,
                                    controller: model.preferredRegionController,
                                    key: model.preferredRegionKey,
                                    onPressed: () {
                                      if (model.categoryController.text.isEmpty) {
                                        model.categoryKey.currentState!.isValid = false;
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.SELECT_CATEGORY_FIRST));
                                      } else if (regionByCategories?.status == Status.SUCCESS) {
                                        if ((regionByCategories?.data ?? []).isNotEmpty) {
                                          RegionFilterDialog.show(context,
                                              title: S.of(context).preferredRegion,
                                              regionByCategoriesList: regionByCategories?.data ?? [],
                                              onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.preferredRegionController.text = value.countryName ?? '';
                                            model.region = value.isoCode ?? "";
                                            model.getMinMaxValue(model.categryId, model.region);
                                            model.showResetFilterButton();
                                          });
                                        }
                                      }
                                    },
                                    suffixIcon: (value, data) {
                                      return Container(
                                          height: 16.h,
                                          width: 16.w,
                                          padding: EdgeInsetsDirectional.only(end: 8.w),
                                          child: AppSvg.asset(AssetUtils.downArrow,
                                              color: Theme.of(context).colorScheme.surfaceTint));
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 16,
                            ),
                            AppStreamBuilder<Resource<VoucherMinMaxValue>>(
                                initialData: Resource.none(),
                                stream: model.voucherMinMaxResponseStream,
                                dataBuilder: (context, voucherMinMaxResponse) {
                                  return AppTextField(
                                    labelText: S.of(context).minPrice.toUpperCase(),
                                    hintText: S.of(context).pleaseSelect,
                                    readOnly: true,
                                    controller: model.minPriceController,
                                    key: model.minPriceKey,
                                    onPressed: () {
                                      if (model.categoryController.text.isEmpty) {
                                        model.categoryKey.currentState!.isValid = false;
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.SELECT_CATEGORY_FIRST));
                                      } else if (model.preferredRegionController.text.isEmpty) {
                                        model.preferredRegionKey.currentState!.isValid = false;
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.SELECT_REGION_FIRST));
                                      } else if (voucherMinMaxResponse?.status == Status.SUCCESS) {
                                        RelationshipWithCardHolderDialog.show(context,
                                            title: S.of(context).minPrice,
                                            relationSHipWithCardHolder: model.rangeList, onDismissed: () {
                                          Navigator.pop(context);
                                        }, onSelected: (value) {
                                          Navigator.pop(context);
                                          model.minPriceController.text = value;
                                          model.showResetFilterButton();
                                        });
                                      }
                                    },
                                    suffixIcon: (value, data) {
                                      return Container(
                                          height: 16.h,
                                          width: 16.w,
                                          padding: EdgeInsetsDirectional.only(end: 8.w),
                                          child: AppSvg.asset(AssetUtils.downArrow,
                                              color: Theme.of(context).colorScheme.surfaceTint));
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 16.h,
                            ),
                            AppStreamBuilder<Resource<VoucherMinMaxValue>>(
                                initialData: Resource.none(),
                                stream: model.voucherMinMaxResponseStream,
                                dataBuilder: (context, voucherMinMaxResponse) {
                                  return AppTextField(
                                    labelText: S.of(context).maxPrice.toUpperCase(),
                                    hintText: S.of(context).pleaseSelect,
                                    readOnly: true,
                                    controller: model.maxPriceController,
                                    key: model.maxPriceKey,
                                    onPressed: () {
                                      if (model.categoryController.text.isEmpty) {
                                        model.categoryKey.currentState!.isValid = false;
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.SELECT_CATEGORY_FIRST));
                                      } else if (model.preferredRegionController.text.isEmpty) {
                                        model.preferredRegionKey.currentState!.isValid = false;
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.SELECT_REGION_FIRST));
                                      } else if (voucherMinMaxResponse?.status == Status.SUCCESS) {
                                        RelationshipWithCardHolderDialog.show(context,
                                            title: S.of(context).maxPrice,
                                            relationSHipWithCardHolder: model.rangeList, onDismissed: () {
                                          Navigator.pop(context);
                                        }, onSelected: (value) {
                                          Navigator.pop(context);
                                          model.maxPriceController.text = value;
                                          model.showResetFilterButton();
                                        });
                                      }
                                    },
                                    suffixIcon: (value, data) {
                                      return Container(
                                          height: 16.h,
                                          width: 16.w,
                                          padding: EdgeInsetsDirectional.only(end: 8.w),
                                          child: AppSvg.asset(AssetUtils.downArrow,
                                              color: Theme.of(context).colorScheme.surfaceTint));
                                    },
                                  );
                                }),
                            AppStreamBuilder<bool>(
                                stream: model.showButtonStream,
                                initialData: false,
                                dataBuilder: (context, isVisible) {
                                  return Visibility(
                                    visible: isVisible!,
                                    child: InkWell(
                                      onTap: () => model.resetFilter(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(top: 32.0.h),
                                        child: Text(
                                          S.of(context).resetFilter,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).textTheme.bodyLarge!.color!),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 40.h,
                            ),
                            AppStreamBuilder<Resource<bool>>(
                                initialData: Resource.none(),
                                stream: model.eVoucherFilterValidationResponseStream,
                                onData: (status) {
                                  if (status.status == Status.SUCCESS) {
                                    this.onSelected?.call(FilterSelectedData(
                                        filterOption: EvoucherFilterOption.FROM_FILTER_DIALOG,
                                        categryId: model.categryId,
                                        region: model.region,
                                        maxValue: model.maxPriceController.text.trim(),
                                        minValue: model.minPriceController.text.trim()));
                                  }
                                },
                                dataBuilder: (context, validationStatus) {
                                  return Container(
                                    color: Theme.of(context).dialogBackgroundColor.withOpacity(0),
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            model.getFilterValidated();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                                            height: 57.h,
                                            width: 57.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context).textTheme.bodyLarge!.color!),
                                            child: AppSvg.asset(AssetUtils.tick,
                                                color: Theme.of(context).colorScheme.secondary),
                                          ),
                                        ),
                                        GestureDetector(
                                          onVerticalDragEnd: (details) {
                                            if (details.primaryVelocity! > 0) {
                                              onDismissed?.call();
                                            }
                                          },
                                          behavior: HitTestBehavior.translucent,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 16.h),
                                            child: Center(
                                              child: Text(
                                                S.of(context).swipeDownToCancel,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 10.t,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context).colorScheme.surfaceTint),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: Theme.of(context).dialogBackgroundColor.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.scrim, borderRadius: BorderRadius.circular(16.w)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 16.0.w),
                          child: Text(message,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        reverseAnimationDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 700));
  }
}
