import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_category/voucher_categories_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_detail_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_details_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_list_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_category_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_filter_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_search_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_filter_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/e_voucher/e_voucher_data_source.dart';
import 'package:retrofit/dio.dart';

class EVoucherRemoteDSImpl extends EVoucherRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  EVoucherRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<VoucherHistoryListResponseEntity>> getMyVouchers(
      String pageNo, int rangeOfMonths) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getMyVouchers(VoucherHistoryRequest(
        PageNo: pageNo,
        rangeOfMonths: rangeOfMonths,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherCategoriesResponseEntity>>
      getVoucherCategories() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getVoucherCategories(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherDetailsResponseEntity>> getVoucherDetails(
      String orderIdentifier) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherDetails(VoucherDetailRequest(
        OrderIdentifier: orderIdentifier, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByCategory(
      String category) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherItemsByCategory(VoucherByCategoryRequest(
        Category: category, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsBySearch(
      String searchText) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherItemsBySearch(VoucherBySearchRequest(
        SearchText: searchText, baseData: baseData.toJson()));
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
}
