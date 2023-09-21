import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_page.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contact_details/beneficiary_contact_details_page.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contacts_list/beneficiary_contacts_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/beneficiary_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../utils/navgition_type.dart';

class BeneficiarySendMoneyListPageView extends BasePageViewWidget<BeneficiaryContactListPageViewModel> {
  BeneficiarySendMoneyListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BeneficiaryContactListPageViewModel model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24.0.w,
          right: 24.0.w,
          top: 24.h,
        ),
        child: Column(
          children: [
            searchContact(context, model),
            listItem(context, model),
          ],
        ),
      ),
    );
  }

  searchContact(context, BeneficiaryContactListPageViewModel model) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AppStreamBuilder<Resource<BeneficiaryContact>>(
                    stream: model.getSMBeneficiaryListStream,
                    initialData: Resource.none(),
                    dataBuilder: (context, beneficiaryList) {
                      return Focus(
                        onFocusChange: (hasChanged) {
                          if (!hasChanged) {
                            if (((beneficiaryList?.data?.beneficiarySendMoneyContact
                                                ?.beneficiaryFavoriteContact ??
                                            [])
                                        .isNotEmpty ||
                                    (beneficiaryList?.data?.beneficiarySendMoneyContact
                                                ?.beneficiaryOtherContact ??
                                            [])
                                        .isNotEmpty) &&
                                model.sendMoneySearchController.text.isNotEmpty) {
                              model.searchBeneficiary(model.sendMoneySearchController.text, "SM");
                            } else {
                              model.getBeneficiaryList(
                                  isFromSearch: true, navigationType: NavigationType.SEND_MONEY);
                            }
                          }
                        },
                        child: AppTextField(
                          labelText: '',
                          controller: model.sendMoneySearchController,
                          textFieldBorderColor:
                              Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                          hintTextColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                          textColor: Theme.of(context).primaryColorDark,
                          hintText: S.of(context).searchContacts,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              //  FocusScope.of(context).unfocus();
                              model.getBeneficiaryList(
                                  isFromSearch: true, navigationType: NavigationType.SEND_MONEY);
                            }
                          },
                          onFieldSubmitted: (data) {},
                          suffixIcon: (value, data) {
                            return InkWell(
                              onTap: () async {},
                              child: Container(
                                  height: 16.h,
                                  width: 16.w,
                                  padding: EdgeInsetsDirectional.only(end: 8.w),
                                  child: AppSvg.asset(AssetUtils.search,
                                      color: Theme.of(context).primaryColorDark)),
                            );
                          },
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: 8.w,
              ),
              InkWell(
                onTap: () async {
                  model.isNewRecordCreated = true;
                  var result = await Navigator.pushNamed(
                      context, RoutePaths.AddContactsIBANManageContactsPage,
                      arguments: AddBeneficiaryPageArguments(
                          navigationType: NavigationType.SEND_MONEY, isFromContactCard: false));

                  if (result != null && result == true) {
                    model.getBeneficiaryList(isFromSearch: false);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0.w)),
                      border: Border.all(color: Theme.of(context).colorScheme.shadow.withOpacity(0.3))),
                  child: AppSvg.asset(AssetUtils.plusIcon,
                      color: Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  listItem(context, BeneficiaryContactListPageViewModel model) {
    return AppStreamBuilder<Resource<bool>>(
        stream: model.beneficiaryMarkFavoriteResponseStream,
        initialData: Resource.none(),
        onData: (isFavoriteStatus) {
          if (isFavoriteStatus.status == Status.SUCCESS) {
            model.getBeneficiaryList(isFromSearch: false);
          }
        },
        dataBuilder: (context, isFavoriteStatus) {
          return AppStreamBuilder<Resource<BeneficiaryContact>>(
              stream: model.getSearchBeneficiaryListStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.LOADING) {
                  AppProgress(context);
                } else {
                  Navigator.pop(context);
                }
              },
              dataBuilder: (context, searchBeneficiaryList) {
                return AppStreamBuilder<Resource<BeneficiaryContact>>(
                    stream: model.getSMBeneficiaryListStream,
                    initialData: Resource.none(),
                    dataBuilder: (context, beneficiaryList) {
                      switch (beneficiaryList?.status) {
                        case Status.SUCCESS:
                          return ((beneficiaryList?.data?.beneficiarySendMoneyContact
                                              ?.beneficiaryFavoriteContact ??
                                          [])
                                      .isNotEmpty ||
                                  (beneficiaryList
                                              ?.data?.beneficiarySendMoneyContact?.beneficiaryOtherContact ??
                                          [])
                                      .isNotEmpty)
                              ? Expanded(
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.w)),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          elevation: 2,
                                          shadowColor:
                                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                                          margin: EdgeInsets.only(top: 16.h),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                  visible: (beneficiaryList?.data?.beneficiarySendMoneyContact
                                                              ?.beneficiaryFavoriteContact ??
                                                          [])
                                                      .isNotEmpty,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.only(start: 16.w, top: 24.h),
                                                    child: Text(S.of(context).favourites,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 14.t,
                                                            color: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .color)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: (beneficiaryList?.data?.beneficiarySendMoneyContact
                                                              ?.beneficiaryFavoriteContact ??
                                                          [])
                                                      .isNotEmpty,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (context, index) {
                                                      ///send data from api response once updated
                                                      return BeneficiaryListWidget(
                                                        beneficiary: beneficiaryList
                                                            ?.data
                                                            ?.beneficiarySendMoneyContact
                                                            ?.beneficiaryFavoriteContact![index],
                                                        onTap: () async {
                                                          model.isNewRecordCreated = false;

                                                          var result = await Navigator.pushNamed(context,
                                                              RoutePaths.BeneficiaryContactDetailsPage,
                                                              arguments: BeneficiaryContactDetailArguments(
                                                                  navigationType: NavigationType.SEND_MONEY,
                                                                  beneficiaryInformation: beneficiaryList
                                                                      ?.data
                                                                      ?.beneficiarySendMoneyContact
                                                                      ?.beneficiaryFavoriteContact![index],
                                                                  isFromContactCard: false));

                                                          if (result != null && result == true) {
                                                            model.getBeneficiaryList(isFromSearch: false);
                                                          }
                                                        },
                                                        onFavClick: (beneficiary) {
                                                          model.markAsFavorite(
                                                              beneficiaryDetailId: beneficiary.id,
                                                              isFavorite: false,
                                                              userId: beneficiary.userId,
                                                              isFromMobile: true,
                                                              beneType: beneficiary.beneficiaryType);
                                                        },
                                                      );
                                                    },
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: beneficiaryList
                                                        ?.data
                                                        ?.beneficiarySendMoneyContact
                                                        ?.beneficiaryFavoriteContact
                                                        ?.length,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 32.h,
                                                ),
                                                Visibility(
                                                  visible: (beneficiaryList?.data?.beneficiarySendMoneyContact
                                                              ?.beneficiaryOtherContact ??
                                                          [])
                                                      .isNotEmpty,
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 16.w),
                                                    child: Text(S.of(context).others,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 14.t,
                                                            color: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .color)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: (beneficiaryList?.data?.beneficiarySendMoneyContact
                                                              ?.beneficiaryOtherContact ??
                                                          [])
                                                      .isNotEmpty,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (context, index) {
                                                      ///send data from api response once updated
                                                      return BeneficiaryListWidget(
                                                        beneficiary: beneficiaryList
                                                            ?.data
                                                            ?.beneficiarySendMoneyContact
                                                            ?.beneficiaryOtherContact![index],
                                                        onTap: () async {
                                                          model.isNewRecordCreated = false;

                                                          var result = await Navigator.pushNamed(context,
                                                              RoutePaths.BeneficiaryContactDetailsPage,
                                                              arguments: BeneficiaryContactDetailArguments(
                                                                  navigationType: NavigationType.SEND_MONEY,
                                                                  beneficiaryInformation: beneficiaryList
                                                                      ?.data
                                                                      ?.beneficiarySendMoneyContact
                                                                      ?.beneficiaryOtherContact![index],
                                                                  isFromContactCard: false));

                                                          if (result != null && result == true) {
                                                            model.getBeneficiaryList(isFromSearch: false);
                                                          }
                                                        },
                                                        onFavClick: (beneficiary) {
                                                          model.markAsFavorite(
                                                              beneficiaryDetailId: beneficiary.id,
                                                              isFavorite: true,
                                                              userId: beneficiary.userId,
                                                              isFromMobile: true,
                                                              beneType: beneficiary.beneficiaryType);
                                                        },
                                                      );
                                                    },
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: beneficiaryList
                                                        ?.data
                                                        ?.beneficiarySendMoneyContact
                                                        ?.beneficiaryOtherContact
                                                        ?.length,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 24.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : noDataFound(context, model);
                        default:
                          return Container();
                      }
                    });
              });
        });
  }

  noDataFound(context, BeneficiaryContactListPageViewModel model) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 96.h,
              width: 96.w,
              margin: EdgeInsetsDirectional.only(bottom: 12.h),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).inputDecorationTheme.hintStyle!.color!)),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                  child: AppSvg.asset(AssetUtils.contacts)),
            ),
            GestureDetector(
              onTap: () async {
                model.isNewRecordCreated = true;
                var result = await Navigator.pushNamed(context, RoutePaths.AddContactsIBANManageContactsPage,
                    arguments: AddBeneficiaryPageArguments(
                        navigationType: NavigationType.SEND_MONEY, isFromContactCard: false));

                if (result != null && result == true) {
                  model.getBeneficiaryList(isFromSearch: false);
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                child: Text(S.of(context).addContact,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
