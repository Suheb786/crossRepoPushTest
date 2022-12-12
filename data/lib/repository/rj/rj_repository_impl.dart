import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/rj/rj_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';

class RJRepositoryImpl extends RJRepository {
  final RJRemoteDS _rjRemoteDS;

  RJRepositoryImpl(this._rjRemoteDS);

  @override
  Future<Either<NetworkError, DestinationResponse>> getDestinations(
      {required GetDestinationUseCaseParams params}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getDestinations(params: params),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetTripResponse>> getOneWayTripLink(
      {required GetOneWayTripLinkUseCaseParams params}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getOneWayTripLink(params: params),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetTripResponse>> getTwoWayTripLink(
      {required GetTwoWayTripLinkUseCaseParams params}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getTwoWayTripLink(params: params),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getFlightDetails({required String referenceNumber}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getFlightDetails(referenceNumber: referenceNumber),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> makeTicketPayment(
      {required String referenceNumber,
      required String accountNo,
      required String amount,
      required String otpCode}) async {
    final result = await safeApiCall(
      _rjRemoteDS.makeTicketPayment(
          referenceNumber: referenceNumber, accountNo: accountNo, amount: amount, otpCode: otpCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> rjOtpValidate() async {
    final result = await safeApiCall(
      _rjRemoteDS.rjOtpValidate(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
