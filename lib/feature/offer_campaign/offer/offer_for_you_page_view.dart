import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/offer_campaign/offer_detail/offer_detail_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/offer_dialog/filter_offer_categories/filter_offer_categories_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/no_data_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import 'offer_for_you_page_view_model.dart';

class OfferForYouPageView extends BasePageViewWidget<OfferForYouPageViewModel> {
  OfferForYouPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, OfferForYouPageViewModel model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<List<Offers>>>(
          stream: model.getOfferStream,
          initialData: Resource.none(),
          dataBuilder: (context, offerList) {
            return AppStreamBuilder<Resource<List<OffersCategories>>>(
                stream: model.getFilterCategoriesStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS && (data.data ?? []).isNotEmpty) {
                    data.data?.insert(
                        0, OffersCategories(id: 0, categoryId: 0, categoryName: S.current.allCategories));
                    FilterOfferCategoriesDialog.show(context,
                        label: S.of(context).offersCategory,
                        onDismissed: () => Navigator.pop(context),
                        onSelected: (offerCategories) {
                          model.categoryID = offerCategories.categoryId ?? 0;

                          ///for getting new list of offer after filter
                          model.allOfferList = [];
                          model.getOffer(
                              categoryId: model.categoryID,
                              searchTxt: model.searchTextList.join(","),
                              pageNo: 1);
                          Navigator.pop(context);
                        },
                        listOfOffersCategories: data.data!);
                  }
                },
                dataBuilder: (context, categoriesList) {
                  return Column(
                    children: [
                      searchContact(context, model, offerList),
                      AppStreamBuilder<List<String>>(
                          stream: model.getSearchTextListStream,
                          initialData: List.empty(),
                          dataBuilder: (context, searchList) {
                            return Visibility(
                              visible: (searchList ?? []).isNotEmpty ? true : false,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(top: 24.0.h),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 24.0.h,
                                    child: ListView.builder(
                                      itemCount: searchList!.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 9.0.w),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColorDark,
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 8.w, right: 8.w, top: 3.5.h, bottom: 2.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(searchList[index],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12.t,
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context).scaffoldBackgroundColor)),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.only(start: 4.0.w, bottom: 2.5.h),
                                                  child: InkWell(
                                                    onTap: () {
                                                      model.removeSearchTextList(
                                                          index: index, categoryId: model.categoryID);
                                                    },
                                                    child: AppSvg.asset(AssetUtils.close,
                                                        height: 12.h,
                                                        width: 12.w,
                                                        color: Theme.of(context).colorScheme.secondary),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      Expanded(
                        child: listItem(model, offerList),
                      )
                    ],
                  );
                });
          }),
    );
  }

  searchContact(context, OfferForYouPageViewModel model, Resource<List<Offers>>? offerList) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: AppTextField(
                labelText: '',
                controller: model.offerSearchController,
                textFieldBorderColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                hintTextColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                textColor: Theme.of(context).primaryColorDark,
                hintText: S.of(context).lookingFor,
                inputAction: TextInputAction.done,
                onChanged: (value) {},
                onFieldSubmitted: (data) {
                  if (data.isNotEmpty &&
                      offerList?.status == Status.SUCCESS &&
                      (offerList?.data ?? []).isNotEmpty) {
                    model.addSearchTextList(categoryId: model.categoryID, searchTxt: data);
                  }
                },
                suffixIcon: (value, data) {
                  return InkWell(
                    onTap: () async {},
                    child: Container(
                        height: 16.h,
                        width: 16.w,
                        padding: const EdgeInsets.all(6),
                        child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                  );
                },
              )),
              SizedBox(
                width: 24.w,
              ),
              InkWell(
                onTap: () {
                  model.getFilterCategories();
                },
                child: AppSvg.asset(
                  AssetUtils.filter,
                  color: Theme.of(context).colorScheme.shadow,
                  height: 24.h,
                  width: 24.w,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        )
      ],
    );
  }

  listItem(OfferForYouPageViewModel model, Resource<List<Offers>>? offerList) {
    switch (offerList?.status) {
      case Status.SUCCESS:
        return (offerList?.data != null && (offerList?.data ?? []).isNotEmpty)
            ? SingleChildScrollView(
                controller: model.listController,
                child: ListView.separated(
                  itemCount: offerList!.data!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.OfferDetailPage,
                            arguments: OfferDetailPageArgument(offerList.data![index]));
                      },
                      child: OfferListWidget(
                        offers: offerList.data![index],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      child: AppDivider(),
                    );
                  },
                ),
              )
            : Center(child: NoDataWidget());

      default:
        return Container();
    }
  }
}

class OfferListWidget extends StatelessWidget {
  final Offers offers;

  const OfferListWidget({
    Key? key,
    required this.offers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.w), boxShadow: [
            BoxShadow(offset: Offset(0, 8), blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.10))
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.w)),
            child: Image.memory(
              offers.image,
              fit: BoxFit.fill,
              height: 104.h,
              width: 104.w,
            ),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offers.campaignName ?? '',
                style: TextStyle(
                  fontSize: 14.t,
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                offers.descriptions ?? '',
                style: TextStyle(
                    fontSize: 12.t,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.surfaceTint),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                S
                    .of(context)
                    .endsOn(TimeUtils.getFormattedDateForTransaction(offers.campaignValidTill ?? '')),
                style: TextStyle(
                    fontSize: 12.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surfaceTint),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.only(start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                decoration: BoxDecoration(
                    color: TimeUtils.differentBetweenTwoDateInDays(offers.campaignValidTill ?? '') <= 9
                        ? getColor(OfferType.EARLY)
                        : getColor(OfferType.LATER),
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  S.of(context).daysLeft(
                      TimeUtils.differentBetweenTwoDateInDays(offers.campaignValidTill ?? '').toString()),
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0.t),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Color getColor(OfferType value) {
    switch (value) {
      case OfferType.EARLY:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
