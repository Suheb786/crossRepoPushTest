import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'offer_for_you_page_view_model.dart';

class OfferForYouPageView extends BasePageViewWidget<OfferForYouPageViewModel> {
  OfferForYouPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, OfferForYouPageViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          searchContact(context, model),
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
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
                                child: Row(
                                  children: [
                                    Text(searchList[index],
                                        style: TextStyle(
                                            fontSize: 12.t,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).scaffoldBackgroundColor)),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        start: 4.0.w,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          model.removeSearchTextList(index);
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
            child: listItem(model),
          )
        ],
      ),
    );
  }

  searchContact(context, OfferForYouPageViewModel model) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Focus(
                onFocusChange: (hasChanged) {
                  if (!hasChanged) {}
                },
                child: AppTextField(
                  labelText: '',
                  controller: model.offerSearchController,
                  textFieldBorderColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                  hintTextColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                  textColor: Theme.of(context).primaryColorDark,
                  hintText: S.of(context).lookingFor,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  onFieldSubmitted: (data) {
                    if (data.isNotEmpty) {
                      model.addSearchTextList(data);
                    }
                  },
                  suffixIcon: (value, data) {
                    return InkWell(
                      onTap: () async {},
                      child: Container(
                          height: 16.h,
                          width: 16.w,
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                    );
                  },
                ),
              )),
              SizedBox(
                width: 24.w,
              ),
              InkWell(
                onTap: () {
                  // FilterTransactionDialog.show(
                  //   context,
                  //   onDismissed: () => Navigator.pop(context),
                  //   onSelected: (value) {
                  //     Navigator.pop(context);
                  //   },
                  // );

                  InformationDialog.show(context,
                      image: AssetUtils.referIcon,
                      title: S.of(context).referFriend,
                      btnTitle: S.of(context).invite,
                      descriptionWidget: Text(
                        S.of(context).referFriendDescription("100 JOD"),
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.t,
                          fontWeight: FontWeight.w400,
                        ),
                      ), onSelected: () {
                    Navigator.pop(context);
                  }, onDismissed: () {
                    Navigator.pop(context);
                  });
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
        )
      ],
    );
  }

  listItem(OfferForYouPageViewModel model) {
    return ListView.separated(
      itemCount: 6,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.OfferDetailPage);
          },
          child: OfferListWidget(),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return AppDivider();
      },
    );
  }
}

class OfferListWidget extends StatelessWidget {
  const OfferListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 104.w,
              height: 104.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(16.w)),
              child: CachedNetworkImage(
                imageUrl: "",
                placeholder: (context, url) => Container(color: Theme.of(context).primaryColor),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gerard",
                  style: TextStyle(
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 4.w,
                ),
                Text(
                  "15% discount on Debit Card",
                  style: TextStyle(
                      fontSize: 12.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surfaceTint),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Text(
                  "Ends on 27th Sep",
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
                      color: getColor(OfferType.EARLY), borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    "2 days left",
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.t),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getColor(OfferType value) {
    switch (value) {
      case OfferType.EARLY:
        return AppColor.darkModerateLimeGreen;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
