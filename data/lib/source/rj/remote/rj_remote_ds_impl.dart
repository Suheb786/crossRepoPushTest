import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/rj/get_destination/destination_response_entity.dart';
import 'package:data/entity/remote/rj/get_destination/get_destination_request_entity.dart';
import 'package:data/entity/remote/rj/get_flight_details/get_flight_details_request_entity.dart';
import 'package:data/entity/remote/rj/get_flight_details/make_ticket_payment_request_entity.dart';
import 'package:data/entity/remote/rj/trip/get_one_way_trip_link_request_entity.dart';
import 'package:data/entity/remote/rj/trip/get_trip_response_entity.dart';
import 'package:data/entity/remote/rj/trip/get_two_way_trip_link_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/rj/rj_datasource.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';
import 'package:retrofit/dio.dart';

class RJRemoteDSImpl extends RJRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  RJRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<DestinationResponseEntity>> getDestinations(
      {required GetDestinationUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDestinations(GetDestinationRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        language: params.language,
        origin: params.origin,
        service: params.service));
  }

  @override
  Future<HttpResponse<GetTripResponseEntity>> getOneWayTripLink(
      {required GetOneWayTripLinkUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getOneWayTripLink(GetOneWayTripLinkRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        language: params.language,
        adults: params.adults,
        cabin: params.cabin,
        childs: params.childs,
        customerRef: params.customerRef,
        date1: params.date1,
        des: params.des,
        infants: params.infants,
        org: params.org,
        promoCode: params.promoCode,
        youths: params.youths));
  }

  @override
  Future<HttpResponse<GetTripResponseEntity>> getTwoWayTripLink(
      {required GetTwoWayTripLinkUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getTwoWayTripLink(GetTwoWayTripLinkRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        language: params.language,
        adults: params.adults,
        cabin: params.cabin,
        childs: params.childs,
        customerRef: params.customerRef,
        fromDate: params.fromDate,
        toDate: params.toDate,
        des: params.des,
        infants: params.infants,
        org: params.org,
        promoCode: params.promoCode,
        youths: params.youths));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getFlightDetails({required String referenceNumber}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getFlightDetails(GetFlightDetailsRequestEntity(
        baseData: baseData.toJson(), getToken: true, referenceNumber: referenceNumber));
  }

  @override
  Future<HttpResponse<ResponseEntity>> makeTicketPayment(
      {required String referenceNumber, required String accountNo, required String amount}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.makeTicketPayment(MakeTicketPaymentRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        referenceNumber: referenceNumber,
        accountNo: accountNo,
        amount: amount));
  }
}
