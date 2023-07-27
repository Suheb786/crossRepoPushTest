import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/e_voucher/get_settlement_amount/get_settlement_amount_request_entity.dart';
import 'package:data/entity/remote/e_voucher/place_order/place_order_request_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_category/voucher_categories_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_detail_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_details_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_list_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_min_max_value/voucher_min_max_value_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_min_max_value/voucher_min_max_value_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_region_by_categories/voucher_region_by_categories_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_region_by_categories/voucher_region_by_categories_response_entity.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_category_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_filter_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_search_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_filter_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/e_voucher/e_voucher_data_source.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
import 'package:domain/usecase/evouchers/place_order_usecase.dart';
import 'package:retrofit/dio.dart';

class EVoucherRemoteDSImpl extends EVoucherRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  EVoucherRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<VoucherHistoryListResponseEntity>> getMyVouchers(
      {required int pageNo, required int rangeOfMonths, required String searchPhrase}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getMyVouchers(VoucherHistoryRequest(
        pageNo: pageNo,
        searchPhrase: searchPhrase,
        rangeOfMonths: rangeOfMonths,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherCategoriesResponseEntity>> getVoucherCategories() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherCategories(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherDetailsResponseEntity>> getVoucherDetails(String orderIdentifier) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherDetails(
        VoucherDetailRequest(OrderIdentifier: orderIdentifier, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByCategory(String category) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getVoucherItemsByCategory(VoucherByCategoryRequest(Category: category, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsBySearch(String searchText) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getVoucherItemsBySearch(VoucherBySearchRequest(SearchText: searchText, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByFilter(
      {required String category,
      required String region,
      required String searchText,
      required num minValue,
      required num maxValue}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getVoucherItemsByFilter(VoucherByFilterRequest(
      category: category,
      region: region,
      minValue: minValue,
      maxValue: maxValue,
      searchText: searchText,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> placeOrder({required PlaceOrderUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.placeOrder(PlaceOrderRequestEntity(
        Denomination: params.Denomination,
        exchangeRate: params.exchangeRate,
        reconcilationCurrency: params.reconcilationCurrency,
        Discount: params.Discount,
        VoucherName: params.VoucherName,
        VoucherCategory: params.VoucherCategory,
        AccountNo: params.AccountNo,
        GetToken: true,
        BaseClass: baseData.toJson()));
  }

  Future<HttpResponse<VoucherRegionByCategoriesResponseEntity>> getRegionsByCategories(
      {required String category}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getRegionsByCategories(VoucherRegionByCategoriesRequest(
      category: category,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getSettlementAmount(
      {required GetSettlementAmountUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getSettlementAmount(GetSettlementAmountRequestEntity(
      Amount: params.Amount,
      FromCurrency: params.FromCurrency,
      ToCurrency: params.ToCurrency,
      GetToken: true,
      BaseClass: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> eVoucherOtp({required EVoucherUsecaseOTPParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.eVoucherOtp(BaseRequest(baseData: baseData.toJson()));
  }

  Future<HttpResponse<VoucherMinMaxValueResponseEntity>> getMinMaxRange(
      {required String category, required String region}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getMinMaxRange(VoucherMinMaxValueRequest(
      category: category,
      region: region,
      baseData: baseData.toJson(),
    ));
  }
}
