// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/offer_campaign/offer_campaign_modules.dart';

import 'offer_detail_page_view.dart';
import 'offer_detail_page_view_model.dart';

class OfferDetailPage extends BasePage<OfferDetailPageViewModel> {
  final OfferDetailPageArgument argument;

  OfferDetailPage(this.argument);

  @override
  OfferDetailPageState createState() => OfferDetailPageState();
}

class OfferDetailPageState extends BaseStatefulPage<OfferDetailPageViewModel, OfferDetailPage> {
  @override
  ProviderBase provideBase() {
    return offerDetailPageViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  @override
  void onModelReady(OfferDetailPageViewModel model) {
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, OfferDetailPageViewModel model) {
    return OfferDetailPageView(provideBase());
  }
}

class OfferDetailPageArgument {
  final Offers offers;

  OfferDetailPageArgument(
    this.offers,
  );
}