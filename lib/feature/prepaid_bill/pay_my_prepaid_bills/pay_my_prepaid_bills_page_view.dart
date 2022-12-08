import 'dart:ui';

import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/prepaid_bill/how_much_like__to_pay_prepaid_bills/how_much_like_to_pay_prepaid_bills_page.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/denomintion_dialog/denomination_dialog.dart';
import 'package:neo_bank/ui/molecules/prepaid/pay_my_prepaid_bills/pay_my_prepaid_bill_list_item_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayMyPrePaidBillsPageView
    extends BasePageViewWidget<PayMyPrePaidBillsPageViewModel> {
  PayMyPrePaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PayMyPrePaidBillsPageViewModel model) {
    return AppStreamBuilder<Resource<GetPrePaidCategoriesModel>>(
        initialData: Resource.none(),
        stream: model.gerPrePaidCategoriesStream,
        onData: (value) {
          if (value.status == Status.SUCCESS) {
            model.getPrepaidCategoriesModelData =
                value.data!.content!.getPrepaidBillerListModelData!;
            if (model.getPrepaidCategoriesModelData != null &&
                model.getPrepaidCategoriesModelData.isNotEmpty) {
              model.isPrePaidCategoryEmpty = false;
              _showPrePaidCategoriesList(context, model);
            } else {
              model.isPrePaidCategoryEmpty = true;
              Navigator.pushNamed(
                  context, RoutePaths.HowMuchLikeToPayPrePaidBillsPage,
                  arguments: HowMuchLikeToPayPrePaidBillsPageArgument(
                      [model.getPrepaidBillerListModelData]));
            }
          } else {
            model.isPrePaidCategoryEmpty = true;
          }
        },
        dataBuilder: (context, snapshot) {
          return AppStreamBuilder<Resource<GetPrepaidBillerListModel>>(
              initialData: Resource.none(),
              stream: model.prepaidBillerStream,
              onData: (value) {
                if (value.status == Status.SUCCESS) {
                  model.getPrepaidBillData = value
                          .data
                          ?.getPrepaidBillerListContent
                          ?.getPrepaidBillerListData ??
                      [];
                  debugPrint("value.status:${value.status}");
                } else if (value.status == Status.ERROR) {
                  debugPrint("value.status:${value.status}");
                  model.showToastWithError(value.appError!);
                }
              },
              dataBuilder: (context, snapshot) {
                bool isContentNull =
                    snapshot!.data?.getPrepaidBillerListContent == null;
                if (snapshot.status == Status.NONE) return SizedBox.shrink();
                if (snapshot.status == Status.LOADING) return SizedBox.shrink();

                /* if (isContentNull)
                  return _noBillerRegistered(context);

                if (snapshot.status == Status.SUCCESS) {
                  if (snapshot.data!.getPrepaidBillerListContent!
                      .getPrepaidBillerListData!.isEmpty) {
                    return _noBillerRegistered(context);
                  }
                }*/
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (StringUtils.isDirectionRTL(context)) {
                      if (!details.primaryVelocity!.isNegative) {
                        Navigator.pop(context);
                      }
                    } else {
                      if (details.primaryVelocity!.isNegative) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 24.0.w,
                              right: 24.0.w,
                              top: 8.0.h,
                              bottom: 56.h),
                          child: Column(
                            children: [
                              Container(
                                  width: 64.0.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                      color: AppColor.whiteGrey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)))),
                              SizedBox(
                                height: 24.0.h,
                              ),
                              model.getPrepaidBillData != null &&
                                      model.getPrepaidBillData!.length > 0
                                  ? AppTextField(
                                      labelText: '',
                                      hintText: S.of(context).searchBill,
                                      controller: model.searchBillController,
                                      readOnly: true,
                                      onPressed: () {},
                                      suffixIcon: (value, data) {
                                        return Container(
                                            height: 16.h,
                                            width: 16.w,
                                            padding:
                                                EdgeInsets.only(right: 8.w),
                                            child: AppSvg.asset(
                                                AssetUtils.search,
                                                color: AppColor.dark_gray_1));
                                      },
                                    )
                                  : Container(),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 24.0.h, bottom: 24.0.h),
                                  child: model.getPrepaidBillData != null &&
                                          model.getPrepaidBillData!.length > 0
                                      ? ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: model
                                                  .getPrepaidBillData?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                _onPrePaidListItemSection(
                                                    model, index);
                                              },
                                              child: Slidable(
                                                endActionPane: ActionPane(
                                                  extentRatio: 0.25,
                                                  motion: DrawerMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      // An action can be bigger than the others.
                                                      onPressed: (context1) => {
                                                        InformationDialog.show(
                                                            context,
                                                            image: AssetUtils
                                                                .deleteBlackIcon,
                                                            isSwipeToCancel:
                                                                false,
                                                            title: S
                                                                .of(context)
                                                                .areYouSure,
                                                            descriptionWidget:
                                                                Text(
                                                              S
                                                                  .of(context)
                                                                  .doYouReallyDeleteSavedBills,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ), onDismissed: () {
                                                          Navigator.pop(
                                                              context);
                                                        }, onSelected: () {
                                                          Navigator.pop(
                                                              context);
                                                          var registrationId = model
                                                              .getPrepaidBillData?[
                                                                  index]
                                                              .registrationId;
                                                          model.removePrepaidBiller(
                                                              registrationId);
                                                        })
                                                      },
                                                      backgroundColor:
                                                          AppColor.dark_brown,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                    ),
                                                  ],
                                                ),
                                                child:
                                                    PayMyPrepPaidBillListItemWidget(
                                                  billName: model
                                                          .getPrepaidBillData?[
                                                              index]
                                                          .billerName ??
                                                      "",
                                                  billType: model
                                                          .getPrepaidBillData?[
                                                              index]
                                                          .serviceType ??
                                                      "",
                                                  icon: model
                                                          .getPrepaidBillData?[
                                                              index]
                                                          .iconCode ??
                                                      "",
                                                ),
                                              ),

                                              // child:
                                              //     PayMyPrepPaidBillListItemWidget(
                                              //   billName: model
                                              //           .getPrepaidBillData?[
                                              //               index]
                                              //           .billerName ??
                                              //       "",
                                              //   billType: model
                                              //           .getPrepaidBillData?[
                                              //               index]
                                              //           .serviceType ??
                                              //       "",
                                              //   icon: model
                                              //           .getPrepaidBillData?[
                                              //               index]
                                              //           .iconCode ??
                                              //       "",
                                              // ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return AppDivider();
                                          },
                                        )
                                      : Center(
                                          child: Text(
                                            S.of(context).noDataFound,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  showSuccessMsg(context, String title, String message) {
    showTopSnackBar(
        context,
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsetsDirectional.all(16),
              decoration: BoxDecoration(
                  color: AppColor.darkModerateLimeGreen,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(top: 4.0, end: 16),
                          child: Text(message,
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1000),
        hideOutAnimationDuration: Duration(milliseconds: 200),
        showOutAnimationDuration: Duration(milliseconds: 500));
  }

  void _onPrePaidListItemSection(
      PayMyPrePaidBillsPageViewModel model, int index) {
    model.getPrepaidBillerListModelData =
        model.getPrepaidBillData?[index] ?? GetPrepaidBillerListModelData();
    AppConstantsUtils.SELECTED_BILLER_CODE =
        model.getPrepaidBillData?[index].billerCode ?? "";
    AppConstantsUtils.SELECTED_SERVICE_CODE =
        model.getPrepaidBillData?[index].serviceCode ?? "";
    if (AppConstantsUtils.SELECTED_BILLER_CODE.isNotEmpty &&
        AppConstantsUtils.SELECTED_SERVICE_CODE.isNotEmpty) {
      model.getPrePaidCategoresList(AppConstantsUtils.SELECTED_SERVICE_CODE,
          AppConstantsUtils.SELECTED_BILLER_CODE);
    }
  }

  void _showPrePaidCategoriesList(
      BuildContext context, PayMyPrePaidBillsPageViewModel model) {
    DenominationsDialog.show(context,
        getPrePaidCategoriesList: model.getPrepaidCategoriesModelData,
        label: S.of(context).denomination,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        serviceCode: AppConstantsUtils.SELECTED_SERVICE_CODE,
        onDismissed: () => Navigator.pop(context),
        onSelected: (value) {
          AppConstantsUtils.PREPAID_CATEGORY_CODE = value.code.toString();
          AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION =
              value.description.toString();
          AppConstantsUtils.PREPAID_CATEGORY_TYPE = value.type.toString();
          Navigator.pop(context);
          Navigator.pushNamed(
              context, RoutePaths.HowMuchLikeToPayPrePaidBillsPage,
              arguments: HowMuchLikeToPayPrePaidBillsPageArgument(
                  [model.getPrepaidBillerListModelData]));
        });
  }

/*
  Container _noBillerRegistered(context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.very_light_grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(80))),
            height: 64,
            width: 64,
            child: Container(
              height: 30,
              width: 32,
              child: SvgPicture.asset(
                AssetUtils.bill,
                color: Theme.of(context).primaryColor,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              S.of(context).youDoNotHavePrePaidBillerRegisteredYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontStyle: FontStyle.normal),
            ),
          ),

          // _accountDetailsWidget(model),
        ],
      ),
    );
  }
*/
}
