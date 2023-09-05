import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page_view_model.dart';
import 'package:neo_bank/feature/offer_campaign/offer_detail/offer_detail_page_view_model.dart';

final offerForYouPageViewModelProvider = ChangeNotifierProvider.autoDispose<OfferForYouPageViewModel>(
  (ref) => OfferForYouPageViewModel(),
);

final offerDetailPageViewModelProvider = ChangeNotifierProvider.autoDispose<OfferDetailPageViewModel>(
  (ref) => OfferDetailPageViewModel(),
);
