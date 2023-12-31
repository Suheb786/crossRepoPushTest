import 'package:data/entity/remote/rj/get_destination/destination_response_entity.dart';
import 'package:data/entity/remote/rj/get_flight_details/flight_details_response_entity.dart';
import 'package:data/entity/remote/rj/trip/get_trip_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';
import 'package:retrofit/dio.dart';

abstract class RJRemoteDS {
  Future<HttpResponse<DestinationResponseEntity>> getDestinations(
      {required GetDestinationUseCaseParams params});

  Future<HttpResponse<GetTripResponseEntity>> getOneWayTripLink(
      {required GetOneWayTripLinkUseCaseParams params});

  Future<HttpResponse<GetTripResponseEntity>> getTwoWayTripLink(
      {required GetTwoWayTripLinkUseCaseParams params});

  Future<HttpResponse<FlightDetailsResponseEntity>> getFlightDetails({required String referenceNumber});

  Future<HttpResponse<ResponseEntity>> makeTicketPayment({
    required String referenceNumber,
    required String accountNo,
    required String amount,
    required String otpCode,
  });

  Future<HttpResponse<ResponseEntity>> rjOtpValidate();
}
