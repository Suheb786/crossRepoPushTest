import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/offer_campaign/offer_campaign_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:domain/repository/offer_campaign/offer_campaign_repository.dart';

class OfferCampaignRepositoryImpl extends OfferCampaignRepository {
  final OfferCampaignRemoteDataSource _offerCampaignDS;

  OfferCampaignRepositoryImpl(this._offerCampaignDS);

  @override
  Future<Either<NetworkError, List<Offers>>> getAllOffers(
      {required num categoryId,
      required String searchText,
      required int pageNo,
      required int totalRecord}) async {
    final result = await safeApiCall(_offerCampaignDS.getAllOffers(
        pageNo: pageNo, totalRecord: totalRecord, categoryId: categoryId, searchText: searchText));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<OffersCategories>>> getOfferCategories() async {
    final result = await safeApiCall(_offerCampaignDS.getOfferCategories());
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
