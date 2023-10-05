import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/offer_campaign/offer/offers_request_entity.dart';
import 'package:data/entity/remote/offer_campaign/offer/offers_response_entity.dart';
import 'package:data/entity/remote/offer_campaign/offer_categories/offers_categories_request_entity.dart';
import 'package:data/entity/remote/offer_campaign/offer_categories/offers_categories_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/offer_campaign/offer_campaign_datasource.dart';
import 'package:retrofit/dio.dart';

class OfferCampaignRemoteDataSourceImpl extends OfferCampaignRemoteDataSource {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  OfferCampaignRemoteDataSourceImpl(this._apiService, this._deviceInfoHelper);

  @override
  @override
  Future<HttpResponse<OffersResponseEntity>> getAllOffers({
    required num categoryId,
    required String searchText,
    required int pageNo,
    required int totalRecord,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAllOffers(OffersRequestEntity(
      baseData: baseData.toJson(),
      categoryId: categoryId,
      searchText: searchText,
      pageNo: pageNo,
      totalRecord: totalRecord,
    ));
  }

  @override
  Future<HttpResponse<OffersCategoriesResponseEntity>> getOfferCategories() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getOfferCategories(OffersCategoriesRequestEntity(baseData: baseData.toJson()));
  }
}
