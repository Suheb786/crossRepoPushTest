import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/e_voucher/my_vouchers_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_by_category_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_by_filter_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_by_search_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail_request.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/e_voucher/e_voucher_data_source.dart';

import 'package:retrofit/dio.dart';

class EVoucherRemoteDSImpl extends EVoucherRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  EVoucherRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> getMyVouchers(String pageNo, String fromDate, String toDate) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getMyVouchers(
        MyVouchersRequest(PageNo: pageNo, FromDate: fromDate, ToDate: toDate, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getVoucherCategories() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherCategories(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getVoucherDetails(String orderIdentifier) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherDetails(
        VoucherDetailRequest(OrderIdentifier: orderIdentifier, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getVoucherItemsByCategory(String category) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getVoucherItemsByCategory(VoucherByCategoryRequest(Category: category, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getVoucherItemsByFilter(
      String category, String region, String minValue, String maxValue) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getVoucherItemsByFilter(VoucherByFilterRequest(
      Category: category,
      Region: region,
      MinValue: minValue,
      MaxValue: maxValue,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getVoucherItemsBySearch(String searchText) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getVoucherItemsBySearch(VoucherBySearchRequest(SearchText: searchText, baseData: baseData.toJson()));
  }
}
