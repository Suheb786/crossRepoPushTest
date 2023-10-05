import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/offer_campaign/offer_categories_usecase.dart';
import 'package:domain/usecase/offer_campaign/offer_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[OfferUseCase] provider
final offerUseCaseProvider =
    Provider.autoDispose<OfferUseCase>((ref) => OfferUseCase(ref.read(offerCampaignRepositoryProvider)));

///[OffersCategoriesUseCase] provider
final offersCategoriesUseCaseProvider = Provider.autoDispose<OffersCategoriesUseCase>(
    (ref) => OffersCategoriesUseCase(ref.read(offerCampaignRepositoryProvider)));
