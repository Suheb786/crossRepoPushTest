import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/repository/offer_campaign/offer_campaign_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class OfferUseCase extends BaseUseCase<NetworkError, OfferUseCaseParams, List<Offers>> {
  final OfferCampaignRepository _offerCampaignRepository;

  OfferUseCase(this._offerCampaignRepository);

  @override
  Future<Either<NetworkError, List<Offers>>> execute({required OfferUseCaseParams params}) {
    return _offerCampaignRepository.getAllOffers(
        categoryId: params.categoryId,
        searchText: params.searchTxt,
        pageNo: params.pageNo,
        totalRecord: params.totalRecord);
  }
}

class OfferUseCaseParams extends Params {
  final String searchTxt;
  final num categoryId;
  final int pageNo;
  final int totalRecord;

  OfferUseCaseParams({
    required this.searchTxt,
    required this.categoryId,
    required this.pageNo,
    required this.totalRecord,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
