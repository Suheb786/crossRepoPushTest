import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/model/rj/get_flight_detail/flight_detail_response.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';

abstract class RJRepository {
  Future<Either<NetworkError, DestinationResponse>> getDestinations(
      {required GetDestinationUseCaseParams params});

  Future<Either<NetworkError, GetTripResponse>> getOneWayTripLink(
      {required GetOneWayTripLinkUseCaseParams params});

  Future<Either<NetworkError, GetTripResponse>> getTwoWayTripLink(
      {required GetTwoWayTripLinkUseCaseParams params});

  Future<Either<NetworkError, FlightDetailResponse>> getFlightDetails({required String referenceNumber});

  Future<Either<NetworkError, bool>> makeTicketPayment({
    required String referenceNumber,
    required String accountNo,
    required String amount,
    required String otpCode,
  });

  Future<Either<NetworkError, bool>> rjOtpValidate();
}
