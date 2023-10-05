import 'package:data/entity/remote/offer_campaign/offer/offers_response_entity.dart';
import 'package:data/entity/remote/offer_campaign/offer_categories/offers_categories_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class OfferCampaignRemoteDataSource {
  Future<HttpResponse<OffersResponseEntity>> getAllOffers(
      {required num categoryId, required String searchText, required int pageNo, required int totalRecord});

  Future<HttpResponse<OffersCategoriesResponseEntity>> getOfferCategories();
}
