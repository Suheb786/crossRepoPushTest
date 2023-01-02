import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/payment/check_send_money_request_entity.dart';
import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_request_entity.dart';
import 'package:data/entity/remote/payment/pay_back_credit_card_request_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_request_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_response_entity.dart';
import 'package:data/entity/remote/payment/qr/generate_qr_request_entity.dart';
import 'package:data/entity/remote/payment/qr/transfer_qr_request_entity.dart';
import 'package:data/entity/remote/payment/qr/verify_qr_request_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_content_response_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_api_no_otp_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_success_response_entity.dart';
import 'package:data/entity/remote/purpose/purpose_request_entity.dart';
import 'package:data/entity/remote/purpose/purpose_response_entity.dart';
import 'package:data/entity/remote/qr/qr_response_entity.dart';
import 'package:data/entity/remote/qr/qr_transfer_response_entity.dart';
import 'package:data/entity/remote/qr/verify_qr_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:retrofit/dio.dart';

class PaymentRemoteDataSourceImpl extends PaymentRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper deviceInfoHelper;

  PaymentRemoteDataSourceImpl(this._apiService, this.deviceInfoHelper);

  @override
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>> getAccountByAlias(
      String value, String currency) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccountByAlias(GetAccountByAliasRequestEntity(
        baseData: baseData.toJson(), value: value, currency: currency, getToken: true));
  }

  @override
  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      {String? toAccount, num? toAmount}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.checkSendMoney(CheckSendMoneyRequestEntity(
        baseData: baseData.toJson(), toAccount: toAccount, toAmount: toAmount, getToken: true));
  }

  @override
  Future<HttpResponse<TransferSuccessResponseEntity>> transfer(
      {String? beneficiaryId,
        String? otpCode,
        String? transferType,
        String? beneficiaryImage,
        bool? isFriend,
        num? toAmount,
        num? localEq,
        String? memo,
        String? toAccount,
        String? nickName,
        String? detCustomerType,
        String? type,
        String? recipientName,
        String? recipientAddress}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.transfer(TransferRequestEntity(
        baseData: baseData.toJson(),
        toAmount: toAmount!,
        toAccount: toAccount!,
        beneficiaryId: beneficiaryId,
        beneficiaryImage: (beneficiaryImage!.isNotEmpty && beneficiaryImage != null)
            ? ImageUtils.convertToBase64(beneficiaryImage)
            : '',
        otpCode: otpCode,
        isFriend: isFriend!,
        localEq: localEq!,
        memo: memo!,
        nickName: nickName,
        transferType: transferType!,
        getToken: true,
        detCustomerType: detCustomerType,
        type: type,
        recipientName: recipientName,
        recipientAddress: recipientAddress));
  }

  @override
  Future<HttpResponse<RequestToPayContentResponseEntity>> requestToPay(
      String ctgyPurp,
      num amount,
      String dbtrBic,
      String dbtrAcct,
      String dbtrName,
      String memo,
      bool? isFriend,
      String? image,
      String? nickName,
      String? detCustomerType,
      String? type,
      String? alias,
      String? dbtrSurname,
      String? addressCity,
      String? addressCountry) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.requestToPay(RequestToPayRequestEntity(
        ctgyPurp: ctgyPurp,
        amount: amount,
        memo: memo,
        nickName: nickName,
        baseData: baseData.toJson(),
        dbtrBic: dbtrBic,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        isFriend: isFriend,
        beneImage: (image!.isNotEmpty && image != null) ? ImageUtils.convertToBase64(image) : '',
        detCustomerType: detCustomerType,
        type: type,
        addressCountry: addressCountry,
        addressCity: addressCity,
        alias: alias,
        dbtrSurname: dbtrSurname));
  }

  @override
  Future<HttpResponse<ResponseEntity>> transferVerify() async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.transferVerify(BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<PurposeResponseEntity>> getPurpose(
      String toAccount, String transferType, String detCustomerType, String type) async {
    print("transfer purpose : ${detCustomerType} + ${type}");
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.getPurpose(PurposeRequestEntity(
        baseData: baseData.toJson(),
        toAccount: toAccount,
        transferType: transferType,
        getToken: true,
        detCustomerType: detCustomerType,
        type: type));
  }

  @override
  Future<HttpResponse<PaymentActivityResponseEntity>> getPaymentActivity({int? filterDays}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.getPaymentActivity(
        PaymentActivityRequestEntity(baseData: baseData.toJson(), getToken: true, filterDays: filterDays));
  }

  @override
  Future<HttpResponse<ResponseEntity>> payBackCreditCard({String? secureCode, String? payBackAmount}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.payBackCreditCard(PayBackCreditCardRequestEntity(
        baseData: baseData.toJson(), getToken: true, payBackAmount: payBackAmount, secureCode: secureCode));
  }

  @override
  Future<HttpResponse<TransferSuccessResponseEntity>> transferAPINoOtp(
      {String? beneficiaryId,
      String? transferType,
      String? beneficiaryImage,
      bool? isFriend,
      num? toAmount,
      num? localEq,
      String? memo,
      String? toAccount,
      String? nickName,
      String? detCustomerType,
      String? type}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.transferAPINoOtp(TransferApiNoOtpRequestEntity(
        baseData: baseData.toJson(),
        toAmount: toAmount!,
        toAccount: toAccount!,
        beneficiaryId: beneficiaryId,
        beneficiaryImage: (beneficiaryImage!.isNotEmpty && beneficiaryImage != null)
            ? ImageUtils.convertToBase64(beneficiaryImage)
            : '',
        isFriend: isFriend!,
        localEq: localEq!,
        memo: memo!,
        nickName: nickName,
        transferType: transferType!,
        getToken: true,
        detCustomerType: detCustomerType,
        type: type));
  }

  @override
  Future<HttpResponse<QRResponseEntity>> generateQR({required String amount}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService
        .generateQR(GenerateQRRequestEntity(baseData: baseData.toJson(), getToken: true, amount: amount));
  }

  @override
  Future<HttpResponse<QRTransferResponseEntity>> transferQR(
      {required String requestId, required String toAmount, required String toAccount}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.transferQR(TransferQRRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        qrRequestId: requestId,
        toAccount: toAccount,
        toAmount: toAmount));
  }

  @override
  Future<HttpResponse<VerifyQRResponseEntity>> verifyQR(
      {required String requestId, required String source}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyQR(VerifyQRRequestEntity(
        baseData: baseData.toJson(), source: source, getToken: true, qrRequestId: requestId));
  }
}
