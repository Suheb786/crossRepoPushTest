import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/offer_campaign/offer_usecase_provider.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page_view_model.dart';
import 'package:neo_bank/feature/offer_campaign/offer_detail/offer_detail_page.dart';
import 'package:neo_bank/feature/offer_campaign/offer_detail/offer_detail_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/offer_dialog/filter_offer_categories/filter_offer_categories_dialog_view_model.dart';

final offerForYouPageViewModelProvider = ChangeNotifierProvider.autoDispose<OfferForYouPageViewModel>(
  (ref) =>
      OfferForYouPageViewModel(ref.read(offerUseCaseProvider), ref.read(offersCategoriesUseCaseProvider)),
);

final offerDetailPageViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<OfferDetailPageViewModel, OfferDetailPageArgument>(
  (ref, args) => OfferDetailPageViewModel(
    argument: args,
  ),
);

final filterOfferCategoriesDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<FilterOfferCategoriesDialogViewModel>(
  (ref) => FilterOfferCategoriesDialogViewModel(),
);
