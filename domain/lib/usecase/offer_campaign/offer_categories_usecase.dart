import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:domain/repository/offer_campaign/offer_campaign_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class OffersCategoriesUseCase
    extends BaseUseCase<NetworkError, OffersCategoriesUseCaseParams, List<OffersCategories>> {
  final OfferCampaignRepository _offerCampaignRepository;

  OffersCategoriesUseCase(this._offerCampaignRepository);

  @override
  Future<Either<NetworkError, List<OffersCategories>>> execute(
      {required OffersCategoriesUseCaseParams params}) {
    return _offerCampaignRepository.getOfferCategories();
  }
}

class OffersCategoriesUseCaseParams extends Params {
  OffersCategoriesUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
