import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';

abstract class OfferCampaignRepository {
  Future<Either<NetworkError, List<Offers>>> getAllOffers(
      {required num categoryId, required String searchText, required int pageNo, required int totalRecord});

  Future<Either<NetworkError, List<OffersCategories>>> getOfferCategories();
}
