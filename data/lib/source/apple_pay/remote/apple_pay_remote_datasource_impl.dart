import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/apple_pay/add_user_wallet_detail_request_entity.dart';
import 'package:data/entity/remote/apple_pay/enroll_card_request_entity.dart';
import 'package:data/entity/remote/apple_pay/enroll_card_response_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/helper/antelop_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/apple_pay/apple_pay_datasource.dart';
import 'package:retrofit/dio.dart';

class AppPayRemoteDSImpl extends ApplePayRemoteDataSource {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;
  final AntelopHelper _antelopHelper;

  AppPayRemoteDSImpl(this._apiService, this._deviceInfoHelper, this._antelopHelper);

  @override
  Future<HttpResponse<ResponseEntity>> addUserWalletDetail(
      {required String walletId, required String entrustWalletId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addUserWalletDetail(AddUserWalletDetailRequestEntity(
        baseData: baseData.toJson(), getToken: true, walletId: walletId, entrustWalletId: entrustWalletId));
  }

  @override
  Future<HttpResponse<EnrollCardResponseEntity>> enrollCards(
      {required String walletId, required String cardId, required String cardType}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.enrollCards(EnrollCardRequestEntity(
        baseData: baseData.toJson(), getToken: true, walletId: walletId, cardType: cardType, cardId: cardId));
  }

  @override
  Future<HttpResponse<DashboardDataResponseEntity>> getAllCardListUseCase() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAllCardList(BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getUserWalletDetail() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getUserWalletDetail(BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<bool> initializeAntelopSDK() {
    return _antelopHelper.onInitializationFromNative();
  }

  @override
  Future<bool> getAntelopCardList() {
    return _antelopHelper.getAntelopCardList();
  }

  @override
  Future<bool> pushCardAntelopData(String cardId) {
    return _antelopHelper.pushCardToApplePay(cardId);
  }
}
